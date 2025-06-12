#!/bin/bash

echo "📦 Uygulama başlatılıyor..."

if [ ! -d "node_modules" ]; then
  echo "📦 node_modules bulunamadı, yükleniyor..."
  npm install
fi

exec npm start