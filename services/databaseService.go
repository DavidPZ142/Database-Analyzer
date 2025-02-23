package services

import (
	"Database_Analyzer/config"
	"Database_Analyzer/models"
	"Database_Analyzer/utils"
	"context"
	"fmt"

	"go.mongodb.org/mongo-driver/bson"

	"time"
)

func SaveDatabaseConfiguration(dbConn *models.DatabaseConfiguration) (int, error) {

	newID, err := GetNextID("DatabaseConfiguration")
	if err != nil {
		return 0, fmt.Errorf("error generando ID: %v", err)
	}
	dbConn.ID = newID

	hashedPassword, err := utils.HashPassword(dbConn.Password)
	if err != nil {
		return 0, err
	}

	dbConn.Password = hashedPassword

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
		return nil, err
	}

	return &dbConfig, nil
}
