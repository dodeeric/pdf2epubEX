#!/bin/bash

# Bash script to convert a PDF file (myfile.pdf) to a fixed layout ePub file (myfile.epub).
# By Eric Dodémont (eric.dodemont@skynet.be), Belgium, July 2020.
# The script uses the pdf2htmlEX tool to convert a PDF file to an ePub file.
# The result is a fixed layout ePub: the layout is perfectly retained and all the fonts are embedded.
# The pdf2htmlEX tool converts a PDF file into HTML5 (with CSS, JS, fonts, and bitmap and/or vector images).
# This means that the pages are not just converted into images as a lot of converters are doing.
# Usage: ./pdf2epubEX.sh myfile.pdf
# Prerequisites: install pdf2htmlEX and some other utilities: poppler-utils, bc, zip and file.

# Adding reflowable text option

if [ -z "$1" ] ; then
  echo "Error: no PDF file specified." ; exit 1
fi

if ! test -f "$1" ; then
  echo "Error: file does not exist." ; exit 1 
fi

testfile=$(file "$1" | grep "PDF document")
if [ -z "$testfile" ] ; then
  echo "Error: the file is not a PDF file." ; exit 1
fi

cp $1 ./mybook.pdf

widthinpts=$(pdfinfo $1 2>/dev/null | grep "Page size" | cut -d " " -f8) # Unit is points (pts)
heightinpts=$(pdfinfo $1 2>/dev/null | grep "Page size" | cut -d " " -f10) # Unit is points (pts)

width=$(bc <<< "$widthinpts*0.0138889") # From points to inches
height=$(bc <<< "$heightinpts*0.0138889") # From points to inches

widthincm=$(bc <<< "$widthinpts*0.0352778") # From points to cm
heightincm=$(bc <<< "$heightinpts*0.0352778") # From points to cm

factorratio=$(bc <<< "scale=9; $heightinpts/$widthinpts")

hres=900 # Horizontal resolution in pixels
vres=$(bc <<< "scale=0; $hres*$factorratio/1.0") # Vertical resolution in pixels

widthrounded=$(LC_NUMERIC="C" printf "%0.2f\n" $width)
widthincmrounded=$(LC_NUMERIC="C" printf "%0.1f\n" $widthincm)

heightrounded=$(LC_NUMERIC="C" printf "%0.2f\n" $height)
heightincmrounded=$(LC_NUMERIC="C" printf "%0.1f\n" $heightincm)

factorratiorounded=$(LC_NUMERIC="C" printf "%0.2f\n" $factorratio)

read -p "Do you want a fixed layout ePub or a reflowable text ePub? (f or r) [default: f]: " epubtype

# reflowable text - begin

if [ "$epubtype" == "r" ] ; then

echo "$epubtype"

pdftohtml -noframes mybook.pdf

exit 0
  
fi

# reflowable text - end

echo "-------------------------------------------------------------------------------------------------"
echo "Book/PDF Width: $widthrounded inches / $widthincmrounded cm"
echo "Book/PDF Height: $heightrounded inches / $heightincmrounded cm"
echo "Factor ratio (Height / Width): $factorratiorounded"
echo "ePub Viewport (Width x Height): $hres pixels x $vres pixels"
echo "-------------------------------------------------------------------------------------------------"

read -p "Do you want to see more information on the PDF file? (y or n) [default: n]: " moreinfo

nbrfonts=$(($(pdffonts $1 | wc -l)-2))

if [ "$moreinfo" == "y" ] || [ "$moreinfo" == "Y" ] || [ "$moreinfo" == "yes" ] || [ "$moreinfo" == "Yes" ] ; then
  echo "-------------------------------------------------------------------------------------------------"
  pdfinfo $1 | grep -v "UserProperties:" | grep -v "Suspects:" | grep -v "Form:" | grep -v "JavaScript:" | grep -v "Encrypted:" | grep -v "Page size:" | grep -v "Page rot:"
  echo "PDF fonts:"
  echo "name                                 type              encoding         emb sub uni object id"
  pdffonts $1 | tail -$nbrfonts
  echo "-------------------------------------------------------------------------------------------------"
