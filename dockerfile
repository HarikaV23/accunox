# Use the official Ubuntu 20.04 as the base image
FROM ubuntu:20.04

# Update package list and install required packages
RUN apt-get update && \
    apt-get install -y bash fortune-mod netcat cowsay && \
    apt-get clean

# Verify cowsay installation and handle potential issues
RUN if ! which cowsay > /dev/null; then \
        echo 'cowsay not found in PATH'; \
        echo 'Attempting to locate cowsay manually...'; \
        dpkg -L cowsay | grep '/cowsay'; \
        if [ -f /usr/games/cowsay ]; then \
            ln -s /usr/games/cowsay /usr/local/bin/cowsay; \
            echo 'Symlink created for cowsay'; \
        elif [ -f /usr/bin/cowsay ]; then \
            ln -s /usr/bin/cowsay /usr/local/bin/cowsay; \
            echo 'Symlink created for cowsay'; \
        else \
            echo 'cowsay could not be located'; \
            exit 1; \
        fi; \
    fi && \
    cowsay "Installation successful"

# Verify fortune installation and handle potential issues
RUN if ! which fortune > /dev/null; then \
        echo 'fortune not found in PATH'; \
        echo 'Attempting to locate fortune manually...'; \
        dpkg -L fortune-mod | grep '/fortune'; \
        if [ -f /usr/games/fortune ]; then \
            ln -s /usr/games/fortune /usr/local/bin/fortune; \
            echo 'Symlink created for fortune'; \
        elif [ -f /usr/bin/fortune ]; then \
            ln -s /usr/bin/fortune /usr/local/bin/fortune; \
            echo 'Symlink created for fortune'; \
        else \
            echo 'fortune could not be located'; \
            exit 1; \
        fi; \
    fi && \
    fortune | cowsay "Fortune is up and running"

# Copy the script into the container
COPY wisecow.sh /home/wisecow.sh

# Make scripts executable
RUN chmod +x /home/wisecow.sh

# Expose port 4499
EXPOSE 4499

# Run the scripts and keep the container alive
CMD ["/bin/bash", "-c", "/home/wisecow.sh  && tail -f /dev/null"]
