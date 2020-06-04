FROM ubuntu:18.04
MAINTAINER khalfan <khalfanawan2013@gmail.com>

# disable package prompt interaction
ENV DEBIAN_FRONTEND noninteractive

ARG helm2_version=v2.14.0
ARG helm3_version=v3.2.1
ARG kubectl_version=v1.18.0
ARG node_version=12.9.1

# Installing packages
RUN apt-get update && apt-get install -y \
    sudo \
    apt-utils \
    curl \
    jq \
    wget \
    git \
    zip \
    unzip \
    ca-certificates \
    apt-transport-https \
    lsb-release gnupg  \
    software-properties-common \
    openssh-client

# install helm 2.*
RUN curl https://get.helm.sh/helm-$helm2_version-linux-amd64.tar.gz > ./helm.tar.gz    && \
    tar -xvf ./helm.tar.gz                                                      && \ 
    mv ./linux-amd64/helm /usr/local/bin/helm2                                  && \
    mv ./linux-amd64/tiller /usr/local/bin 
# install helm 3.*
RUN curl https://get.helm.sh/helm-$helm3_version-linux-amd64.tar.gz > ./helm.tar.gz    && \
    tar -xvf ./helm.tar.gz                                                      && \ 
    mv ./linux-amd64/helm /usr/local/bin

# Installing Azure cli
RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | \
    gpg --dearmor | \
    tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null

RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" | \
    tee /etc/apt/sources.list.d/azure-cli.list
RUN apt-get update && apt-get install -y azure-cli

# Installing Azure powershell
RUN mkdir -p ~/Downloads && wget -q https://packages.microsoft.com/config/ubuntu/$(lsb_release -sr)/packages-microsoft-prod.deb  && \
    dpkg -i packages-microsoft-prod.deb                                                                             && \
    apt-get update && apt-get install -y powershell

# Installing kubectl
RUN mkdir -p ~/Downloads && curl -LO https://storage.googleapis.com/kubernetes-release/release/$kubectl_version/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl                                                                                                                  && \
    mv ./kubectl /usr/local/bin/kubectl

# Installing Docker
RUN apt-get update                                                                                                                      && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -                                                        && \
    add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) \
        stable" -y                                                                                                                      && \
    apt-get update                                                                                                                      && \
    apt-get install -y docker-ce

# install docker compose-
RUN curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose  && \
    chmod +x /usr/local/bin/docker-compose                                                                                                        && \
    ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# nvm environment variables
ENV NVM_DIR /usr/local/nvm

# install nvm
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.2/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $node_version \
    && nvm alias default $node_version \
    && nvm use default

# add node and npm to path so the commands are available
ENV NODE_PATH $NVM_DIR/v$node_version/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$node_version/bin:$PATH

CMD bash

# Build and Run container: 
# docker build -t docdoc2018/jumpbox:latest .
# docker run --rm -it --name jbox docdoc2018/jumpbox:latest