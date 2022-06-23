FROM ubuntu

# Install python3.10 and dependencies
RUN apt update && apt install -y python3 curl xz-utils git gh

# Install code server
RUN \
    curl -o code_server.deb -fL https://github.com/coder/code-server/releases/download/v4.4.0/code-server_4.4.0_amd64.deb && \
    dpkg -i code_server.deb

# Install NodeJS 18.4
RUN \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash && \
    apt install -y nodejs

ARG UNAME=ilarramendi
ARG UID=1000
ARG GID=1000
RUN groupadd -g $GID -o $UNAME
RUN useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME
USER $UNAME

ENV HOME=/config
ENV XDG_DATA_HOME=/config

ENTRYPOINT ["code-server", "--user-data-dir", "/config", "--bind-addr", "0.0.0.0:8444"]
