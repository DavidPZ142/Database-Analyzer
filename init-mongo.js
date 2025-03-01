
db = connect("mongodb://meli:secretPassword@mongo:27017/local");

db.getCollection("Users").insertOne({
    userName: "davidPz" ,
    password: "ODnlIb6kW5JHNK+ZxiHp6FWqHXwy8UIEBfJ7PgxsDrQbjL3ZNFIO!"
});

db.getCollection("InfoTypes").insertOne({
    type : "USERNAME",
    regex: "(?i)^(user_?name|login)$"
});
db.getCollection("InfoTypes").insertOne({
    type : "EMAIL_ADDRESS",
    regex: "(?i)^(email|e-?mail)$$"
});
db.getCollection("InfoTypes").insertOne({
    type : "CREDIT_CARD_NUMBER",
    regex: "(?i)^(credit_?card|cc_?number|card_?number|cvv)$"
});
db.getCollection("InfoTypes").insertOne({
    type : "FIRST_NAME",
    regex: "(?i)^(first_?name|name|)$"
});
db.getCollection("InfoTypes").insertOne({
    type : "LAST_NAME",
    regex: "(?i)^(last_?name|surname)$"
});
db.getCollection("InfoTypes").insertOne({
    type : "PHONE_NUMBER",
    regex: "(?i)^(phone|telephone|mobile|cellphone)$"
});
db.getCollection("InfoTypes").insertOne({
    type : "IP_ADDRESS",
    regex: "(?i)^(ip_?address|ip)$"
});
db.getCollection("InfoTypes").insertOne({
    type : "DATE_OF_BIRTH",
    regex: "(?i)^(dob|date_?of_?birth)$"
});
db.getCollection("InfoTypes").insertOne({
    type : "SOCIAL_SECURITY_NUMBER",
    regex: "(?i)^(ssn|social_?security)$"
});
db.getCollection("InfoTypes").insertOne({
    type : "POSTAL_CODE",
    regex: "(?i)^(postal_?code|zip_?code|street)$"
});
db.getCollection("InfoTypes").insertOne({
    type : "PLACE",
    regex: "(?i)^(city|state|country)$"
});
db.getCollection("InfoTypes").insertOne({
    type : "PAYMENT_METHOD",
    regex: "(?i)^(payment_?method)$"
});
