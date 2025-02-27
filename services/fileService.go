package services

import (
	"Database_Analyzer/models"
	"bytes"
	"html/template"
	"log"
)

const htmlTemplate = `
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Scan Summary</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        table { width: 100%%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color:rgb(28, 45, 196); color: white; }
    </style>
</head>
<body>
    <h1>Scan summary</h1>
    <p><strong>Total Tables:</strong> {{.TotalTables}}</p>
    <p><strong>Total Columns:</strong> {{.TotalColumns}}</p>

    <h2>Types of Data </h2>
    <table>
        <tr>
            <th>Data Type</th>
            <th>Quantity</th>
        </tr>
        {{range $key, $value := .DataTypes}}
        <tr>
            <td>{{$key}}</td>
            <td>{{$value}}</td>
        </tr>
        {{end}}
    </table>
</body>
</html>
`

func GenerateScanSummary(report models.Report) (string, error) {
	dataTypesCount := make(map[string]int)
	totalTables := len(report.Tables)
	totalColumns := 0

	for _, table := range report.Tables {
		for _, column := range table.Columns {
			dataTypesCount[column.InformationType]++
			totalColumns++
		}
	}

	tmpl, err := template.New("summary").Parse(htmlTemplate)
	if err != nil {
		log.Println("❌ Error processing html template")
		return "", err
	}

	var renderedHTML bytes.Buffer
	err = tmpl.Execute(&renderedHTML, map[string]interface{}{
		"TotalTables":  totalTables,
		"TotalColumns": totalColumns,
		"DataTypes":    dataTypesCount,
	})

	if err != nil {
		log.Println("❌ Error rendering HTML")
		return "", err
	}

	return renderedHTML.String(), nil

}
