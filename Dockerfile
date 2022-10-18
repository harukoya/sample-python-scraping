FROM python:3.8.10

ENV PYTHONIOENCODING utf-8
ENV TZ="Asia/Tokyo"
ENV LANG=C.UTF-8
ENV LANGUAGE=en_US:en_US

RUN apt-get update && apt-get install -y \
  mecab \
  libmecab-dev \
  mecab-ipadic-utf8 \
  make \
  sudo

RUN git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git && \
    mecab-ipadic-neologd/bin/install-mecab-ipadic-neologd -y && \
    echo dicdir = `mecab-config --dicdir`"/mecab-ipadic-neologd" > /etc/mecabrc && \
    sudo cp /etc/mecabrc /usr/local/etc

WORKDIR /app

COPY ./requirements.txt /tmp/requirements.txt

RUN pip uninstall pystan && \
    pip3 install pystan~=2.14

RUN pip3 install -r /tmp/requirements.txt
