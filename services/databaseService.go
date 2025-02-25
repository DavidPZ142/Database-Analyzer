package services

import (
	"Database_Analyzer/config"
	"Database_Analyzer/models"
	"Database_Analyzer/utils"
	"context"
	"errors"
	"log"

	"go.mongodb.org/mongo-driver/bson"

	"time"
)

var ErrInsertDocument = errors.New("error saving document")
var ErrConfigurationNotFound = errors.New("database configuration not found")
var ErrDatabaseFailed = errors.New("database service has failed")
var ErrEnconding = errors.New("encoding failed")

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
	return dbConn.ID, nil
}

func ScanDatabaseByID(id int) error {
	databaseConfig, err := GetDatabaseByID(id)
	if err != nil {
		return err
	}
	return ConnectDatabaseMysql(databaseConfig)
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

func ConnectDatabaseMysql(dbConfig *models.DatabaseConfiguration) error {
	decryptedPassword, err := utils.Decrypt(dbConfig.Password)
	if err != nil {
		log.Println("❌ Password cracking failed:", err)
		return ErrEnconding
	}

	err = config.ConnectMySQL(dbConfig.Host, dbConfig.Port, dbConfig.Username, decryptedPassword)
	if err != nil {
		log.Println("❌ Could not establish a connection to MySQL:", err)
		return ErrDatabaseFailed
	}
	return nil
}
