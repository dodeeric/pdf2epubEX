# pdf2epubEX

This bash script uses the *pdf2htmlEX* tool to convert a PDF file to a ePub file.

The result is a *fixed layout* ePub: the layout is retained and all the fonts are embedded.

The *pdf2htmlEX* tool converts a PDF file into HTML5 (with CSS, JS, fonts, and bitmap and/or vector images).

## Using the bash script

### Usage

To convert myfile.pdf to myfile.epub, run the following command in the directory where the PDF file is located:

```
./pdf2epubEX.sh myfile.pdf
```

Result will be: myfile.epub

### Prerequisites

You have to install *pdf2htmlEX* and some other utilities before using the script:

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

You can also use *pdf2htmlEX* with this same Docker image:

To convert myfile.pdf to myfile.html, run the following command in the directory where the PDF file is located:

```
docker run -ti --rm -v `pwd`:/pdf dodeeric/pdf2epubex pdf2htmlEX myfile.pdf
```

The result will be: myfile.html

*pdf2htmlEX* has a lot of parameters. To see them:

```
docker run -ti --rm -v `pwd`:/pdf dodeeric/pdf2epubex pdf2htmlEX --help
```

### Prerequisites

You need to install Docker which is available for all computer OS: Windows, MacOS, Linux and Unix. See [here](https://docs.docker.com/engine/install).

## Parameters

Once you launch *pdf2epubEX*, some information will be displayed like the book/PDF width and height (in inches and cm), then some questions will be asked like:

- Resolution of the images in the epub in dpi (e.g.: 150 or 300) [default: 150]
- Format of the images in the epub (png or jpg) [default: jpg]
- Title, Author, Publisher, Year, Language: (e.g.: fr), ISBN number, Subject (e.g.: history)

If you want, you can hit `ENTER` to all the questions.

The ePub cover image will be made from the first page of the PDF file.

## Examples

In the examples below, the HTML version is one big file including everything (all the pages with HTML5, CSS, JS, fonts and images; fonts and images are coded in Base64). *pdf2htmlEX* can also put all that content in different files (.html, .css, .js, .woff, .png, .jpg); that's in fact what basicaly the *pdf2epubEX* script does before wripping all the files in one ePub container file (.epub). Sometime, ePub is referred as "website in a box".

For eBooks with a lot of bitmap images, it is better to chose JPG (compression with loss) to not have a file too big. For eBooks with mainly vector images, it is better to chose PNG (lossless compression).

- **Install your own OpenStack Cloud**, Eric Dodémont, 2012, 49 pp. (150 dpi / PNG): [PDF](https://dodeeric-web.s3.eu-central-1.amazonaws.com/Install-your-own-OpenStack-Cloud-Eric-Dodemont.pdf) | [HTML](https://dodeeric-web.s3.eu-central-1.amazonaws.com/Install-your-own-OpenStack-Cloud-Eric-Dodemont.html) | [ePub](https://dodeeric-web.s3.eu-central-1.amazonaws.com/Install-your-own-OpenStack-Cloud-Eric-Dodemont.epub)
- **La dynastie belge en images (Preview)**, Eric Dodémont, 2015, 248 pp. (150 dpi / JPG): [PDF](https://dodeeric-web.s3.eu-central-1.amazonaws.com/La-dynastie-belge-en-images-Preview-Eric-Dodemont.pdf) | [HTLM](https://dodeeric-web.s3.eu-central-1.amazonaws.com/La-dynastie-belge-en-images-Preview-Eric-Dodemont.html) | [ePub](https://dodeeric-web.s3.eu-central-1.amazonaws.com/La-dynastie-belge-en-images-Preview-Eric-Dodemont.epub)
- **CEB 2015 - Solides et Figures**, 2015, 24 pp. (150 dpi / PNG): [PDF](https://dodeeric-web.s3.eu-central-1.amazonaws.com/CEB-2015-Solides-et-Figures.pdf) | [HTML](https://dodeeric-web.s3.eu-central-1.amazonaws.com/CEB-2015-Solides-et-Figures.html) | [ePub](https://dodeeric-web.s3.eu-central-1.amazonaws.com/CEB-2015-Solides-et-Figures.epub)

## Additional information

### Book

The script is based on the method described in my book published in 2014: *Fixed Layout ePub: A Practical Guide to Publish eBooks from PDF Files*. It is available on [Amazon](https://www.amazon.fr/dp/1502809508) and on [Googgle Play Books](https://play.google.com/store/books/details?id=LRQ-BQAAQBAJ).

### ePub Fix Layout

To read a fix layout ePub, the best device is a tablet (Android or iOS/iPad). A smartphone is not adapted most of the time because of the too small screen size.

A lot of ePub reader apps exist (to reflowable text ePub and fixed layout ePub): Google Play Books, BookShelf, PocketBook, Apple Books (only on iOS; formely known as Apple iBooks), etc. 

Amazon Kindle does not support the standard ePub format (they have their own format which is based on the ePub format).

To use Google Play Books, you have to go to **Settings**, then set **Enable uploading (from downloads, mail or other apps)**. The uploaded eBooks (PDF or ePub) will be available on all devices using the same Google account. You can also upload eBooks from the [Google Play Books web interface](https://play.google.com/books) (see the **Upload files** button on the top right corner).
 
More about fixed layout (FXL) ePub version 3 specifications (IDPF / W3C): [Fixed Layouts](https://www.w3.org/publishing/epub/epub-contentdocs.html#sec-fixed-layouts) and [Fixed-Layout Properties](https://www.w3.org/publishing/epub/epub-packages.html#sec-package-metadata-fxl).

### Other Git Repositories

Repositories for *pdf2htmlEX*: the [original one](https://github.com/coolwanglu/pdf2htmlEX) and the [new one](https://github.com/pdf2htmlEX/pdf2htmlEX) (with updated .deb packages).

This script is based on the bash scripts written by Robert Clayton (RNCTX) and available [his Git repository](https://github.com/RNCTX/PDF2HTMLEX-EPUB3FIXED).

