FROM ubuntu:20.04
MAINTAINER t_o_d

ENV TZ Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV LANG ja_JP.UTF-8

RUN apt update -yqq && \
    apt install -y --no-install-recommends \
    ca-certificates locales sudo \
    git build-essential file \
    curl vim toilet icu-devtools \
    mecab libmecab-dev mecab-ipadic-utf8 \
    pulseaudio && \
    locale-gen ja_JP.UTF-8 && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /tmp
RUN git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git && \
    ./mecab-ipadic-neologd/bin/install-mecab-ipadic-neologd -n -y && \
    sudo mv /usr/lib/x86_64-linux-gnu/mecab/dic/mecab-ipadic-neologd /var/lib/mecab/dic/ && \
    echo "dicdir=/var/lib/mecab/dic/mecab-ipadic-neologd">/etc/mecabrc && \
    rm -rf ./mecab-ipadic-neologd

WORKDIR /usr/local/src/nogicomma
COPY . /usr/local/src/nogicomma

RUN echo 'finish build'
