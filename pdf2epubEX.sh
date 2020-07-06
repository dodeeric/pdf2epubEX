#!/bin/bash

cp $1 ./mybook.pdf

echo -n "Width of your book/pdf in inches (e.g.: 8): "
#read width
echo -n "Height of your book/pdf in inches (ex.: 10): "
#read height

echo -n "Resolution of the images in the epub in dpi (ex.: 300): "
#read dpi
#echo -n "Format of the images in the epub (png, jpg, svg): "
#read imgformat

#echo -n "Horizontal resolution of your device/tablet in pixels (the smaller number) (e.g.: 1080): "
#read hdpi # in pixels, not in dot/pixel per inch! / Should be called hres!
#echo -n "Vertical resolution of your device/tablet in pixels (the larger number) (e.g.: 1920): "
#read vdpi # in pixels, not in dot/pixel per inch! / Should be called vres!

echo -n "Title: "
#read title
echo -n "Author: "
#read author
echo -n "Publisher: "
#read publisher
echo -n "Publication year: "
#read year
echo -n "Language: (e.g.: fr): "
#read lang
echo -n "ISBN number: "
#read isbn
echo -n "dc:subject (e.g.: history): "
#read tags

width=8
height=10

dpi=300
imgformat="png"

#Samsung Galaxy Tab A (W=1080 x H=1920)
#hdpi=1080
#vdpi=1920

# viewport = (dpi x width) X (dpi x height) ==> hdpi = dpi * width / vdpi = dpi * height
#hdpi=300*8=2400
#vdpi=300*10=3000
#hdpi=2400
#vdpi=3000

#hdpi=$(($dpi*$width))
#vdpi=$(($dpi*$height))

# Ensuite réduire pour "tenir" dans l'écran de la tablette mais en gardant le ratio (height / width du livre/pdf)
hdpi=900
vdpi=1125

title="Test2"
author="Eric Dodémont"
publisher="Heta"
year="2020"
lang="fr"
isbn="1234567890"
tags="history"

echo "Wait..."

pdf2htmlEX --embed-css 0 --embed-font 0 --embed-image 0 --embed-javascript 0 --embed-outline 0 --split-pages 1 --bg-format $imgformat --dpi $dpi --fit-width $hdpi --fit-height $vdpi --page-filename mybook%04d.page --css-filename mybook.css mybook.pdf

# Update the top and bottom of each page file

for f in *.page; do
echo -e "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<html xmlns:epub=\"http://www.idpf.org/2007/ops\" xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n  <meta charset=\"UTF-8\"/>\n  <meta name=\"generator\" content=\"pdf2htmlEX\"/>\n  <link rel=\"stylesheet\" type=\"text/css\" href=\"base.min.css\"/>\n  <link rel=\"stylesheet\" type=\"text/css\" href=\"mybook.css\"/>\n  <meta name=\"viewport\" content=\"width=$hdpi, height=$vdpi\"/>\n  <title>$title</title>\n</head>\n<body>\n<div id=\"page-container\">" >> tmpfile
cat "$f" >> tmpfile
echo -e "</div>\n</body>\n</html>" >> tmpfile
mv tmpfile "$f"
done

# Rename each page file

for g in *.page; do
mv "$g" "`basename "$g" .page`.xhtml"
done

# Update the SVG version of each background file (if SVG has been chosen)

#for h in *.svg; do
#sed -i 's/version="1.2"/version="1.1"/g' "$h"
#done

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
#mv *.svg ./bookroot/OEBPS/
mv *.png ./bookroot/OEBPS/
#mv *.jpg ./bookroot/OEBPS/

echo -n "application/epub+zip" > ./bookroot/mimetype

echo -e "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<container version=\"1.0\" xmlns=\"urn:oasis:names:tc:opendocument:xmlns:container\">\n  <rootfiles>\n    <rootfile full-path=\"OEBPS/content.opf\" media-type=\"application/oebps-package+xml\"/>\n  </rootfiles>\n</container>" > bookroot/META-INF/container.xml

pdfimages -png -f 1 -l 1 mybook.pdf mybook 
mv mybook-000.png ./bookroot/OEBPS/cover.png
rm -f *.png

# nav file

echo -e "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<html xmlns:epub=\"http://www.idpf.org/2007/ops\"\n   xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n <title>$title</title>\n</head>\n<body>\n <nav epub:type=\"toc\" id=\"toc\">\n  <ol>\n    <li>\n     <a href=\"mybook0001.xhtml\">Chapter 1 Like This</a>\n    </li>\n    <li>\n     <a href=\"mybook0002.xhtml\">Chapter 2 Like This</a>\n    </li>\n  </ol>\n</nav>\n <nav epub:type=\"landmarks\">\n  <ol>\n   <li>\n     <a epub:type=\"frontmatter\" href=\"mybook0001.xhtml\">Cover</a>\n   </li>\n   <li>\n    <a epub:type=\"bodymatter\" href=\"mybook0002.xhtml\">Bodymatter</a>\n   </li>\n  </ol>\n </nav>\n <nav epub:type=\"page-list\" hidden=\"\">\n  <ol>" > ./nav

