# pdf2epubEX

This bash script uses the pdf2htmlEX tool to convert a PDF file (myfile.pdf) to a fixed layout ePub file (myfile.epub).

The layout is retained and all the fonts are embedded.

The pdf2htmlEX tool converts a PDF file into HTML5 (with CSS, JS, fonts, and bitmap and/or vector images).

## Using the bash script

#### Usage

To convert myfile.pdf to myfile.epub, run the following command in the directory where the PDF file is located:

```
./pdf2epubEX.sh myfile.pdf
```

Result will be: myfile.epub

### Prerequisites

You have to install pdf2htmlEX and some other utilities before using the script:

```
apt-get install ./pdf2htmlEX-0.18.8.rc1-master-20200630-Ubuntu-focal-x86_64.deb
apt-get install poppler-utils bc zip
```

The Debian package (.deb) is available in this repository.

## Using the Docker image

A Docker image is vailable on [my DockerHub repository](https://hub.docker.com/repository/docker/dodeeric/pdf2epubex).

### Usage

To convert myfile.pdf to myfile.epub, run the following command in the directory where the PDF file is located:

```
docker run -ti --rm -v `pwd`:/pdf dodeeric/pdf2epubex pdf2epubEX myfile.pdf
```

The result will be: myfile.epub

You can also use pdf2htmlEX with this same Docker image:

To convert myfile.pdf to myfile.html, run the following command in the directory where the PDF file is located:

```
docker run -ti --rm -v `pwd`:/pdf dodeeric/pdf2epubex pdf2htmlEX myfile.pdf
```

The result will be: myfile.html

pdf2htmlEX has a lot of parameters. To see them:

```
docker run -ti --rm -v `pwd`:/pdf dodeeric/pdf2epubex pdf2htmlEX --help
```

### Prerequisites

You need to install Docker which is available for all computer OS: Windows, MacOS, Linux and Unix. See here: https://docs.docker.com/engine/install.

## Parameters

Once you launch pdf2epubEX, some information will be displayed like the book/PDF width and height (in inches and cm), then some questions will be asked like:

- Resolution of the images in the epub in dpi (e.g.: 150 or 300) [default: 150]
- Format of the images in the epub (png or jpg) [default: jpg]
- Title, Author, Publisher, Year, Language: (e.g.: fr), ISBN number, Subject (e.g.: history)

If you want, you can hit `ENTER` to all the questions.

The ePub cover image will be made from the first page of the PDF file.

## Additional information

### Book

The script is based on the method described in my book published in 2014: **Fixed Layout ePub: A Practical Guide to Publish eBooks from PDF Files**, available on [Amazon](https://www.amazon.fr/dp/1502809508) and on [Googgle Play Books](https://play.google.com/store/books/details?id=LRQ-BQAAQBAJ).

### ePub Fix Layout

To read a fix layout ePub, the best device is a tablet (Android or iOS/iPad). A smartphone is not adapted most of the time because of the too small screen size.

A lot of ePub reader apps exist (reading reflowable text ePub or fixed layout ePub): Google Play Books, BookShelf, PocketBook, Apple Books (only on iOS; formely known as Apple iBooks), etc. 

Amazon Kindle does not support the standard ePub format (they have their own format which is based on the ePub format).

To use Google Play Books, you have to go to "Settings", then set "Enable uploading (from downloads, mail or other apps)". The uploaded eBooks (PDF or ePub) will be available on all devices using the same Google account. You can also upload eBooks from the Google Play Books web interface: https://play.google.com/books (see the "Upload files" button on the top right corner).
 
More about fixed layout (FXL) ePub version 3 specifications (IDPF / W3C):

- Fixed Layouts: https://www.w3.org/publishing/epub/epub-contentdocs.html#sec-fixed-layouts
- Fixed-Layout Properties: https://www.w3.org/publishing/epub/epub-packages.html#sec-package-metadata-fxl

### Other Git Repositories

Repositories for pdf2htmlEX:

- The original one: https://github.com/coolwanglu/pdf2htmlEX
- The new one (with updated .deb packages): https://github.com/pdf2htmlEX/pdf2htmlEX

This script is based on the bash scripts written by Robert Clayton (RNCTX) and available on the following Git repository: https://github.com/RNCTX/PDF2HTMLEX-EPUB3FIXED.

