package utils

import (
	"Database_Analyzer/config"
	"Database_Analyzer/models"
	"context"
	"database/sql"
	"fmt"
	"log"
	"regexp"
	"time"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
)

var InfoTypes = map[string]*regexp.Regexp{
	"USERNAME":               regexp.MustCompile(`(?i)^(user_?name|login)$`),
	"EMAIL_ADDRESS":          regexp.MustCompile(`(?i)^(email|e-?mail)$`),
	"CREDIT_CARD_NUMBER":     regexp.MustCompile(`(?i)^(credit_?card|cc_?number|card_?number|cvv)$`),
	"FIRST_NAME":             regexp.MustCompile(`(?i)^(first_?name|name|)$`),
	"LAST_NAME":              regexp.MustCompile(`(?i)^(last_?name|surname)$`),
	"PHONE_NUMBER":           regexp.MustCompile(`(?i)^(phone|telephone|mobile|cellphone)$`),
	"IP_ADDRESS":             regexp.MustCompile(`(?i)^(ip_?address|ip)$`),
	"DATE_OF_BIRTH":          regexp.MustCompile(`(?i)^(dob|date_?of_?birth)$`),
	"SOCIAL_SECURITY_NUMBER": regexp.MustCompile(`(?i)^(ssn|social_?security)$`),
	"POSTAL_CODE":            regexp.MustCompile(`(?i)^(postal_?code|zip_?code|street)$`),
	"PLACE":                  regexp.MustCompile(`(?i)^(city|state|country)$`),
	"PAYMENT_METHOD":         regexp.MustCompile(`(?i)^(payment_?method)$`),
}

func GetInfoTypes(collection *mongo.Collection) (map[string]*regexp.Regexp, error) {
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()
	cursor, err := collection.Find(ctx, bson.M{})
	if err != nil {
		log.Printf("error obtain info types %v", err)
	}
	defer cursor.Close(ctx)
	infoTypesMap := make(map[string]*regexp.Regexp)
	for cursor.Next(ctx) {
		var infoType models.InfoType
		if err := cursor.Decode(&infoType); err != nil {
			log.Printf("error decode info types %v", err)
		}

		re, err := regexp.Compile(infoType.Regex)
		if err != nil {
			log.Printf("Error compilando la expresión regular para el tipo %s: %v", infoType.Type, err)
			continue
		}

		infoTypesMap[infoType.Type] = re
	}

	if err := cursor.Err(); err != nil {
		log.Printf("error decode info types %s", err)
	}
	return infoTypesMap, nil
}

func CreditCardDataSample(db *sql.DB, schemaName, tableName, columnName string) (int, error) {
	query := fmt.Sprintf(`
        SELECT COUNT(*) as count
        FROM %s.%s
        WHERE %s REGEXP '^[0-9]{13,16}$'
        LIMIT 10;
    `, schemaName, tableName, columnName)

	var count int
	err := db.QueryRow(query).Scan(&count)
	if err != nil {
		log.Println("A error ocurred execute Data sample query %w", err)
		return 0, err
	}
	return count, nil
}

func EmailDataSample(db *sql.DB, schemaName, tableName, columnName string) (int, error) {
	query := fmt.Sprintf(`
    SELECT COUNT(*) as count
    FROM %s.%s
    WHERE %s REGEXP '^[a-zA-Z0-9._%%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$'
    LIMIT 10;
`, schemaName, tableName, columnName)

	var count int
	err := db.QueryRow(query).Scan(&count)
	if err != nil {
		log.Println("A error ocurred execute Data sample query %w", err)
		return 0, err
	}
	return count, nil
}

func DetectInfoType(columnName string, InfoTypes map[string]*regexp.Regexp) string {
	for infoType, regex := range InfoTypes {
		if regex.MatchString(columnName) {
			return infoType
		}
	}
	return "N/A"
}

func SaveInfoType(infoType *models.InfoType) error {
	collection := config.GetDatabase().Collection("InfoTypes")
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	_, err := collection.InsertOne(ctx, infoType)
	if err != nil {
		log.Printf("An error ocurred trying save a infoType %v", err)
		return err
	}
	log.Printf("Save infoType : %d", infoType.Type)
	return nil
}
