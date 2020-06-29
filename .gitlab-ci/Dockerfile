FROM debian:unstable

ENV HOME /root

RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get -y install --no-install-recommends \
	git subversion \
	gawk unzip file \
    ca-certificates wget rsync \
	python \
	build-essential zlib1g-dev libssl-dev libncurses-dev gcc-multilib \
    && \
  apt-get clean

CMD [ "bash" ]

# vim: ft=dockerfile
