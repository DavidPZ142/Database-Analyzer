package utils

import (
	"database/sql"
	"fmt"
	"log"
	"regexp"
)

var InfoTypes = map[string]*regexp.Regexp{
	"USERNAME":               regexp.MustCompile(`(?i)^(user_?name|login)$`),
	"EMAIL_ADDRESS":          regexp.MustCompile(`(?i)^(email|e-?mail)$`),
	"CREDIT_CARD_NUMBER":     regexp.MustCompile(`(?i)^(credit_?card|cc_?number|card_?number|cvv)$`),
	"FIRST_NAME":             regexp.MustCompile(`(?i)^(first_?name|name|)$`),
	"LAST_NAME":              regexp.MustCompile(`(?i)^(last_?name|surname)$`),
	"PHONE_NUMBER":           regexp.MustCompile(`(?i)^(phone|telephone|mobile|cellphone)$`),
	"IP_ADDRESS":             regexp.MustCompile(`(?i)^(ip_?address|ip)$`),
	"DATE_OF_BIRTH":          regexp.MustCompile(`(?i)^(dob|date_?of_?birth)$`),
	"SOCIAL_SECURITY_NUMBER": regexp.MustCompile(`(?i)^(ssn|social_?security)$`),
	"POSTAL_CODE":            regexp.MustCompile(`(?i)^(postal_?code|zip_?code|street)$`),
	"PLACE":                  regexp.MustCompile(`(?i)^(city|state|country)$`),
	"PAYMENT_METHOD":         regexp.MustCompile(`(?i)^(payment_?method)$`),
}

func CreditCardDataSample(db *sql.DB, schemaName, tableName, columnName string) (int, error) {
	query := fmt.Sprintf(`
        SELECT COUNT(*) as count
        FROM %s.%s
        WHERE %s REGEXP '^[0-9]{13,16}$'
        LIMIT 10;
    `, schemaName, tableName, columnName)

	var count int
	err := db.QueryRow(query).Scan(&count)
	if err != nil {
		log.Println("A error ocurred execute Data sample query %w", err)
		return 0, err
	}
	return count, nil
}

func EmailDataSample(db *sql.DB, schemaName, tableName, columnName string) (int, error) {
	query := fmt.Sprintf(`
    SELECT COUNT(*) as count
    FROM %s.%s
    WHERE %s REGEXP '^[a-zA-Z0-9._%%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$'
    LIMIT 10;
`, schemaName, tableName, columnName)

	var count int
	err := db.QueryRow(query).Scan(&count)
	if err != nil {
		log.Println("A error ocurred execute Data sample query %w", err)
		return 0, err
	}
	return count, nil
}
