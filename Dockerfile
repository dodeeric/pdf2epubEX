FROM ubuntu:focal

# App to convert a PDF file (myfile.pdf) to a fixed layout or reflowable text ePub file (myfile.epub).
# By Eric Dodémont (eric.dodemont@skynet.be)
# Belgium, July-August 2020

MAINTAINER Eric Dodemont <eric.dodemont@skynet.be>

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -q update && apt-get -q -y upgrade

# Fixed layout ePub: install pdf2htmlEX and some other packages

COPY ./pdf2htmlEX-0.18.8.rc2-master-20200820-ubuntu-20.04-x86_64.deb .
RUN apt-get -q -y install ./pdf2htmlEX-0.18.8.rc1-master-20200630-Ubuntu-focal-x86_64.deb
RUN apt-get -q -y install poppler-utils bc zip file 

# Reflowable text ePub: install ebook-convert from Calibre

RUN apt-get -q -y install wget python xdg-utils xz-utils libnss3
RUN wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sh /dev/stdin

# Bash script

COPY ./pdf2epubEX.sh /bin
RUN cd /bin && ln -s pdf2epubEX.sh pdf2epubEX && ln -s pdf2epubEX.sh pdf2epubex && ln -s pdf2epubEX.sh pdf2epub && ln -s pdf2epubEX.sh pdf2epub.sh && ln -s pdf2epubEX.sh pdf2epubex.sh

RUN mkdir temp && ln -s temp pdf && ln -s temp files 
WORKDIR /temp
