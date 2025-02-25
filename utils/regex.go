package utils

import "regexp"

var InfoTypes = map[string]*regexp.Regexp{
	"USERNAME":               regexp.MustCompile(`(?i)^(user_?name|login|usuario)$`),
	"EMAIL_ADDRESS":          regexp.MustCompile(`(?i)^(email|e-?mail|correo(_electronico)?)$`),
	"CREDIT_CARD_NUMBER":     regexp.MustCompile(`(?i)^(credit_?card|cc_?number|card_?number|numero_?tarjeta)$`),
	"FIRST_NAME":             regexp.MustCompile(`(?i)^(first_?name|nombre|nombre_?de_?pila)$`),
	"LAST_NAME":              regexp.MustCompile(`(?i)^(last_?name|surname|apellido)$`),
	"PHONE_NUMBER":           regexp.MustCompile(`(?i)^(phone|telephone|telefono|num_?telefono)$`),
	"IP_ADDRESS":             regexp.MustCompile(`(?i)^(ip_?address|direccion_?ip)$`),
	"DATE_OF_BIRTH":          regexp.MustCompile(`(?i)^(dob|date_?of_?birth|fecha_?nacimiento)$`),
	"SOCIAL_SECURITY_NUMBER": regexp.MustCompile(`(?i)^(ssn|social_?security|numero_?seguridad_?social)$`),
	"POSTAL_CODE":            regexp.MustCompile(`(?i)^(postal_?code|zip_?code|codigo_?postal)$`),
	"PLACE":                  regexp.MustCompile(`(?i)^(city|state|country)$`),
	"PAYMENT_METHOD":         regexp.MustCompile(`(?i)^(payment_?method)$`),
}
