package models

type DatabaseConfiguration struct {
	ID       int    `json:"id" bson:"id"`
	Host     string `json:"host" bson:"host"`
	Port     int    `json:"port" bson:"port"`
	Username string `json:"username" bson:"username"`
	Password string `json:"password" bson:"password"`
}