fi 

pdftitle=$(pdfinfo $1 2>/dev/null | grep "Title:" | cut -d " " -f11-50)
pdfauthor=$(pdfinfo $1 2>/dev/null | grep "Author:" | cut -d " " -f10-50)

echo "======================"
echo "Caution:"
echo "- if you chose png or jpg (bitmap formats), the vector images will be converted in bitmap images (rasterized)."
echo "- if you chose svg (vector and bitmap format), the vector images will remain in vector format, but: a) you cannot chose the resolution of the bitmap images (it is the one from the PDF); b) the bitmap images will be included in the svg files (Base64 coded); c) this format is not always correctly rendered by eBook readers; d) the generated epub file is not always passing the epub check." 
echo "======================"

echo "If you want, you can hit <ENTER> to all the next questions."

read -p "Format of the images in the epub (png, jpg or svg) [default: jpg]: " imgformat

if [ -z "$imgformat" ] ; then
  imgformat="jpg"
fi 

if [ "$imgformat" != "png" ] && [ "$imgformat" != "jpg" ] && [ "$imgformat" != "svg" ] ; then
  echo "Error: image format incorrect." ; exit 1
fi 

if [ "$imgformat" != "svg" ] ; then
  read -p "Resolution of the images in the epub in dpi (e.g.: 150 or 300) [default: 150]: " dpi
fi

if [ "$imgformat" == "svg" ] ; then
  dpi=300
fi

if [ -z "$dpi" ] ; then
  dpi=150
fi 
  
re='^[0-9]+$'
if ! [[ "$dpi" =~ $re ]] ; then
  echo "Error: image resolution incorrect." ; exit 1
fi

if [ -z "$pdftitle" ] ; then
  read -p "Title [Default: None]: " title
else
  read -p "Title [Default: $pdftitle]: " title
fi

if [ -z "$pdfauthor" ] ; then
  read -p "Author [Default: None]: " author
else
  read -p "Author [Default: $pdfauthor]: " author
fi

read -p "Publisher [Default: None]: " publisher
read -p "Year [Default: 1900]:" year
read -p "Language (e.g.: fr) [Default: en]: " language
read -p "ISBN number [Default: None]: " isbn
read -p "Subject (e.g.: history) [Default: None]: " tags

if [ -z "$title" ] && [ -z "$pdftitle" ] ; then
  title="None"
else
  if [ -z "$title" ]; then
    title="$pdftitle"
  fi
fi 

if [ -z "$author" ] && [ -z "$pdfauthor" ] ; then
  author="None"
else
  if [ -z "$author" ]; then
    author="$pdfauthor"
  fi
fi 

if [ -z "$publisher" ] ; then
  publisher="None"
fi 

if [ -z "$year" ] ; then
  year="1900"
fi 

if [ -z "$language" ] ; then
  language="en"
fi 

if [ -z "$isbn" ] ; then
  isbn="None"
fi 

if [ -z "$tags" ] ; then
  tags="None"
fi 

echo "Wait..."

# pdf2htmlEX: the parameter --dpi and --fit-width/fit-height are totaly independant.

pdf2htmlEX --embed-css 0 --embed-font 0 --embed-image 0 --embed-javascript 0 --embed-outline 0 --split-pages 1 --bg-format $imgformat --dpi $dpi --fit-width $hres --fit-height $vres --page-filename mybook%04d.page --css-filename mybook.css mybook.pdf

# Update the top and bottom of each page file

for f in *.page ; do

echo -e "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<html xmlns:epub=\"http://www.idpf.org/2007/ops\" xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n  <meta charset=\"UTF-8\"/>\n  <meta name=\"generator\" content=\"pdf2htmlEX\"/>\n  <link rel=\"stylesheet\" type=\"text/css\" href=\"base.min.css\"/>\n  <link rel=\"stylesheet\" type=\"text/css\" href=\"mybook.css\"/>\n  <meta name=\"viewport\" content=\"width=$hres, height=$vres\"/>\n  <title>$title</title>\n</head>\n<body>\n<div id=\"page-container\">" >> tmpfile
cat "$f" >> tmpfile
echo -e "</div>\n</body>\n</html>" >> tmpfile
mv tmpfile "$f"

