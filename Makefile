FILENAME = example

date = $(shell date +%Y-%m-%d)
output_file = draft_$(date).pdf

figure_src = $(wildcard img/*.svg img/*/*.svg)
figure_list = $(figure_src:.svg=.pdf)

LATEX = lualatex

BIBTEX = bibtex

default: poster

figures: $(figure_list)

# Target assumes figure source is in same directory as expected figure path
img/%.pdf: img/%.svg
	inkscape -z -D --file=$(basename $@).svg --export-pdf=$(basename $@).pdf

poster: figures
	latexmk -$(LATEX) -logfilewarnings -halt-on-error $(FILENAME)

clean:
	rm -f *.aux *.bbl *.blg *.dvi *.idx *.lof *.log *.lot *.toc \
		*.xdy *.nav *.out *.snm *.vrb *.mp \
		*.synctex.gz *.brf *.fls *.fdb_latexmk \
		*.glg *.gls *.glo *.ist *.alg *.acr *.acn

realclean: clean
	rm -f *.ps *.pdf
