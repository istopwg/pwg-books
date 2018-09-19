#!/bin/sh
mmdutil --toc 2 --css ippguide.css intro.md printers.md print-jobs.md quickref.md >ippguide.html
htmldoc --batch ippguide.book
htmldoc --batch ippguide.book -f ippguide.epub
