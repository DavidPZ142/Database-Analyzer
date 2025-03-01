package models

import "time"

type Report struct {
	ID        int                  `json:"id" bson:"id"`
	CreatedAt time.Time            `json:"createdAt" bson:"createdAt"`
	Tables    map[string]TableInfo `json:"tables" bson:"tables"`
}
