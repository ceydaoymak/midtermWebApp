FROM node:18

WORKDIR /app

COPY package*.json ./

RUN npm config set registry https://registry.npmjs.org/ \
  && npm install --legacy-peer-deps --prefer-online --retry 5 --fetch-retries=5 --fetch-retry-factor=2

COPY . .

RUN chmod +x ./start.sh

CMD ["./start.sh"]
