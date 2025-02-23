package config

import (
	"context"
	"log"
	"os"
	"time"

	"github.com/joho/godotenv"

	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

var MongoClient *mongo.Client

func ConnectDatabase() error {
	if err := godotenv.Load(); err != nil {
		log.Println("⚠️ Could not load .env file, using system variables")
	}

	mongoURI := os.Getenv("MONGO_URI")
	if mongoURI == "" {
		log.Fatal("❌ MONGO_URI is not defined in the environment")
	}
	clientOptions := options.Client().ApplyURI(mongoURI)

	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	client, err := mongo.Connect(ctx, clientOptions)
	if err != nil {
		log.Println("❌ Error trying to connect to MongoDB:", err)
		return err
	}

	err = client.Ping(ctx, nil)
	if err != nil {
		log.Println("❌ Cannot to conect to MongoDB:", err)
		return err
	}

	log.Println("✅ Connect to MongoDB")
	MongoClient = client
	return nil
}

func GetDatabase() *mongo.Database {
	dbName := os.Getenv("MONGO_DATABASE")
	if dbName == "" {
		log.Fatal("❌ MONGO_DATABASE is not defined in the environment")
	}
	return MongoClient.Database(dbName)
}
