FROM debian:unstable

RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get -y install --no-install-recommends \
    git subversion \
    gawk unzip file \
    ca-certificates wget curl rsync \
    python \
    build-essential zlib1g-dev libssl-dev libncurses-dev gcc-multilib \
    && \
  apt-get clean

RUN useradd -ms /bin/bash -d /build build
USER build
ENV HOME /build

CMD [ "bash" ]

# vim: ft=dockerfile
