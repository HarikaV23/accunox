FROM alpine:latest
RUN apt-get update &&  \
    apt-get install  fortune-mod cowsay  -y  && \ 
    apt-get clean
WORKDIR /app
COPY wisecow.sh .
RUN chmod +x wisecow.sh
EXPOSE 4499
CMD ["./wisecow.sh"] 
####