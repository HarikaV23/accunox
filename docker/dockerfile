FROM alpine:latest
RUN apt-get update &&  \
    apt-get install -y fortune-mod cowsay && \ 
    apt-get clean
WORKDIR /app
COPY wisecow.sh .
RUN chmod +x wisecow.sh
EXPOSE 4499
CMD ["./wisecow.sh"] 
####