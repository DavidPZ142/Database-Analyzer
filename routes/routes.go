package routes

import (
	"Database_Analyzer/controllers"
	"net/http"

	"github.com/gin-gonic/gin"
)

func SetupRoutes(router *gin.Engine) {
	router.GET("/get", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{"message": "Este es un método GET"})
	})

	router.POST("/api/v1/database", controllers.HandleDatabaseConnection)
}
