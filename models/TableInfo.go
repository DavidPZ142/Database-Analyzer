package models

type TableInfo struct {
	Columns map[string]ColumnInfo `json:"columns"`
}
