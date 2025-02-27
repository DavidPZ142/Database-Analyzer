
db = connect("mongodb://meli:secretPassword@mongo:27017/local");

db.getCollection("Users").insertOne({
    userName: "davidPz" ,
    password: "ODnlIb6kW5JHNK+ZxiHp6FWqHXwy8UIEBfJ7PgxsDrQbjL3ZNFIO!"
});

