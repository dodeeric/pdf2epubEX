FROM ubuntu:focal

# Tool to convert a PDF file (myfile.pdf) to a fixed layout ePub file (myfile.epub).
# By Eric Dodémont (eric.dodemont@skynet.be)
# Belgium, July-August 2020

MAINTAINER Eric Dodemont <eric.dodemont@skynet.be>

ENV DEBIAN_FRONTEND=noninteractive
RUN apt -q update && apt -q -y upgrade

# Fixed layout ePub: install pdf2htmlEX and some other packages

RUN echo "deb [trusted=yes] https://repository.dodeeric.be/apt/ /" > /etc/apt/sources.list.d/dodeeric.list
RUN apt -q -y install ca-certificates
RUN apt -q update && apt -q -y install pdf2htmlex poppler-utils bc zip file

# Bash script

COPY ./pdf2epubEX /bin

RUN mkdir /temp
WORKDIR /temp
