package services_test

import (
	"Database_Analyzer/models"
	"Database_Analyzer/services"
	"strconv"
	"strings"
	"testing"
)

func TestGenerateScanSummary(t *testing.T) {
	report := models.Report{
		ID: 1,
		Tables: map[string]models.TableInfo{
			"users": {
				Columns: map[string]models.ColumnInfo{
					"name":     {InformationType: "USERNAME"},
					"email":    {InformationType: "EMAIL_ADDRESS"},
					"password": {InformationType: "N/A"},
				},
			},
			"orders": {
				Columns: map[string]models.ColumnInfo{
					"order_id":   {InformationType: "N/A"},
					"user_id":    {InformationType: "N/A"},
					"pay":        {InformationType: "PAYMENT_METHOD"},
					"created_at": {InformationType: "N/A"},
				},
			},
		},
	}

	result, err := services.GenerateScanSummary(report)
	if err != nil {
		t.Fatalf("An error occurred while generating the summary: %v", err)
	}

	if !strings.Contains(result, "<p><strong>Total Tables:</strong> 2</p>") {
		t.Errorf("The result does not contain the expected total number of tables.")
	}

	if !strings.Contains(result, "<p><strong>Total Columns:</strong> 7</p>") {
		t.Errorf("The result does not contain the expected total number of columns.")
	}

	expectedDataTypes := map[string]int{
		"N/A":            4,
		"USERNAME":       1,
		"EMAIL_ADDRESS":  1,
		"PAYMENT_METHOD": 1,
	}

	for dataType, count := range expectedDataTypes {
		countStr := strconv.Itoa(count)
		if !strings.Contains(result, "<td>"+dataType+"</td>") || !strings.Contains(result, "<td>"+countStr+"</td>") {
			t.Errorf("El resultado no contiene el tipo de dato '%s' con la cantidad esperada de %d", dataType, count)
		}
	}
}
