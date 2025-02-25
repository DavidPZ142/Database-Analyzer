package config

import (
	"database/sql"
	"fmt"
	"log"

	_ "github.com/go-sql-driver/mysql"
)

var DBMySQL *sql.DB

func ConnectMySQL(host string, port int, user string, password string) error {
	dsn := fmt.Sprintf("%s:%s@tcp(%s:%d)/?timeout=10s", user, password, host, port)

	db, err := sql.Open("mysql", dsn)
	if err != nil {
		log.Println("❌ Error opening MySQL connection:", err)
		return err
	}

	err = db.Ping()
	if err != nil {
		log.Println("❌ Error connecting to MySQL:", err)
		return err
	}

	log.Println("Connect to Mysql")
	DBMySQL = db
	return nil
}

func GetMySQLConnection() *sql.DB {

	return DBMySQL
}
