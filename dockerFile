FROM ubuntu:20.04

# Update packages and install curl
RUN apt-get update && \
    apt-get install -y curl

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs