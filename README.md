# pdf2epubEX

This Bash script uses the *pdf2htmlEX* tool to convert a PDF file to an ePub file.

The result is a *fixed layout* ePub version 3: the layout is perfectly retained and all the fonts are embedded.

The *pdf2htmlEX* tool converts a PDF file into HTML5 (with CSS, JS, fonts, and bitmap and/or vector images). This means that the pages are not just converted into images as a lot of converters are doing.

Once you have an ePub file, only if you want, you can edit it with one of the available tools (Sigil, Calibre, Kotobee, etc.) to add interactive content, add reflowable text, etc.

If you want to publish an eBook on one of the available eBook stores (Google Play Books, Apple Books, Rakuten Kobo, etc.), you have to provide an ePub file and not a PDF file.

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

## Using the Docker image

A Docker image is vailable on [my DockerHub repository](https://hub.docker.com/r/dodeeric/pdf2epubex).

### Usage

If you are running Linux:

To convert myfile.pdf to myfile.epub, run the following command in the directory where the PDF file is located:

```
docker run -ti --rm -v `pwd`:/temp dodeeric/pdf2epubex pdf2epubEX.sh myfile.pdf
```

The result will be: myfile.epub

You can also use *pdf2htmlEX* with this same Docker image:

To convert myfile.pdf to myfile.html, run the following command in the directory where the PDF file is located:

```
docker run -ti --rm -v `pwd`:/temp dodeeric/pdf2epubex pdf2htmlEX myfile.pdf
```

The result will be: myfile.html

*pdf2htmlEX* has a lot of parameters. To see them:

```
docker run -ti --rm -v `pwd`:/temp dodeeric/pdf2epubex pdf2htmlEX --help
```

If you are running Windows:

To convert C:\Users\Eric\Documents\myfile.pdf to C:\Users\Eric\Documents\myfile.epub, run the following command in the PowerShell terminal:

```
docker run -ti --rm -v C:\Users\Eric\Documents:/temp dodeeric/pdf2epubex pdf2epubEX.sh myfile.pdf
```

or

```
docker run -ti --rm -v /c/Users/Eric/Documents:/temp dodeeric/pdf2epubex pdf2epubEX.sh myfile.pdf
```

The result will be: C:\Users\Eric\Documents\myfile.epub

### Prerequisites

You need to install Docker which is available for all computer operating systems: Linux, Windows and MacOS. See [here](https://docs.docker.com/engine/install).

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

In the examples below, the HTML version is one big file including everything (all the pages with HTML5, CSS, JS, fonts and images; fonts and images are coded in Base64, which can make the file quite big). *pdf2htmlEX* can also put all that content in different files (.html, .css, .js, .woff, .png, .jpg, .svg); that's in fact what basicaly the *pdf2epubEX.sh* script does before wripping all the files in one ePub container file (.epub). Sometime, ePub is referred as "website in a box".

Legends:

- Number in parentheses: the size of the file in MB.<br/>
- Hashtag in parentheses: the ePub file does not pass the epub check validation using version epub 3.2 rules (commands not allowed in some svg files). This does not mean the ePub will not be displayed properly in most ePub readers.<br>
- ePub written in bold: the recommended ePub version. 

**CEB 2015 - Solides et figures**<br/>
(24 pages, only vector images in the PDF)

|              |             | 150 DPI  | 300 DPI |
| ---          | ---         | ----     | ---     |
| **PDF**      | [PDF](http://files.dodeeric.be/CEB-2015-Solides-et-figures.pdf) (0.3) |   |   |
| **SVG**      | [ePub](http://files.dodeeric.be/CEB-2015-Solides-et-figures-xxxdpi-svg.epub) (1.0)(#) |   |   |
| **JPG**      |             | [ePub](http://files.dodeeric.be/CEB-2015-Solides-et-figures-150dpi-jpg.epub) (0.6) | [ePub](http://files.dodeeric.be/CEB-2015-Solides-et-figures-300dpi-jpg.epub) (1.1) |         |
| **PNG**      |             | [ePub](http://files.dodeeric.be/CEB-2015-Solides-et-figures-150dpi-png.epub) (0.7) | **[ePub](http://files.dodeeric.be/CEB-2015-Solides-et-figures-300dpi-png.epub)** (1.5) |         |
| **SVG**      | [HTML](http://files.dodeeric.be/CEB-2015-Solides-et-figures-xxxdpi-svg.html) (2.2) |   |   |
| **JPG**      |   | [HTML](http://files.dodeeric.be/CEB-2015-Solides-et-figures-150dpi-jpg.html) (1.8) | [HTML](http://files.dodeeric.be/CEB-2015-Solides-et-figures-300dpi-jpg.html) (5.7) |
| **PNG**      |   | [HTML](http://files.dodeeric.be/CEB-2015-Solides-et-figures-150dpi-png.html) (1.1) | [HTML](http://files.dodeeric.be/CEB-2015-Solides-et-figures-300dpi-png.html) (2.5) |

**Install your own OpenStack Cloud**<br/> 
(49 pages, bitmap and vector images in the PDF)

|              |             | 150 DPI  | 300 DPI |
| ---          | ---         | ----     | ---     |
| **PDF**      | [PDF](http://files.dodeeric.be/Install-your-own-OpenStack-Cloud-Eric-Dodemont.pdf) (1.0) |   |   |
| **SVG**      | [ePub](http://files.dodeeric.be/Install-your-own-OpenStack-Cloud-Eric-Dodemont-xxxdpi-svg.epub) (1.4) |   |   |
| **JPG**      |             | [ePub](http://files.dodeeric.be/Install-your-own-OpenStack-Cloud-Eric-Dodemont-150dpi-jpg.epub) (1.5) | [ePub](http://files.dodeeric.be/Install-your-own-OpenStack-Cloud-Eric-Dodemont-300dpi-jpg.epub) (2.0) |
| **PNG**      |             | [ePub](http://files.dodeeric.be/Install-your-own-OpenStack-Cloud-Eric-Dodemont-150dpi-png.epub) (1.6) | **[ePub](http://files.dodeeric.be/Install-your-own-OpenStack-Cloud-Eric-Dodemont-300dpi-png.epub)** (3.2) |
| **SVG**      | [HTML](http://files.dodeeric.be/Install-your-own-OpenStack-Cloud-Eric-Dodemont-xxxdpi-svg.html) (2.9) |   |   |
| **JPG**      |             | [HTML](http://files.dodeeric.be/Install-your-own-OpenStack-Cloud-Eric-Dodemont-150dpi-jpg.html) (5.3) | [HTML](http://files.dodeeric.be/Install-your-own-OpenStack-Cloud-Eric-Dodemont-300dpi-jpg.html) (14.0) |
| **PNG**      |             | [HTML](http://files.dodeeric.be/Install-your-own-OpenStack-Cloud-Eric-Dodemont-150dpi-png.html) (3.0) | [HTML](http://files.dodeeric.be/Install-your-own-OpenStack-Cloud-Eric-Dodemont-300dpi-png.html) (6.4) |

**La dynastie belge en images**<br/>
(248 pages, lot of bitmap images in the PDF)

|              | 150 DPI  | 300 DPI |
| ---          | ----     | ---     |
| **PDF**      | [PDF](http://files.dodeeric.be/La-dynastie-belge-en-images-Preview-Eric-Dodemont-150dpi.pdf) (56) | [PDF](http://files.dodeeric.be/La-dynastie-belge-en-images-Preview-Eric-Dodemont-300dpi.pdf) (396) |
| **SVG**      | [ePub](http://files.dodeeric.be/La-dynastie-belge-en-images-Preview-Eric-Dodemont-150dpi-xxxdpi-svg.epub) (78)(#) | [ePub](http://files.dodeeric.be/La-dynastie-belge-en-images-Preview-Eric-Dodemont-300dpi-xxxdpi-svg.epub) (504)(#) |
| **JPG**      | **[ePub](http://files.dodeeric.be/La-dynastie-belge-en-images-Preview-Eric-Dodemont-300dpi-150dpi-jpg.epub)** (48) | [ePub](http://files.dodeeric.be/La-dynastie-belge-en-images-Preview-Eric-Dodemont-300dpi-300dpi-jpg.epub) (150) |
| **PNG**      | [ePub](http://files.dodeeric.be/La-dynastie-belge-en-images-Preview-Eric-Dodemont-300dpi-150dpi-png.epub) (209) | [ePub](http://files.dodeeric.be/La-dynastie-belge-en-images-Preview-Eric-Dodemont-300dpi-300dpi-png.epub) (628) |
| **SVG**      | [HTML](http://files.dodeeric.be/La-dynastie-belge-en-images-Preview-Eric-Dodemont-150dpi-xxxdpi-svg.html) (142) | [HTML](http://files.dodeeric.be/La-dynastie-belge-en-images-Preview-Eric-Dodemont-300dpi-xxxdpi-svg.html) (895) |
| **JPG**      | [HTML](http://files.dodeeric.be/La-dynastie-belge-en-images-Preview-Eric-Dodemont-300dpi-150dpi-jpg.html) (69) | [HTML](http://files.dodeeric.be/La-dynastie-belge-en-images-Preview-Eric-Dodemont-300dpi-300dpi-jpg.html) (217) |
| **PNG**      | [HTML](http://files.dodeeric.be/La-dynastie-belge-en-images-Preview-Eric-Dodemont-300dpi-150dpi-png.html) (296) | [HTML](http://files.dodeeric.be/La-dynastie-belge-en-images-Preview-Eric-Dodemont-300dpi-300dpi-png.html) (869) |

Vector image quality in different formats (zoom of 500 %):

1) SVG (vector format):

| Vector |
| --- |
| ![SVG](http://files.dodeeric.be/i-svg.png) |

2) PNG (bitmap format, lossless compression):

| 150 DPI | 300 DPI |
| ---     | ---     | 
| ![PNG-150](http://files.dodeeric.be/i-png-150.png) | ![PNG-300](http://files.dodeeric.be/i-png-300.png) |

3) JPG (bitmap format, compression with loss):

| 150 DPI | 300 DPI |
| ---     | ---     | 
| ![JPG-150](http://files.dodeeric.be/i-jpg-150.png) | ![JPG-300](http://files.dodeeric.be/i-jpg-300.png) |

## Additional information

### Book

The script is based on the method described in my book published in 2014: *Fixed Layout ePub: A Practical Guide to Publish eBooks from PDF Files*. It is available on [Amazon](https://www.amazon.fr/dp/1502809508) and on [Googgle Play Books](https://play.google.com/store/books/details?id=LRQ-BQAAQBAJ).

### Fixed layout ePub

To read a fixed layout ePub, the best device is a tablet (Android or iOS/iPad). A smartphone is not adapted most of the time because of the too small screen size.

A lot of ePub reader apps exist (to read reflowable text ePub and fixed layout ePub) available on different platforms (Android, iOS, Windows, MacOS, or Linux): [Google Play Books](https://play.google.com/store/apps/details?id=com.google.android.apps.books), [BookShelf](https://support.vitalsource.com/hc/en-us/articles/201344733-Download-Bookshelf), [PocketBook](https://pocketbook.ch/en-ch/app), [Adobe Digital Editions](https://www.adobe.com/solutions/ebook/digital-editions/download.html), [Apple Books](https://www.apple.com/apple-books) (only on iOS; formely known as Apple iBooks), etc. 

Amazon Kindle does not support the standard ePub format (they have their own format which is based on the ePub format).

To use Google Play Books, you have to go to **Settings**, then set **Enable uploading**. The uploaded eBooks (PDF or ePub) will be available on all devices using the same Google account. You can also upload eBooks from the [Google Play Books web interface](https://play.google.com/books) (see the **Upload files** button on the top right corner). Please note that: a) the ePub file has to pass a pre-check to be able to be hosted in the Google cloud; b) if you upload a PDF, all pages (text + images) will be converted into images (the text and vector images are rasterized, and no hidden text layer will be added: it means no text search or copy/paste is possible). 
 
More about fixed layout (FXL) ePub version 3 specifications (IDPF / W3C): [Fixed Layouts (EPUB Content Documents 3.2)](https://www.w3.org/publishing/epub/epub-contentdocs.html#sec-fixed-layouts) and [Fixed-Layout Properties (EPUB Packages 3.2)](https://www.w3.org/publishing/epub/epub-packages.html#sec-package-metadata-fxl).

### Reflowable text ePub

This script is only converting a PDF to a fixed layout ePub. It will be of no use if you want a reflowable text ePub. 

*pdf2htmlEX* is THE tool to maintain the original layout. Hence, it is not the best tool to extract the text and the images from a PDF. 

Regarding the images, *pdf2htmlEX* makes one background image per page which can include more than one image from the PDF.

Regarding the text, even after extracting the text from a PDF, this text will have to be somewhat edited manually or automatically, for example to remove the hyphenations, remove the CR/LF at the end of each lines, remove the page numbers, move the footnotes. This is even more difficult for PDF with sophisticated layout because you will have to move some paragraphs in the correct reading order. 

If you are using Linux, you can install the *poppler-utils* package. Then you can extract the text and the images with the two following tools:

PDF: [myfile.pdf](http://files.dodeeric.be/myfile.pdf) (*Install your own OpenStack Cloud*)

- Extract the text: `pdftotext myfile.pdf` ==> Result: [myfile.txt](http://files.dodeeric.be/myfile.txt)
- Extract the images: `pdfimages -all myfile.pdf ./myfile` ==> Result: [myfile-000.png](http://files.dodeeric.be/myfile-000.png), [myfile-001.png](http://files.dodeeric.be/myfile-001.png), [myfile-002.png](http://files.dodeeric.be/myfile-002.png), [myfile-003.png](http://files.dodeeric.be/myfile-003.png), [myfile-004.jpg](http://files.dodeeric.be/myfile-004.jpg), [myfile-005.png](http://files.dodeeric.be/myfile-005.png), [myfile-006.png](http://files.dodeeric.be/myfile-006.png), [myfile-007.png](http://files.dodeeric.be/myfile-007.png), [myfile-008.png](http://files.dodeeric.be/myfile-008.png), [myfile-009.png](http://files.dodeeric.be/myfile-009.png), [myfile-010.png](http://files.dodeeric.be/myfile-010.png), [myfile-011.jpg](http://files.dodeeric.be/myfile-011.jpg), [myfile-012.jpg](http://files.dodeeric.be/myfile-012.jpg), [myfile-013.jpg](http://files.dodeeric.be/myfile-013.jpg), [myfile-014.png](http://files.dodeeric.be/myfile-014.png), [myfile-015.jpg](http://files.dodeeric.be/myfile-015.jpg), [myfile-016.jpg](http://files.dodeeric.be/myfile-016.jpg), [myfile-017.jpg](http://files.dodeeric.be/myfile-017.jpg), [myfile-018.png](http://files.dodeeric.be/myfile-018.png).

As you can see the text needs heavy manual editing before using a tool to convert it to a reflowable text ePub (Sigil, Calibre, Kotobee, Pandoc, etc.)

### Other Git Repositories

Repositories for *pdf2htmlEX*: the [original one](https://github.com/coolwanglu/pdf2htmlEX) and the [new one](https://github.com/pdf2htmlEX/pdf2htmlEX) (with updated .deb packages).

This script is based on the Bash scripts written by Robert Clayton (RNCTX) and available in [his Git repository](https://github.com/RNCTX/PDF2HTMLEX-EPUB3FIXED).
