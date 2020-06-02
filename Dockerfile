FROM ubuntu:18.04
MAINTAINER khalfan <khalfan.salah@netsoltech.com>
ARG helm_version=v3.2.1
RUN echo "Installing prerequisites ..."
RUN apt-get update && apt-get install -y \
    curl \
    jq \
    wget \
    ca-certificates \
    apt-transport-https \
    lsb-release gnupg

RUN echo "installing Helm..."
RUN mkdir -p ~/Downloads && curl -L https://raw.githubusercontent.com/khalfan123/helm/master/get-helm-3.sh | bash -s -- --version $helm_version --no-sudo


RUN echo "installing Azure cli ..."

RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | \
    gpg --dearmor | \
    tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null

RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ bionic main" | \
    tee /etc/apt/sources.list.d/azure-cli.list
RUN apt-get update && apt-get install -y azure-cli

RUN mkdir -p ~/Downloads && wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN apt-get update && apt-get install -y powershell

CMD bash


# Build and Run container: 
# docker build -t jbox .
# docker run --rm -it --name jbox jbox:latest  bin/bash