done

# Rename each page file

for f in *.page; do
mv "$f" "`basename "$f" .page`.xhtml"
done

# Remove files which are not needed in the epub

rm -f *.outline
rm -f pdf2htmlEX-64x64.png
rm -f fancy.min.css
rm -f pdf2htmlEX.min.js
rm -f compatibility.min.js
rm -f mybook.html

mkdir ./bookroot/
mkdir ./bookroot/META-INF/
mkdir ./bookroot/OEBPS/

mv *.css ./bookroot/OEBPS/
mv *.woff ./bookroot/OEBPS/
mv *.xhtml ./bookroot/OEBPS/

if [ $imgformat == "png" ] ; then
  mv *.png ./bookroot/OEBPS/
fi

if [ $imgformat == "jpg" ] ; then
  mv *.jpg ./bookroot/OEBPS/
fi

if [ $imgformat == "svg" ] ; then
  mv *.svg ./bookroot/OEBPS/
fi

echo -n "application/epub+zip" > ./bookroot/mimetype

echo -e "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<container version=\"1.0\" xmlns=\"urn:oasis:names:tc:opendocument:xmlns:container\">\n  <rootfiles>\n    <rootfile full-path=\"OEBPS/content.opf\" media-type=\"application/oebps-package+xml\"/>\n  </rootfiles>\n</container>" > bookroot/META-INF/container.xml

# Create the cover: PDF first page (text + images) --> cover.png

pdftoppm mybook.pdf cover -cropbox -png -f 1 -r $dpi -singlefile
mv cover.png ./bookroot/OEBPS/

# Create the nav.xhtm file (TOC)

echo -e "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<html xmlns:epub=\"http://www.idpf.org/2007/ops\"\n   xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n <title>$title</title>\n</head>\n<body>\n <nav epub:type=\"toc\" id=\"toc\">\n  <ol>\n    <li>\n     <a href=\"mybook0001.xhtml\">Chapter 1 Like This</a>\n    </li>\n    <li>\n     <a href=\"mybook0002.xhtml\">Chapter 2 Like This</a>\n    </li>\n  </ol>\n</nav>\n <nav epub:type=\"landmarks\">\n  <ol>\n   <li>\n     <a epub:type=\"frontmatter\" href=\"mybook0001.xhtml\">Cover</a>\n   </li>\n   <li>\n    <a epub:type=\"bodymatter\" href=\"mybook0002.xhtml\">Bodymatter</a>\n   </li>\n  </ol>\n </nav>\n <nav epub:type=\"page-list\" hidden=\"\">\n  <ol>" > ./nav

cd ./bookroot/OEBPS/

for j in *.xhtml; do
filenumber=$(echo "$j" | sed 's/[^0-9][^0-9]*\([0-9][0-9]*\).*/\1/g')
echo -e "   <li>\n    <a href=\"$j\">$filenumber</a>\n   </li>" >> ../../nav
done

echo -e "  </ol>\n </nav>\n</body>\n</html>" >> ../../nav

cd ../../

# Generate the manisfest

if [ "$imgformat" == "svg" ] ; then
  dpi=xxx
fi

date=$(date +%Y-%m-%dT%H:%M:%SZ)
description="PDF: $1, $widthrounded inches x $heightrounded inches, $widthincmrounded cm x $heightincmrounded cm - ePub: $dpi dpi, $imgformat - Software: pdf2htmlEX, pdf2epubEX/Eric Dodemont"

