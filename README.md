# pdf2epubEX

This bash script uses the pdf2htmlEX tool to convert a PDF file (myfile.pdf) to a fixed layout ePub file (myfile.epub).

The layout is retained and all the fonts are embedded.

The pdf2htmlEX tool converts a PDF file into HTML (with CSS, JS, fonts, and bitmap and/or vector images).

Usage: ./pdf2epubEX.sh myfile.pdf

The PDF file has to be in the same directory as the script.

Result will be: myfile.epub

Prerequisites: 

You have to install pdf2htmlEX before using the script:

Repositories for pdf2htmlEX:

- The original one: https://github.com/coolwanglu/pdf2htmlEX
- The new one (with updated .deb packages): https://github.com/pdf2htmlEX/pdf2htmlEX

More about fixed layout ePub version 3 specifications (IDPF / W3C):

- Fixed Layouts: https://www.w3.org/publishing/epub/epub-contentdocs.html#sec-fixed-layouts
- Fixed-Layout Properties: https://www.w3.org/publishing/epub/epub-packages.html#sec-package-metadata-fxl

This script is based on the bash scripts written by Robert Clayton (RNCTX) and available on the following GIT repository: https://github.com/RNCTX/PDF2HTMLEX-EPUB3FIXED.

Docker:

A Docker image is also available on Dockerhub: https://hub.docker.com/repository/docker/dodeeric/pdf2epubex.

Usage:

To convert myfile.pdf to myfile.epub, run the following command in the directory where the PDF file is located:

```
$ docker run -ti --rm -v pwd:/pdf dodeeric/pdf2epubex pdf2htmlEX myfile.pdf
```
