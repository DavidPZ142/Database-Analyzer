#!/bin/bash
echo "Waiting for mongo"
sleep 5 

mongosh -u meli -p secretPassword --authenticationDatabase admin < /init-mongo.js

echo "Set mongo "