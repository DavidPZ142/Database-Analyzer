package services

import (
	"Database_Analyzer/config"
	"Database_Analyzer/models"
	"Database_Analyzer/utils"
	"context"
	"database/sql"
	"errors"
	"fmt"
	"log"

	_ "regexp"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo/options"

	"time"
)

var ErrInsertDocument = errors.New("error saving document")
var ErrConfigurationNotFound = errors.New("database configuration not found")
var ErrReportNotFound = errors.New("database report not found")
var ErrUserWithoutPrivilegies = errors.New("the user hasn't privilegies to execute this query")
var ErrDatabaseFailed = errors.New("database service has failed")
var ErrEnconding = errors.New("encoding failed")

const query = `
		SELECT TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME
		FROM INFORMATION_SCHEMA.COLUMNS
		where TABLE_SCHEMA not in ('performance_schema' ,'mysql', 'information_schema', 'sys')`

func SaveDatabaseConfiguration(dbConn *models.DatabaseConfiguration) (int, error) {

	newID, err := GetNextID("DatabaseConfiguration")
	if err != nil {
		log.Println("❌ Errror trying generate ID:", err)
		return 0, ErrInsertDocument
	}
	dbConn.ID = newID

	encodePassword, err := utils.Encrypt(dbConn.Password)
	if err != nil {
		log.Println("❌ Error Encoding password :", err)
		return 0, ErrEnconding
	}

	dbConn.Password = encodePassword

	collection := config.GetDatabase().Collection("DatabaseConfiguration")
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	_, err = collection.InsertOne(ctx, dbConn)
	if err != nil {
		return 0, ErrInsertDocument
	}
	log.Printf("Save database with id : %d", newID)
	return dbConn.ID, nil
}

func ScanDatabaseByID(id int) error {
	databaseConfig, err := GetDatabaseByID(id)
	if err != nil {
		return err
	}
	log.Printf("Start to scan database with 1 %d", id)
	DBMySQL, err := ConnectDatabaseMysql(databaseConfig)
	if err != nil {
		return err
	}
	defer DBMySQL.Close()

	report, err := GenerateReport(DBMySQL, id)
	if err != nil {
		return err
	}
	collection := config.GetDatabase().Collection("DatabaseReport")
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	_, err = collection.InsertOne(ctx, report)
	if err != nil {
		return ErrInsertDocument
	}
	return nil
}

func GenerateReport(db *sql.DB, id int) (*models.Report, error) {
	infoTypes, err := utils.GetInfoTypes(config.GetDatabase().Collection("InfoTypes"))
	if err != nil {
		log.Printf("Error obtain info types from mongo %v", query)
		return nil, err
	}
	rows, err := db.Query(query)
	if err != nil {
		log.Println("Error running query")
		return nil, err
	}
	if !rows.Next() {
		log.Printf("User without privilegies to execute this query %v", query)
		return nil, ErrUserWithoutPrivilegies
	}
	report := &models.Report{
		ID:        id,
		CreatedAt: time.Now(),
		Tables:    make(map[string]models.TableInfo),
	}
	for rows.Next() {
		var schemaName, tableName, columnName string
		if err := rows.Scan(&schemaName, &tableName, &columnName); err != nil {
			log.Println("Error scanning row:", err)
			continue
		}

		infoType := utils.DetectInfoType(columnName, infoTypes)
		if infoType == "N/A" {
			count, err := utils.CreditCardDataSample(db, schemaName, tableName, columnName)
			if err != nil {
				log.Printf("Error counting matching credit card rows for %s.%s.%s: %v", schemaName, tableName, columnName, err)
			} else if count > 1 {
				infoType = "CREDIT_CARD"
			}
		}
		if infoType == "N/A" {
			count, err := utils.EmailDataSample(db, schemaName, tableName, columnName)
			if err != nil {
				log.Printf("Error counting matching email rows for %s.%s.%s: %v", schemaName, tableName, columnName, err)
			} else if count > 1 {
				infoType = "EMAIL"
			}
		}

		fullTableName := fmt.Sprintf("%s.%s", schemaName, tableName)
		table, exists := report.Tables[fullTableName]
		if !exists {
			table = models.TableInfo{
				Columns: make(map[string]models.ColumnInfo),
			}
		}

		table.Columns[columnName] = models.ColumnInfo{
			InformationType: infoType,
		}
		report.Tables[fullTableName] = table
	}
	if err := rows.Err(); err != nil {
		log.Printf("error during row iteration: %v", err)
		return nil, err
	}

	log.Printf("Successfully scanned database with id %d", id)
	return report, nil
}

func GetDatabaseByID(id int) (*models.DatabaseConfiguration, error) {
	collection := config.GetDatabase().Collection("DatabaseConfiguration")

	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	var dbConfig models.DatabaseConfiguration
	filter := bson.M{"id": id}

	err := collection.FindOne(ctx, filter).Decode(&dbConfig)
	if err != nil {
		log.Println("❌ Error Getting configuration :", err)
		return nil, ErrConfigurationNotFound
	}

	return &dbConfig, nil
}

func GetReportByID(id int) (*models.Report, error) {
	collection := config.GetDatabase().Collection("DatabaseReport")

	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	var report models.Report
	filter := bson.M{"id": id}
	opts := options.FindOne().SetSort(bson.D{{Key: "_id", Value: -1}})

	err := collection.FindOne(ctx, filter, opts).Decode(&report)
	if err != nil {
		log.Println("❌ Error Getting configuration :", err)
		return nil, ErrReportNotFound
	}

	return &report, nil
}

func ConnectDatabaseMysql(dbConfig *models.DatabaseConfiguration) (*sql.DB, error) {
	decryptedPassword, err := utils.Decrypt(dbConfig.Password)
	if err != nil {
		log.Println("❌ Password cracking failed:", err)
		return nil, ErrEnconding
	}

	err = config.ConnectMySQL(dbConfig.Host, dbConfig.Port, dbConfig.Username, decryptedPassword)
	if err != nil {
		log.Println("❌ Could not establish a connection to MySQL:", err)
		return nil, ErrDatabaseFailed
	}
	return config.DBMySQL, nil
}
