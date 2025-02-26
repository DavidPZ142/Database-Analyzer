package models

type Report struct {
	ID     int                  `json:"id" bson:"id"`
	Tables map[string]TableInfo `json:"tables" bson:"tables"`
}
