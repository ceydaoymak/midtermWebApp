FROM node:18

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

RUN chmod +x ./start.sh

ENV PORT=80
EXPOSE 80

CMD ["./start.sh"]