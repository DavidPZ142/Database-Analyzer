package services

import (
	"Database_Analyzer/config"
	"Database_Analyzer/models"
	"Database_Analyzer/utils"
	"context"
	"log"
	"time"

	"go.mongodb.org/mongo-driver/bson"
)

func SaveUser(user models.LoginCredentials) error {
	encodePassword, err := utils.Encrypt(user.Password)
	if err != nil {
		log.Println("❌ Error Encoding password :", err)
		return ErrEnconding
	}

	user.Password = encodePassword

	collection := config.GetDatabase().Collection("Users")
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	_, err = collection.InsertOne(ctx, user)
	if err != nil {
		return err
	}
	return nil

}

func IsValidCredentials(credentials models.LoginCredentials) bool {
	collection := config.GetDatabase().Collection("Users")

	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()
	var mongoCredentials models.LoginCredentials
	filter := bson.M{"userName": credentials.Username}
	err := collection.FindOne(ctx, filter).Decode(&mongoCredentials)
	if err != nil {
		log.Println("❌ Error Getting user :", err)
		return false
	}
	decodedPassword, err := utils.Decrypt(mongoCredentials.Password)
	if err != nil {
		log.Println("❌ Error decoding password :", err)
		return false
	}
	return (credentials.Password == decodedPassword)
}
