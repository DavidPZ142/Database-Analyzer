package models

type LoginCredentials struct {
	Username string `json:"username" binding:"required" bson:"userName"`
	Password string `json:"password" binding:"required" bson:"password"`
}
