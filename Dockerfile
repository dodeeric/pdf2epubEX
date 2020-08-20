FROM ubuntu:focal

# App to convert a PDF file (myfile.pdf) to a fixed layout or reflowable text ePub file (myfile.epub).
# By Eric Dodémont (eric.dodemont@skynet.be)
# Belgium, July-August 2020

MAINTAINER Eric Dodemont <eric.dodemont@skynet.be>

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -q update && apt-get -q -y upgrade

# Fixed layout ePub: install pdf2htmlEX (RC) and some other packages

COPY ./pdf2htmlEX-0.18.8.rc1-master-20200630-Ubuntu-focal-x86_64.deb .
RUN apt-get -q -y install ./pdf2htmlEX-0.18.8.rc1-master-20200630-Ubuntu-focal-x86_64.deb
RUN apt-get -q -y install poppler-utils bc zip file 

# Reflowable text ePub: install ebook-convert (Beta) from Calibre

COPY ./ebook-convert-4.99-beta.tar.gz .
RUN tar -xzvf ebook-convert-4.99-beta.tar.gz
RUN mv ebook-convert /usr/bin/
RUN mv calibre-parallel /usr/bin/
RUN mv usr-lib-calibre /usr/lib/calibre
RUN mv usr-share-calibre /usr/share/calibre
RUN apt-get -q -y install python3 python3-msgpack libpython3.8 libicu66 python3-dateutil python3-lxml python3-css-parser python3-pil python3-pyqt5 python3-html5-parser

# Bash script

COPY ./pdf2epubEX.sh /bin
RUN cd /bin && ln -s pdf2epubEX.sh pdf2epubEX && ln -s pdf2epubEX.sh pdf2epubex && ln -s pdf2epubEX.sh pdf2epub && ln -s pdf2epubEX.sh pdf2epub.sh && ln -s pdf2epubEX.sh pdf2epubex.sh

RUN mkdir temp && ln -s temp pdf && ln -s temp files 
WORKDIR /temp
