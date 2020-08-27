# pdf2epubEX

This tool written in Bash uses the *pdf2htmlEX* tool to convert a PDF file to an ePub file.

The result is a *fixed layout* ePub version 3: the layout is perfectly retained and all the fonts are embedded.

The *pdf2htmlEX* tool converts a PDF file into HTML5 (with CSS, JS, fonts, and bitmap and/or vector images).

Once you have an ePub file, only if you want, you can edit it with one of the available tools (Sigil, Calibre, Kotobee, etc.) to add interactive content, add reflowable text, etc.

If you want to publish an eBook on one of the available eBook stores (Google Play Books, Apple Books, Rakuten Kobo, etc.), you have to provide an ePub file and not a PDF file.

## For Linux (Debian, Ubuntu, Mint)

### Usage

To convert myfile.pdf to myfile.epub, open the terminal and run the following command in the directory where the PDF file is located:

```
pdf2epubEX myfile.pdf
```

### Installation

- Add the package repository (repository.dodeeric.be/apt):

```
sudo echo "deb [trusted=yes] https://repository.dodeeric.be/apt/ /" > /tmp/dodeeric.list
sudo mv /tmp/dodeeric.list /etc/apt/sources.list.d/
sudo apt update
```

- Install the package (pdf2epubex):

```
sudo apt install pdf2epubex
```

All the dependencies will be automatically installed.

## For MacOS and Linux (all distributions)

### Usage

To convert myfile.pdf to myfile.epub, open the terminal and run the following command in the directory where the PDF file is located:

```
docker run -ti --rm -v `pwd`:/temp dodeeric/pdf2epubex pdf2epubEX myfile.pdf
```

You can also replace ``` `pwd` ``` by the absolute path of the directory where the PDF file is located (e.g.: /home/dodeeric/Documents/myfile.pdf):

```
docker run -ti --rm -v /home/dodeeric/Documents:/temp dodeeric/pdf2epubex pdf2epubEX myfile.pdf
```

### Installation

You need to install Docker which is available for all computer operating systems: Linux, Windows and MacOS. See [here](https://docs.docker.com/engine/install).

## For Windows

### Usage

To convert C:\Users\Eric\Documents\myfile.pdf to C:\Users\Eric\Documents\myfile.epub, open the PowerShell or the Command Prompt terminal and run the following command:

```
docker run -ti --rm -v C:\Users\Eric\Documents:/temp dodeeric/pdf2epubex pdf2epubEX myfile.pdf
```

or

```
docker run -ti --rm -v /c/Users/Eric/Documents:/temp dodeeric/pdf2epubex pdf2epubEX myfile.pdf
```

### Installation

You need to install Docker which is available for all computer operating systems: Linux, Windows and MacOS. See [here](https://docs.docker.com/engine/install).

Remark: You will first have to install WSL1 (Windows Subsystem Linux), then update to WSL2.

## pdf2htmlEX

You can also use *pdf2htmlEX* with this same Docker image:

To convert myfile.pdf to myfile.html, open the terminal and run the following command in the directory where the PDF file is located:

```
docker run -ti --rm -v `pwd`:/temp dodeeric/pdf2epubex pdf2htmlEX myfile.pdf
```

## Parameters

Once you launch *pdf2epubEX*, some information will be displayed like the book/PDF width and height (in inches and cm), then some questions will be asked like:

- Format of the images in the epub (png, jpg or svg) [default: jpg]
- Resolution of the images in the epub in dpi (e.g.: 150 or 300) [default: 150]
- Title, author, publisher, year, language, ISBN number, subject

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
| **JPG**      |             | [ePub](http://files.dodeeric.be/CEB-2015-Solides-et-figures-150dpi-jpg.epub) (0.6) | [ePub](http://files.dodeeric.be/CEB-2015-Solides-et-figures-300dpi-jpg.epub) (1.1) |
| **PNG**      |             | [ePub](http://files.dodeeric.be/CEB-2015-Solides-et-figures-150dpi-png.epub) (0.7) | **[ePub](http://files.dodeeric.be/CEB-2015-Solides-et-figures-300dpi-png.epub)** (1.5) |
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

This script is converting a PDF to a fixed layout ePub. *pdf2htmlEX* is THE tool to maintain the original layout. Hence, it is not the best tool to extract the text and the images from a PDF.

Anyway, the script will ask if you want a reflowable text ePub or a fixed layout ePub if you:

* Bash script: install the *Calibre* software (```apt install calibre```).
* Docker image: use the image *dodeeric/pdf2epubex:calibre* (image much bigger than *dodeeric/pdf2epubex*).

The script will use the *ebook-convert* command from *Calibre* to convert the PDF to a reflowable text ePub.

Caution: converting automatically a PDF file to a reflowable text ePub file cannot be perfect. We suggest to edit the ePub file manually with Calibre or Sigil.

### Other Git Repositories

Repositories for *pdf2htmlEX*: the [original one](https://github.com/coolwanglu/pdf2htmlEX) and the [new one](https://github.com/pdf2htmlEX/pdf2htmlEX) (with updated .deb packages).

This script is based on the Bash scripts written by Robert Clayton (RNCTX) and available in [his Git repository](https://github.com/RNCTX/PDF2HTMLEX-EPUB3FIXED).
