package main

import (
	"log"

	"Database_Analyzer/config"
	"Database_Analyzer/routes"

	"github.com/gin-gonic/gin"
)

func main() {
	err := config.ConnectDatabase()
	if err != nil {
		log.Println("🔥 Critic error to conectar con MongoDB")
		panic(err)
	}
	router := gin.Default()

	routes.SetupRoutes(router)

	router.Run(":8080")
}