cd ./bookroot/OEBPS/

for j in *.xhtml; do
filenumber=$(echo "$j" | sed 's/[^0-9][^0-9]*\([0-9][0-9]*\).*/\1/g')
echo -e "   <li>\n    <a href=\"$j\">$filenumber</a>\n   </li>" >> ../../nav
done

echo -e "  </ol>\n </nav>\n</body>\n</html>" >> ../../nav

cd ../../

date=$(date +%Y-%m-%dT%H:%M:%SZ)

echo -e "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<package xmlns=\"http://www.idpf.org/2007/opf\" prefix=\"rendition: http://www.idpf.org/vocab/rendition/#\" unique-identifier=\"pub-id\" version=\"3.0\">\n  <metadata xmlns:dc=\"http://purl.org/dc/elements/1.1/\">\n    <dc:identifier id=\"pub-id\">$isbn</dc:identifier>\n    <dc:title>$title</dc:title>\n    <dc:creator>$author</dc:creator>\n    <dc:publisher>$publisher</dc:publisher>\n    <dc:language>$lang</dc:language>\n    <dc:subject>$tags</dc:subject>\n    <dc:description>$tags</dc:description>\n    <meta content=\"cover_image\" name=\"cover\"/>\n    <meta property=\"dcterms:modified\">$date</meta>\n    <meta property=\"rendition:layout\">pre-paginated</meta>\n    <meta property=\"rendition:spread\">auto</meta>\n  </metadata>\n  <manifest>" > ./bookroot/OEBPS/content.opf

cd ./bookroot/OEBPS/

# 1) files

for f in *.xhtml; do
filenum=$(echo "$f" | sed 's/[^0-9][^0-9]*\([0-9][0-9]*\).*/\1/g')
echo -e "    <item id=\"page$filenum\" href=\"$f\" media-type=\"application/xhtml+xml\"/>" >> ./content.opf
done

# 2) images (PNG)

mv cover.png cover.xxx

for f in *.png; do
filenum=$(echo "$f" | sed 's/[^0-9][^0-9]*\([0-9][0-9]*\).*/\1/g')
echo -e "    <item id=\"image-page$filenum\" href=\"$f\" media-type=\"image/png\"/>" >> ./content.opf
done

mv cover.xxx cover.png

# 3) fonts

for f in *.woff; do
fontnum=$(echo "$f" | sed 's/[^0-9][^0-9]*\([0-9][0-9]*\).*/\1/g')
echo -e "    <item id=\"font$fontnum\" href=\"$f\" media-type=\"application/font-woff\"/>" >> ./content.opf
done

echo -e "    <item id=\"base-min-css\" href=\"base.min.css\" media-type=\"text/css\"/>" >> ./content.opf
echo -e "    <item id=\"mybook-css\" href=\"mybook.css\" media-type=\"text/css\"/>" >> ./content.opf
echo -e "    <item id=\"cover-image\" href=\"cover.png\" media-type=\"image/png\" properties=\"cover-image\"/>" >> ./content.opf
echo -e "    <item id=\"nav\" href=\"nav.xhtml\" media-type=\"application/xhtml+xml\" properties=\"nav\"/>\n  </manifest>\n  <spine>" >> ./content.opf

for g in *.xhtml; do
pagenum=$(echo "$g" | sed 's/[^0-9][^0-9]*\([0-9][0-9]*\).*/\1/g')
echo -e "    <itemref idref=\"page$pagenum\" properties=\"rendition:layout-pre-paginated\"/>" >> ./content.opf
done

echo -e "  </spine>\n  <guide>\n    <reference type=\"cover\" title=\"Cover\" href=\"mybook0001.xhtml\"/>\n    <reference type=\"text\" title=\"Text\" href=\"mybook0002.xhtml\"/>\n  </guide>\n</package>" >> ./content.opf

cat ../../nav > ./nav.xhtml

sed -i 's/;unicode-bidi:bidi-override//g' base.min.css

cd ../

zip -0Xq ./$1.epub mimetype && zip -Xr9Dq ./$1.epub * -x mimetype -x ./$1.epub && mv ./$1.epub ../$1.epub

echo "Done"

cd ../

rm -f ./nav
rm -f ./isbndata
rm -f ./metadata
rm -f ./mybook.pdf
rm -rf ./bookroot

exit 0;
