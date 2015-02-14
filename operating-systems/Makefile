FIGURES = gnu hurd linux netbsd openbsd dragonflybsd # freebsd

.PHONY: default
default: pdf

.PHONY: all
all: pdf figures

.PHONY: pdf
pdf: presentation.pdf

.PHONY: figures
figures: $(foreach F,$(FIGURES),$(F).pdf)

%.pdf: %.svg
	rsvg-convert -f pdf $< > $@

presentation.pdf: presentation.tex $(foreach F,$(FIGURES),$(F).pdf) *.png Makefile
	yes X | pdflatex "$<"
	yes X | pdflatex "$<"


.PHONY: clean-mostly
clean-mostly:
	-rm *.{aux,log,nav,out,toc,snm}

.PHONY: clean
clean:
	-rm *.{pdf,dvi,ps}

