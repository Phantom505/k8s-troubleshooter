FROM alpine:latest

RUN apk update && \
    apk add --no-cache \
    procps \
    sysstat \
    vim \
    python3 \
    py3-pip \
    curl \
    wget \
    bash \
    net-tools \
    iputils \
    bind-tools \
    tcpdump \
    strace \
    ltrace \
    lsof \
    htop \
    && ln -sf /usr/bin/vim /usr/bin/vi

SHELL ["/bin/bash", "-c"]
ENTRYPOINT ["/bin/bash"]

WORKDIR /troubleshooting

LABEL maintainer="Kubernetes Troubleshooting" \
      description="Image containing tools for troubleshooting Kubernetes nodes"