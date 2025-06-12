#!/bin/bash

service ssh start

cd /home/site/wwwroot

if [ ! -d "node_modules" ]; then
    npm install
fi

exec npm start