package controllers

import (
	"net/http"

	"Database_Analyzer/models"
	"Database_Analyzer/services"

	"github.com/gin-gonic/gin"
)

func HandleDatabaseConnection(c *gin.Context) {

	var dbConn models.DatabaseConnection

	if err := c.ShouldBindJSON(&dbConn); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"Error": err.Error()})
		return
	}

	if err := services.SaveDatabaseConfiguration(&dbConn); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error saving the db connection"})
	}

	c.JSON(http.StatusOK, dbConn)

}
