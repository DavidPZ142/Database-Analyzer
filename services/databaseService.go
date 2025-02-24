package services

import (
	"Database_Analyzer/config"
	"Database_Analyzer/models"
	"Database_Analyzer/utils"
	"context"
	"fmt"
	"log"

	"go.mongodb.org/mongo-driver/bson"

	"time"
)

func SaveDatabaseConfiguration(dbConn *models.DatabaseConfiguration) (int, error) {

	newID, err := GetNextID("DatabaseConfiguration")
	if err != nil {
		log.Println("❌ Errror trying generate ID:", err)
		return 0, fmt.Errorf("error trying generate ID: %v", err)
	}
	dbConn.ID = newID

	encodePassword, err := utils.Encrypt(dbConn.Password)
	if err != nil {
		log.Println("❌ Error Encoding password :", err)
		return 0, err
	}

	dbConn.Password = encodePassword

	collection := config.GetDatabase().Collection("DatabaseConfiguration")
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	_, err = collection.InsertOne(ctx, dbConn)
	if err != nil {
		return 0, err
	}
	return dbConn.ID, nil
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
		return nil, err
	}

	decodePassword, err := utils.Decrypt(dbConfig.Password)
	if err != nil {
		return nil, err
	}
	dbConfig.Password = decodePassword

	return &dbConfig, nil
}
