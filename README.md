# pdf2epubEX

This bash script uses the pdf2htmlEX tool to convert a PDF file (myfile.pdf) to a fixed layout ePub file (myfile.epub).

The layout is retained and all the fonts are embedded.

The pdf2htmlEX tool converts a PDF file into HTML5 (with CSS, JS, fonts, and bitmap and/or vector images).

## Using the bash script

Usage:

To convert myfile.pdf to myfile.epub, run the following command in the directory where the PDF file is located:

```
./pdf2epubEX.sh myfile.pdf
```

Result will be: myfile.epub

Prerequisites: 

You have to install pdf2htmlEX and some other utilities before using the script:

```
apt-get install ./pdf2htmlEX-0.18.8.rc1-master-20200630-Ubuntu-focal-x86_64.deb
apt-get install poppler-utils bc zip
```

The Debian package is available in this repository.

## Using the Docker image

A Docker image is also available on Dockerhub: https://hub.docker.com/repository/docker/dodeeric/pdf2epubex.

Usage:

To convert myfile.pdf to myfile.epub, run the following command in the directory where the PDF file is located:

```
docker run -ti --rm -v `pwd`:/pdf dodeeric/pdf2epubex pdf2epubEX myfile.pdf
```

Result will be: myfile.epub

## Additional information

To read a fix layout epub, the best device is a tablet (Android or iOS/iPad). A smartphone is not adapted most of the time because of the too small screen size.

A lot of epub reader apps exist (reading reflowable text epub or fixed layout epub): Play Books (from Google), BookShelf, PocketBook, Books (from Apple; only on iOS; formely known as iBooks), etc. Kindle (from Amazon) does not support the standard epub format (they have their own format which is based on the epub format).
 
More about fixed layout ePub (FXL) version 3 specifications (IDPF / W3C):

- Fixed Layouts: https://www.w3.org/publishing/epub/epub-contentdocs.html#sec-fixed-layouts
- Fixed-Layout Properties: https://www.w3.org/publishing/epub/epub-packages.html#sec-package-metadata-fxl

Repositories for pdf2htmlEX:

- The original one: https://github.com/coolwanglu/pdf2htmlEX
- The new one (with updated .deb packages): https://github.com/pdf2htmlEX/pdf2htmlEX

This script is based on the bash scripts written by Robert Clayton (RNCTX) and available on the following GIT repository: https://github.com/RNCTX/PDF2HTMLEX-EPUB3FIXED.

