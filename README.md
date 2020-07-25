# pdf2epubEX

This Bash script uses the *pdf2htmlEX* tool to convert a PDF file to an ePub file.

The result is a *fixed layout* ePub version 3: the layout is perfectly retained and all the fonts are embedded.

The *pdf2htmlEX* tool converts a PDF file into HTML5 (with CSS, JS, fonts, and bitmap and/or vector images). This means that the pages are not just converted into images as a lot of converters are doing.

## Using the Bash script

### Usage

To convert myfile.pdf to myfile.epub, run the following command in the directory where the PDF file is located:

```
./pdf2epubEX.sh myfile.pdf
```

Result will be: myfile.epub

### Prerequisites

- Download the Bash script: [pdf2epubEX.sh](https://raw.githubusercontent.com/dodeeric/pdf2epubEX/master/pdf2epubEX.sh).
- Install *pdf2htmlEX* and some other utilities: poppler-utils, bc, zip and file. If you are using Linux Debian or a Debian based Linux distribution (Ubuntu, Mint, etc.):

```
apt-get install ./pdf2htmlEX-0.18.8.rc1-master-20200630-Ubuntu-focal-x86_64.deb
apt-get install poppler-utils bc zip file
```

The Debian package (.deb) is available in this repository.

If you install *Git*, you can also just do:

```
git clone https://github.com/dodeeric/pdf2epubEX.git
```

## Using the Docker image

A Docker image is vailable on [my DockerHub repository](https://hub.docker.com/r/dodeeric/pdf2epubex).

### Usage

To convert myfile.pdf to myfile.epub, run the following command in the directory where the PDF file is located:

```
docker run -ti --rm -v `pwd`:/pdf dodeeric/pdf2epubex pdf2epubEX.sh myfile.pdf
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

Once you launch *pdf2epubEX.sh*, some information will be displayed like the book/PDF width and height (in inches and cm), then some questions will be asked like:

- Format of the images in the epub (png, jpg or svg) [default: jpg]
- Resolution of the images in the epub in dpi (e.g.: 150 or 300) [default: 150]
- Title, Author, Publisher, Year, Language: (e.g.: fr), ISBN number, Subject (e.g.: history)

If you want, you can hit `ENTER` to all the questions.

Image formats:

- if you chose png or jpg (bitmap formats), the vector images of the PDF will be converted in bitmap images (rasterized).
- if you chose svg (vector and bitmap format), the vector images of the PDF will remain in vector format, but: a) you cannot chose the resolution of the bitmap images (it is the one from the PDF); b) the bitmap images will be included in the svg files (Base64 coded); c) this format is not always correctly rendered by eBook readers; d) the generated epub file is not always passing the epub check.

A vector image can be as simple as a line, a rectangle, a table frame, a colored background, etc.

For eBooks with a lot of bitmap images, it is better to chose JPG (compression with loss) to not have a file too big. For eBooks with mainly vector images, it is better to chose PNG (lossless compression).

The ePub cover image will be made from the first page of the PDF file (png format).

## Examples

> The *Examples* section is still under construction!

In the examples below, the HTML version is one big file including everything (all the pages with HTML5, CSS, JS, fonts and images; fonts and images are coded in Base64). *pdf2htmlEX* can also put all that content in different files (.html, .css, .js, .woff, .png, .jpg, .svg); that's in fact what basicaly the *pdf2epubEX.sh* script does before wripping all the files in one ePub container file (.epub). Sometime, ePub is referred as "website in a box".

(X) The size of the file in MB.<br/>
(#) Does not pass the epub check validation using version epub 3.2 rules (this does not mean the ePub will not be displayed properly in some ePub readers).

**Install your own OpenStack Cloud:**<br/> 
(49 pages, bitmap and vector images in the PDF)

|              |             | 150 DPI  | 300 DPI |
| ---          | ---         | ----     | ---     |
| **PDF**      | [PDF](http://files.dodeeric.be/Install-your-own-OpenStack-Cloud-Eric-Dodemont.pdf) () |   |   |
| **SVG**      | [ePub](http://files.dodeeric.be/Install-your-own-OpenStack-Cloud-Eric-Dodemont-xxxdpi-svg.epub) () |   |   |
| **JPG**      |             | [ePub](http://files.dodeeric.be/Install-your-own-OpenStack-Cloud-Eric-Dodemont-150dpi-jpg.epub) () | [ePub](http://files.dodeeric.be/Install-your-own-OpenStack-Cloud-Eric-Dodemont-300dpi-jpg.epub) () |
| **PNG**      |             | [ePub](http://files.dodeeric.be/Install-your-own-OpenStack-Cloud-Eric-Dodemont-150dpi-png.epub) () | [ePub](http://files.dodeeric.be/Install-your-own-OpenStack-Cloud-Eric-Dodemont-300dpi-png.epub) () |

**La dynastie belge en images:**<br/>
(248 pages, lot of bitmap images in the PDF)

|              | 150 DPI  | 300 DPI |
| ---          | ----     | ---     |
| **PDF**      | [PDF](http://files.dodeeric.be/La-dynastie-belge-en-images-Preview-Eric-Dodemont-150dpi.pdf) () | [PDF](http://files.dodeeric.be/La-dynastie-belge-en-images-Preview-Eric-Dodemont-300dpi.pdf) () |
| **SVG**      | [ePub](http://files.dodeeric.be/La-dynastie-belge-en-images-Preview-Eric-Dodemont-150dpi-xxxdpi-svg.epub) () | [ePub](http://files.dodeeric.be/La-dynastie-belge-en-images-Preview-Eric-Dodemont-300dpi-xxxdpi-svg.epub) () |
| **JPG**      | [ePub](http://files.dodeeric.be/La-dynastie-belge-en-images-Preview-Eric-Dodemont-300dpi-150dpi-jpg.epub) () | [ePub](http://files.dodeeric.be/La-dynastie-belge-en-images-Preview-Eric-Dodemont-300dpi-300dpi-jpg.epub) () |
| **PNG**      | [ePub](http://files.dodeeric.be/La-dynastie-belge-en-images-Preview-Eric-Dodemont-300dpi-150dpi-png.epub) () | [ePub](http://files.dodeeric.be/La-dynastie-belge-en-images-Preview-Eric-Dodemont-300dpi-300dpi-png.epub) () |

**CEB 2015 - Solides et figures:**<br/>
(24 pages, only vector images in the PDF)

|              |             | 150 DPI  | 300 DPI |
| ---          | ---         | ----     | ---     |
| **PDF**      | [PDF](http://files.dodeeric.be/CEB-2015-Solides-et-figures.pdf) () |   |   |
| **SVG**      | [ePub](http://files.dodeeric.be/CEB-2015-Solides-et-figures-xxxdpi-svg.epub) () |   |   |
| **JPG**      |             | [ePub](http://files.dodeeric.be/CEB-2015-Solides-et-figures-150dpi-jpg.epub) () | [ePub](http://files.dodeeric.be/CEB-2015-Solides-et-figures-300dpi-jpg.epub) () |         |
| **PNG**      |             | [ePub](http://files.dodeeric.be/CEB-2015-Solides-et-figures-150dpi-png.epub) () | [ePub](http://files.dodeeric.be/CEB-2015-Solides-et-figures-300dpi-png.epub) () |         |
| **SVG**      | [HTML](http://files.dodeeric.be/CEB-2015-Solides-et-figures-xxxdpi-svg.html) () |   |   |
| **JPG**      |   | [HTML](http://files.dodeeric.be/CEB-2015-Solides-et-figures-150dpi-jpg.html) () | [HTML](http://files.dodeeric.be/CEB-2015-Solides-et-figures-300dpi-jpg.html) () |
| **PNG**      |   | [HTML](http://files.dodeeric.be/CEB-2015-Solides-et-figures-150dpi-png.html) () | [HTML](http://files.dodeeric.be/CEB-2015-Solides-et-figures-300dpi-png.html) () |

## Additional information

### Book

The script is based on the method described in my book published in 2014: *Fixed Layout ePub: A Practical Guide to Publish eBooks from PDF Files*. It is available on [Amazon](https://www.amazon.fr/dp/1502809508) and on [Googgle Play Books](https://play.google.com/store/books/details?id=LRQ-BQAAQBAJ).

### Fix Layout ePub

To read a fix layout ePub, the best device is a tablet (Android or iOS/iPad). A smartphone is not adapted most of the time because of the too small screen size.

A lot of ePub reader apps exist (to read reflowable text ePub and fixed layout ePub) available on different platforms (Android, iOS, Windows, MacOS, or Linux): [Google Play Books](https://play.google.com/store/apps/details?id=com.google.android.apps.books), [BookShelf](https://support.vitalsource.com/hc/en-us/articles/201344733-Download-Bookshelf), [PocketBook](https://pocketbook.ch/en-ch/app), [Adobe Digital Editions](https://www.adobe.com/solutions/ebook/digital-editions/download.html), [Apple Books](https://www.apple.com/apple-books) (only on iOS; formely known as Apple iBooks), etc. 

Amazon Kindle does not support the standard ePub format (they have their own format which is based on the ePub format).

To use Google Play Books, you have to go to **Settings**, then set **Enable uploading (from downloads, mail or other apps)**. The uploaded eBooks (PDF or ePub) will be available on all devices using the same Google account. You can also upload eBooks from the [Google Play Books web interface](https://play.google.com/books) (see the **Upload files** button on the top right corner).
 
More about fixed layout (FXL) ePub version 3 specifications (IDPF / W3C): [Fixed Layouts (EPUB Content Documents 3.2)](https://www.w3.org/publishing/epub/epub-contentdocs.html#sec-fixed-layouts) and [Fixed-Layout Properties (EPUB Packages 3.2)](https://www.w3.org/publishing/epub/epub-packages.html#sec-package-metadata-fxl).

### Other Git Repositories

Repositories for *pdf2htmlEX*: the [original one](https://github.com/coolwanglu/pdf2htmlEX) and the [new one](https://github.com/pdf2htmlEX/pdf2htmlEX) (with updated .deb packages).

This script is based on the Bash scripts written by Robert Clayton (RNCTX) and available in [his Git repository](https://github.com/RNCTX/PDF2HTMLEX-EPUB3FIXED).
