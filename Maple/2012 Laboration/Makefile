BOOK = maple
LANG = sv

default: pdf softer

all: info pdf softer

info:
	makeinfo "$(BOOK).texinfo"
	gzip -9  "$(BOOK).info"

pdf:
	texi2pdf "$(BOOK).texinfo"
	for ext in `echo aux cp cps fn ky log pg toc tp vr`; do           \
	    (if [ -f "$(BOOK).$$ext" ]; then unlink "$(BOOK).$$ext"; fi);  \
	done
	if [ -d "$(BOOK).t2d" ]; then rm -r "$(BOOK).t2d"; fi

soft:
	mv "$(BOOK).pdf" "$(BOOK)+print.pdf"
	pdfjam --pagecolor 249,249,249 -o "$(BOOK).pdf" "$(BOOK)+print.pdf"

softer:
	mv "$(BOOK).pdf" "$(BOOK)+print.pdf"
	pdfjam --pagecolor 249,246,240 -o "$(BOOK).pdf" "$(BOOK)+print.pdf"

noprint:
	unlink "$(BOOK)+print.pdf"

spell:
	aspell --lang="$(LANG)" check "$(BOOK).texinfo"

clean:
	for ext in `echo aux cp cps fn ky log pg toc tp vr bak`; do       \
	    (if [ -f "$(BOOK).$$ext" ]; then unlink "$(BOOK).$$ext"; fi);  \
	done
	if [ -d "$(BOOK).t2d" ]; then rm -r "$(BOOK).t2d"; fi
	if [ -f "$(BOOK).texinfo.back" ]; then unlink "$(BOOK).texinfo.back"; fi

