package models

type InfoType struct {
	Type  string `bson:"type"`
	Regex string `bson:"regex"`
}
