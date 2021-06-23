FROM ubuntu:20.04
MAINTAINER t_o_d

ENV LANG ja_JP.UTF-8

RUN apt update -yqq && \
	apt install -y --no-install-recommends ca-certificates toilet locales curl && \
	locale-gen ja_JP.UTF-8 && \
	rm -rf /var/lib/apt/lists/*

WORKDIR /usr/local/src/nogicomma
COPY . /usr/local/src/nogicomma

RUN echo 'finish build'
