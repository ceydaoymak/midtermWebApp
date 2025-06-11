FROM node:22

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd

WORKDIR /app
COPY . .
RUN npm install

RUN echo 'root:123456' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

RUN mkdir -p /home/site/wwwroot
COPY start.sh /home/site/wwwroot/start.sh
RUN chmod +x /home/site/wwwroot/start.sh

EXPOSE 22
EXPOSE 8080

CMD ["/home/site/wwwroot/start.sh"]
