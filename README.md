# Database Analyzer

## 📘 Descripción

Este proyecto es una API REST desarrollada en `Golang` para clasificar bases de datos MySQL y retornar la información.

## 🎯 Objetivo

- Clasificar la información de una base de datos MySQL.
- Persistir los resultados en una base de datos MongoDB.
- Proveer endpoints para registrar bases de datos, ejecutar escaneos y consultar los resultados.

### 🚀Caracteristicas

### ¿Cómo clasificamos la información de una base de datos?

1. Tomamos la base de datos MYSQL que registro el usuario nos conectamos y hacemos un Schema Inspection con el fin de obtener los nombres de las columnas en dicha base de datos.
Con esta información aplicamos expresiones regulares sobre cada nombre de columna para poder clasificarlas.

```sql
SELECT TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
where TABLE_SCHEMA not in ('performance_schema' ,'mysql', 'information_schema', 'sys')
```

1. Ya teniendo los nombres de las columnas y habiendo clasificado , hacemos una segunda validación , tomamos un **Data Sample** de cada columna buscando posibles coincidencias con expresiones regulares

```sql
SELECT COUNT(*) as count
        FROM schemaName.tableName
        WHERE columName REGEXP '^[0-9]{13,16}$'
        LIMIT 10;
```

### Expresiones regulares

- **Estas expresiones regulares estan almacenadas en Mongo DB en la coleccion `infoTypes` y es posible añadir más**

| **Tipo** | **Regex** | **Descripción** |
| --- | --- | --- |
| **USERNAME** | ``(?i)^(user_?namelogin)$`` | Esta expresión regular detecta campos que representan el nombre de usuario |
| **EMAIL_ADDRESS** | `(?i)^(email|e-?mail)$` | Detecta campos relacionados con direcciones de correo electrónico |
| **CREDIT_CARD_NUMBER** | `(?i)^(credit_?card|cc_?number|card_?number|cvv)` | Identifica campos relacionados con datos de tarjetas de crédito |
| **FIRST_NAME** | `(?i)^(first_?name|name|)` | Detecta campos que contienen el primer nombre de una persona |
| **LAST_NAME** | `(?i)^(last_?name|surname)` |  Detecta campos relacionados con el apellido |
| **PHONE_NUMBER** | `(?i)^(phone|telephone|mobile|cellphone)` | Identifica campos relacionados con números de teléfono |
| **IP_ADDRESS** | ``(?i)^(ip_?address|ip)` | Detecta campos relacionados con direcciones IP |
| **DATE_OF_BIRTH** | `(?i)^(dob|date_?of_?birth)` | Identifica campos relacionados con la fecha de nacimiento |
| **SOCIAL_SECURITY_NUMBER** | `(?i)^(ssn|social_?security)` | social_?security)$` |
| **POSTAL_CODE** | `(?i)^(postal_?code|zip_?code|street)` | Identifica campos relacionados con numeros de seguridad social |
| **PLACE** | `(?i)^(city|state|country)` | Identifica campos relacionados con códigos postales o direcciones |
| **PAYMENT_METHOD** | `(?i)^(payment_?method)` | Identifica campos relacionados con métodos de pago |

Notas

- Todas las expresiones regulares son **case insensitive** gracias al prefijo `(?i)`.
- Estas expresiones están diseñadas para coincidir únicamente con los nombres de los campos (no con los valores contenidos).

### Encriptación de contraseñas

Este código implementa **encriptación y desencriptación de datos usando AES-GCM (Galois/Counter Mode)** en Golang. Veamos paso a paso cómo funciona cada parte.

- **Encripta y desencripta textos sensibles** usando **AES-GCM**.
- **Usa una clave de encriptación** obtenida desde la variable de entorno `ENCRYPTION_KEY`.
- **Genera un `nonce` aleatorio** (vector de inicialización) para cada encriptación.
- **Devuelve los datos en formato Base64** para facilitar su almacenamiento o transmisión.

## Diagramas de secuencia de procesos
### Guardar una configuracion de base de datos
![Descripción de la imagen](images/SaveDatabase.png)
### Escanear una base de datos
![Descripción de la imagen 2](images/ScanDatabase.png)
### Obtener el resultado de una base de datos escaneada
![Descripción de la imagen 3](images/GetScanned.png)
### Login
![Descripción de la imagen 4](images/Login.png)


## 📌 Endpoints

### 👤Registrar un usuario

`POST : localhost:8080/register`

Body:

```json
{
    "username": "davidPz2",
    "password": "HelloWorld!"
}
```

