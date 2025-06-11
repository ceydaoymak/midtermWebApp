FROM node:22

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd

WORKDIR /app
COPY . .
RUN npm install


RUN echo 'root:123456' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

RUN chmod +x start.sh

EXPOSE 22
EXPOSE 3000

CMD ["./start.sh"]
