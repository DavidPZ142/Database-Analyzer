package services

import (
	"Database_Analyzer/config"
	"Database_Analyzer/models"
	"context"
	"fmt"
	"log"
	"time"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

func GetNextID(counterName string) (int, error) {
	collection := config.GetDatabase().Collection("Counters")
	filter := bson.M{"_id": counterName}
	update := bson.M{"$inc": bson.M{"sequence": 1}}
	opts := options.FindOneAndUpdate().SetUpsert(true).SetReturnDocument(options.After)
	var result models.Counter

	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	err := collection.FindOneAndUpdate(ctx, filter, update, opts).Decode(&result)
	if err != nil {
		if err == mongo.ErrNoDocuments {
			log.Println("⚠️Counter not found, creating new one")
			return 1, nil
		}
		return 0, fmt.Errorf("error getting the following ID: %v", err)
	}
	return result.Sequence, nil
}