echo -e "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<package xmlns=\"http://www.idpf.org/2007/opf\" prefix=\"rendition: http://www.idpf.org/vocab/rendition/#\" unique-identifier=\"pub-id\" version=\"3.0\">\n  <metadata xmlns:dc=\"http://purl.org/dc/elements/1.1/\">\n    <dc:identifier id=\"pub-id\">$isbn</dc:identifier>\n    <dc:title>$title</dc:title>\n    <dc:creator>$author</dc:creator>\n    <dc:publisher>$publisher</dc:publisher>\n    <dc:language>$language</dc:language>\n    <dc:subject>$tags</dc:subject>\n    <dc:date>$year</dc:date>\n    <dc:description>$description</dc:description>\n    <meta content=\"cover-image\" name=\"cover\"/>\n    <meta property=\"dcterms:modified\">$date</meta>\n    <meta property=\"rendition:layout\">pre-paginated</meta>\n    <meta property=\"rendition:spread\">auto</meta>\n  </metadata>\n  <manifest>" > ./bookroot/OEBPS/content.opf

cd ./bookroot/OEBPS/

# 1) files

for f in *.xhtml; do
ff=`basename "$f" .xhtml`
echo -e "    <item id=\"$ff\" href=\"$f\" media-type=\"application/xhtml+xml\"/>" >> ./content.opf
done

# 2) images

if [ $imgformat == "png" ] ; then

mv cover.png cover.xxx
for f in *.png; do
ff=`basename "$f" .png`
echo -e "    <item id=\"$ff\" href=\"$f\" media-type=\"image/png\"/>" >> ./content.opf
done
mv cover.xxx cover.png

fi

if [ $imgformat == "jpg" ] ; then

for f in *.jpg; do
ff=`basename "$f" .jpg`
echo -e "    <item id=\"$ff\" href=\"$f\" media-type=\"image/jpeg\"/>" >> ./content.opf
done

fi

if [ $imgformat == "svg" ] ; then

for f in *.svg ; do
ff=`basename "$f" .svg`
echo -e "    <item id=\"$ff\" href=\"$f\" media-type=\"image/svg+xml\"/>" >> ./content.opf
done

fi

# 3) fonts

for f in *.woff; do
ff=`basename "$f" .woff`
echo -e "    <item id=\"$ff\" href=\"$f\" media-type=\"application/font-woff\"/>" >> ./content.opf
done

echo -e "    <item id=\"base-min-css\" href=\"base.min.css\" media-type=\"text/css\"/>" >> ./content.opf
echo -e "    <item id=\"mybook-css\" href=\"mybook.css\" media-type=\"text/css\"/>" >> ./content.opf
echo -e "    <item id=\"cover-image\" href=\"cover.png\" media-type=\"image/png\" properties=\"cover-image\"/>" >> ./content.opf
echo -e "    <item id=\"nav\" href=\"nav.xhtml\" media-type=\"application/xhtml+xml\" properties=\"nav\"/>\n  </manifest>\n  <spine>" >> ./content.opf

for f in *.xhtml; do
ff=`basename "$f" .xhtml`
echo -e "    <itemref idref=\"$ff\" properties=\"rendition:layout-pre-paginated\"/>" >> ./content.opf
done

echo -e "  </spine>\n  <guide>\n    <reference type=\"cover\" title=\"Cover\" href=\"mybook0001.xhtml\"/>\n    <reference type=\"text\" title=\"Text\" href=\"mybook0002.xhtml\"/>\n  </guide>\n</package>" >> ./content.opf

cat ../../nav > ./nav.xhtml

sed -i 's/;unicode-bidi:bidi-override//g' base.min.css

cd ../

epubfilename=`basename "$1" .pdf`
epubfilename=$(echo $epubfilename"-"$dpi"dpi-"$imgformat)

zip -0Xq ./$epubfilename.epub mimetype && zip -Xr9Dq ./$epubfilename.epub * -x mimetype -x ./$epubfilename.epub && mv ./$epubfilename.epub ../$epubfilename.epub

echo "Done"

cd ../

rm -f ./nav
rm -f ./isbndata
rm -f ./metadata
rm -f ./mybook.pdf
rm -rf ./bookroot

exit 0
