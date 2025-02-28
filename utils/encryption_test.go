package utils_test

import (
	"Database_Analyzer/utils"
	"testing"
)

func TestEncryptDecrypt(t *testing.T) {
	testKey := "12345678901234567890123456789012"

	t.Setenv("ENCRYPTION_KEY", testKey)

	plainText := "Texto de prueba"

	encryptedText, err := utils.Encrypt(plainText)
	if err != nil {
		t.Errorf("Error when encrypting text: %v", err)
	}

	decryptedText, err := utils.Decrypt(encryptedText)
	if err != nil {
		t.Errorf("Error deciphering the text: %v", err)
	}

	if decryptedText != plainText {
		t.Errorf("Decrypted text %s does not match original text %s ", decryptedText, plainText)
	}
}
