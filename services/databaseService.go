package services

import (
	"Database_Analyzer/models"
	"Database_Analyzer/utils"

	"github.com/google/uuid"
)

func SaveDatabaseConfiguration(dbConn *models.DatabaseConnection) error {

	dbConn.ID = GenerateUUID()
	hashedPassword, err := utils.HashPassword(dbConn.Password)
	if err != nil {
		return err
	}

	dbConn.Password = hashedPassword
	return nil

}

func GenerateUUID() string {
	return uuid.New().String()
}
