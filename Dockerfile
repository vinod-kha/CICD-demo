FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y fortune cowsay netcat

COPY wisecow.sh /wisecow.sh

EXPOSE 4499

CMD ["bash", "/wisecow.sh"]