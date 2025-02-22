package controllers

import (
	"net/http"

	"Database_Analyzer/models"

	"github.com/gin-gonic/gin"
)

func HandlePost(c *gin.Context) {
	var requestBody models.RequestBody

	if err := c.ShouldBindJSON(&requestBody); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"name":    requestBody.Name,
		"message": requestBody.Message,
	})
}