Response: 

201

```json
{
    "message": "user created"
}
```

### 🔓Login

`POST : localhost:8080/login`

**Body:**

```json
{
    "username": "davidPz2",
    "password": "HelloWorld!"
}
```

Responses : 

**200:**

```json
{
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3NDA3ODkyOTUsInVzZXJuYW1lIjoiZGF2aWRQejIifQ.PECNjI3XKQnaeZM-dke2tfGdAh71kq3bvYsPYz6jsKE"
}
```

**401:**

```json
{
    "error": "invalid Credentials"
}
```

### 🔖Guardar una base de datos

Guarda la configuración de la base de datos como un documento en mongo encriptando la contraseña.

`POST : localhost:8080/api/v1/database`

`Headers : Authorization - eyJhbGciOiJIUzI-yourToken` 

**Body:**

```json
{
    "host": "Bussines",
    "port": 3306,
    "username": "root",
    "password": "BussinesRoot"
}
```

**Success Response :
201** 

```json
{
    "id": 1,
    "status": 201
}
```

**Failed Examples:
401**

```json
{
    "error": "Invalid Token"
}
```

**500**

```json
{
	"error" : "An error ocurred when try save Database Configuration",
	"status": 500
}
```

### 🔍 Escanear una base de datos

A partir de un id de configuración de base de datos , se realiza la conexión con dicha MYSQL DB y se procede a hacer el scaneo de datos y el reporte se guarda como un documento en MongoDB.

`POST : localhost:8080/api/v1/database/scan/:id`

`Headers : Authorization - eyJhbGciOiJIUzI-yourToken` 

**Success Response :**

**201**

```json
{}
```

**Failed Examples:**
400

```json
{
    "error": "ID must be a Integer",
    "status": 400
}
```

404

```
{
    "error": "database configuration not found",
    "status": 404
}
```

### 📁Obtener reporte de base de datos escaneada

A partir del id de una base de datos escaneada vamos a obtener el reporte en formato JSON
conteniendo sus esquemas, tablas y columnas. Por cada columna se deberá especificar el tipo de datoencontrado.

`GET localhost:8080/api/v1/database/scan/:id`

`Headers : Authorization - eyJhbGciOiJIUzI-yourToken` 

**Success Response :
200**

```json
{
    "Report": {
        "id": 1,
        "tables": {
            "BusinessDB.Addresses": {
                "columns": {
                    "city": {
                        "informationType": "PLACE"
                    },
                    "country": {
                        "informationType": "PLACE"
                    },
                    "postal_code": {
                        "informationType": "POSTAL_CODE"
                    },
                    "state": {
                        "informationType": "PLACE"
                    },
                    "street": {
                        "informationType": "POSTAL_CODE"
                    },
                    "user_id": {
                        "informationType": "N/A"
                    }
                }
            },
            "BusinessDB.CreditCards": {
                "columns": {
                    "billing_address": {
                        "informationType": "N/A"
                    },
                    "card_id": {
                        "informationType": "N/A"
                    },
                    "card_number": {
                        "informationType": "CREDIT_CARD_NUMBER"
                    },
                    "cvv": {
                        "informationType": "CREDIT_CARD_NUMBER"
                    },
                    "expiration_date": {
                        "informationType": "N/A"
                    },
                    "user_id": {
                        "informationType": "N/A"
                    }
                }
            },
            "BusinessDB.Orders": {
                "columns": {
                    "order_date": {
                        "informationType": "N/A"
                    },
                    "order_id": {
                        "informationType": "N/A"
                    },
                    "payment_method": {
                        "informationType": "PAYMENT_METHOD"
                    },
                    "status": {
                        "informationType": "N/A"
                    },
                    "total_amount": {
                        "informationType": "N/A"
                    },
                    "user_id": {
                        "informationType": "N/A"
                    }
                }
            },
            "BusinessDB.SecurityLogs": {
                "columns": {
                    "ip_address": {
                        "informationType": "IP_ADDRESS"
                    },
                    "log_id": {
                        "informationType": "N/A"
                    },
                    "login_attempt": {
                        "informationType": "N/A"
                    },
                    "success": {
                        "informationType": "N/A"
                    },
                    "user_id": {
                        "informationType": "N/A"
                    }
                }
            },
            "BusinessDB.Transactions": {
                "columns": {
                    "amount": {
                        "informationType": "N/A"
                    },
                    "ip_address": {
                        "informationType": "IP_ADDRESS"
                    },
                    "order_id": {
                        "informationType": "N/A"
                    },
                    "payment_method": {
                        "informationType": "PAYMENT_METHOD"
                    },
                    "transaction_date": {
                        "informationType": "N/A"
                    },
                    "transaction_id": {
                        "informationType": "N/A"
                    }
                }
            },
            "BusinessDB.Users": {
                "columns": {
                    "date_of_birth": {
                        "informationType": "DATE_OF_BIRTH"
                    },
                    "email": {
                        "informationType": "EMAIL_ADDRESS"
                    },
                    "first_name": {
                        "informationType": "FIRST_NAME"
                    },
                    "last_name": {
                        "informationType": "LAST_NAME"
                    },
                    "phone": {
                        "informationType": "PHONE_NUMBER"
                    },
                    "user_id": {
                        "informationType": "N/A"
                    },
                    "user_name": {
                        "informationType": "USERNAME"
                    }
                }
            }
        }
    }
}
```

