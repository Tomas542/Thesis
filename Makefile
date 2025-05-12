LATEX_COMPILER = pdflatex
LATEX_COMPILER_FLAGS = -interaction=nonstopmode
BIBLIO_COMPILER = bibtex
BIBLIO_COMPILER_FLAGS =

RM = rm -f
TEMPORARY_FILES = *.out *.aux *.blg *.bbl *.toc *.nav *.snm
LOG_FILES = *.log


FILES_TO_BUILD := $(patsubst %.tex,%.pdf,$(wildcard *.tex))

.PHONY: all release clean clean_after_build clean_diploma clean_presentation


%.pdf: %.tex
	$(LATEX_COMPILER) $(LATEX_COMPILER_FLAGS) $*
	@if (grep "citation{.*}" $*.aux > /dev/null); then \
		$(BIBLIO_COMPILER) $(BIBLIO_COMPILER_FLAGS) $*; \
		$(LATEX_COMPILER) $(LATEX_COMPILER_FLAGS) $*; \
	fi
	$(LATEX_COMPILER) $(LATEX_COMPILER_FLAGS) $*

clean:
	$(RM) $(FILES_TO_BUILD) $(LOG_FILES) $(TEMPORARY_FILES)

clean_after_build:
	$(RM) $(TEMPORARY_FILES)

clean_diploma clean_presentation:
	$(RM) $(TEMPORARY_FILES) $(subst clean_,,$@).pdf
