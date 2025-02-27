package routes

import (
	"Database_Analyzer/controllers"
	"Database_Analyzer/middleware"

	"github.com/gin-gonic/gin"
)

func SetupRoutes(router *gin.Engine) {

	router.POST("/login", controllers.Login)
	router.POST("/register", controllers.SaveUser)

	dbGroup := router.Group("/api/v1/database")
	dbGroup.Use(middleware.AuthMiddleware())
	{
		dbGroup.POST("/", controllers.SaveDatabaseConfiguration)
		dbGroup.POST("/scan/:id", controllers.ScanDatabaseByID)
		dbGroup.GET("/scan/:id", controllers.GetReportByID)
	}
}
