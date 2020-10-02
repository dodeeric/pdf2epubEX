FROM ubuntu:xenial

# Tool to convert a PDF file (myfile.pdf) to a fixed layout ePub file (myfile.epub).
# By Eric Dodémont (eric.dodemont@skynet.be)
# Belgium, July-October 2020

MAINTAINER Eric Dodemont <eric.dodemont@skynet.be>

ENV DEBIAN_FRONTEND=noninteractive
RUN apt -q update && apt -q -y upgrade

# Fixed layout ePub: install pdf2htmlEX and some other packages

COPY ./pdf2htmlex_0.14.6+ds-2build1_amd64-ubuntu-xenial.deb .
RUN apt-get -q -y install ./pdf2htmlex_0.14.6+ds-2build1_amd64-ubuntu-xenial.deb
RUN apt -q update && apt -q -y install poppler-utils bc zip file

# Bash script

COPY ./pdf2epubEX /bin

RUN mkdir /temp
WORKDIR /temp
