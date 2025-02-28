package utils_test

import (
	"Database_Analyzer/utils"
	"fmt"
	"regexp"
	"testing"

	"github.com/DATA-DOG/go-sqlmock"
)

type testCase struct {
	columnName string
	expected   string
}

func TestCreditCardDataSample(t *testing.T) {
	db, mock, err := sqlmock.New(sqlmock.QueryMatcherOption(sqlmock.QueryMatcherEqual))
	if err != nil {
		t.Fatalf("Error creating the database mock: %v", err)
	}
	defer db.Close()

	query := `
        SELECT COUNT(*) as count
        FROM test_schema.test_table
        WHERE credit_card REGEXP '^[0-9]{13,16}$'
        LIMIT 10;
    `
	rows := sqlmock.NewRows([]string{"count"}).AddRow(5)
	mock.ExpectQuery(query).WillReturnRows(rows)

	count, err := utils.CreditCardDataSample(db, "test_schema", "test_table", "credit_card")
	if err != nil {
		t.Errorf("Unexpected error: %v", err)
	}

	if count != 5 {
		t.Errorf("Incorrect result: 5 was expected, but obtained %d", count)
	}

	if err := mock.ExpectationsWereMet(); err != nil {
		t.Errorf("Expectations were not fulfilled: %v", err)
	}
}

func TestEmailDataSample(t *testing.T) {
	db, mock, err := sqlmock.New()
	if err != nil {
		t.Fatalf("Error creating the database mock: %v", err)
	}
	defer db.Close()

	schemaName := "test_schema"
	tableName := "test_table"
	columnName := "email"

	expectedQuery := fmt.Sprintf(`
        SELECT COUNT(*) as count
        FROM %s.%s
        WHERE %s REGEXP '^[a-zA-Z0-9._%%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$'
        LIMIT 10;
    `, schemaName, tableName, columnName)

	expectedQuery = regexp.QuoteMeta(expectedQuery)

	rows := sqlmock.NewRows([]string{"count"}).AddRow(3)
	mock.ExpectQuery(expectedQuery).WillReturnRows(rows)

	count, err := utils.EmailDataSample(db, schemaName, tableName, columnName)
	if err != nil {
		t.Errorf("Unexpected error: %v", err)
	}

	if count != 3 {
		t.Errorf("Incorrect result: expected 3, but got %d", count)
	}

	if err := mock.ExpectationsWereMet(); err != nil {
		t.Errorf("Expectations were not met: %v", err)
	}
}

func TestDetectInfoType(t *testing.T) {
	testCases := []testCase{
		{"username", "USERNAME"},
		{"email", "EMAIL_ADDRESS"},
		{"credit_card", "CREDIT_CARD_NUMBER"},
		{"first_name", "FIRST_NAME"},
		{"last_name", "LAST_NAME"},
		{"phone", "PHONE_NUMBER"},
		{"ip_address", "IP_ADDRESS"},
		{"dob", "DATE_OF_BIRTH"},
		{"ssn", "SOCIAL_SECURITY_NUMBER"},
		{"postal_code", "POSTAL_CODE"},
		{"city", "PLACE"},
		{"payment_method", "PAYMENT_METHOD"},
		{"unknown_column", "N/A"},
	}

	for _, tc := range testCases {
		result := utils.DetectInfoType(tc.columnName)
		if result != tc.expected {
			t.Errorf("Para columnName '%s', se esperaba '%s' pero se obtuvo '%s'", tc.columnName, tc.expected, result)
		}
	}
}
