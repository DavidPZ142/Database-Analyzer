
db = connect("mongodb://meli:secretPassword@mongo:27017/local");

db.getCollection("users").insertOne({
    userName: "davidPz" ,
    password: "HelloWorld!"
});