**Failed Examples:**

424

```json
{
    "error": "database service has failed",
    "status": 424
}
```

### 📄Descargar reporte HTML

Este endpoint nos permite obtener un HTML con la información de la base de datos escaneada y algunas métricas de la misma

`GET localhost:8080/api/v1/database/scan/html/:id`

`Headers : Authorization - eyJhbGciOiJIUzI-yourToken` 

Success Response

200

```html

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
    <p><strong>Total Tables:</strong> 6</p>
    <p><strong>Total Columns:</strong> 36</p>

    <h2>Types of Data </h2>
    <table>
        <tr>
            <th>Data Type</th>
            <th>Quantity</th>
        </tr>
        
        <tr>
            <td>CREDIT_CARD_NUMBER</td>
            <td>2</td>
        </tr>
        
        <tr>
            <td>DATE_OF_BIRTH</td>
            <td>1</td>
        </tr>
        
        <tr>
            <td>EMAIL_ADDRESS</td>
            <td>1</td>
        </tr>
        
        <tr>
            <td>FIRST_NAME</td>
            <td>1</td>
        </tr>
        
        <tr>
            <td>IP_ADDRESS</td>
            <td>2</td>
        </tr>
        
        <tr>
            <td>LAST_NAME</td>
            <td>1</td>
        </tr>
        
        <tr>
            <td>N/A</td>
            <td>19</td>
        </tr>
        
        <tr>
            <td>PAYMENT_METHOD</td>
            <td>2</td>
        </tr>
        
        <tr>
            <td>PHONE_NUMBER</td>
            <td>1</td>
        </tr>
        
        <tr>
            <td>PLACE</td>
            <td>3</td>
        </tr>
        
        <tr>
            <td>POSTAL_CODE</td>
            <td>2</td>
        </tr>
        
        <tr>
            <td>USERNAME</td>
            <td>1</td>
        </tr>
        
    </table>
</body>
</html>

```

### ✍🏻Añadir una nueva expresión regular

`POST localhost:8080/api/v1/database/infoType`

`Headers : Authorization - eyJhbGciOiJIUzI-yourToken` 
**Body :** 

```json
{
    "Type":"ID",  // Name of info Type 
    "regex": "(?i)^(id|user_id)" //Expresión regular 
}
```

## ⚒️Instalación y ejecución

Clonar el proyecto

```html
git clone https://github.com/DavidPZ142/Database-Analyzer
cd Database-Analyzer
```

Run docker 
Docker Compose cuenta con la base de datos de la aplicacion MongoDB
 2 bases de prueba MYSQL y el proyecto DatabaseAnalyzer en golang

```html
docker-compose up --build -d
```

Archivos SQL no es necesario ejecutar los scripts sql ya que cuando se levanta el contenedor las bases de datos ya vienen con la data necesaria.
Para la base de datos de la aplicación MONGODB tampoco se debe realizar ninguna acción adicional
el componente `init-mongo.sh` se encarga de insertar los documentos necesarios.
Para testear el proyecto
1. Crea un usuario y luego haz login y ten tu token para hacer las peticiones
Para las bases de datos de prueba utilizar estas configuraciones
Base de datos 1 

```json
{ 
//Bussines Database
    
    "host": "Bussines",
    "port": 3306,
    "username": "root",
    "password": "BussinesRoot"
}
```

Base de datos 2

```json
{
//Supermarket Database
    "host": "SuperMarket",
    "port": 3306,
    "username": "root",
    "password": "ultrasecret"
}
```

## 📬Contacto

davidpz616@gmail.com
