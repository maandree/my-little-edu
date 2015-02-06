PAPER = unix-design
FIGURES = 
TEX = pdflatex

.PHONY: all
all: $(PAPER).pdf

figure-%.pdf: figure-%.svg
	rsvg-convert -f pdf $< > $@

$(PAPER).pdf: $(PAPER).tex $(foreach F,$(FIGURES),figure-$(F).pdf)
	yes X | $(TEX) $<

.PHONY: clean
clean:
	-rm -f $(PAPER).aux $(PAPER).log $(PAPER).out $(PAPER).pdf
	-rm -f $(foreach F,$(FIGURES),figure-$(F).pdf)

