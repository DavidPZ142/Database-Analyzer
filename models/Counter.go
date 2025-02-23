package models

type Counter struct {
	ID       string `bson:"_id"`
	Sequence int    `bson:"sequence"`
}
