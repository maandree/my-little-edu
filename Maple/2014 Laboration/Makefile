BOOK = maple
LANG = sv

default: pdf

all: info pdf

info:
	makeinfo "$(BOOK).texinfo"
	gzip -9  "$(BOOK).info"

pdf:
	texi2pdf "$(BOOK).texinfo"
	for ext in `echo aux cp cps fn ky log pg toc tp vr`; do           \
	    (if [ -f "$(BOOK).$$ext" ]; then unlink "$(BOOK).$$ext"; fi);  \
	done
	if [ -d "$(BOOK).t2d" ]; then rm -r "$(BOOK).t2d"; fi

spell:
	aspell --lang="$(LANG)" check "$(BOOK).texinfo"

clean:
	for ext in `echo aux cp cps fn ky log pg toc tp vr bak`; do       \
	    (if [ -f "$(BOOK).$$ext" ]; then unlink "$(BOOK).$$ext"; fi);  \
	done
	if [ -d "$(BOOK).t2d" ]; then rm -r "$(BOOK).t2d"; fi
	if [ -f "$(BOOK).texinfo.bak" ]; then unlink "$(BOOK).texinfo.bak"; fi

