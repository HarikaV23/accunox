FROM ubuntu:20.04
RUN apt-get update && \
    apt-get install -y fortune-mod cowsay && \
    apt-get clean
COPY wisecow.sh /usr/local/bin/wisecow.sh
RUN chmod +x /usr/local/bin/wisecow.sh
RUN /usr/local/bin/wisecow.sh
EXPOSE 4499
CMD ["bash", "-c", "echo 'Service running on port 4499' && while true; do sleep 3600; done"]