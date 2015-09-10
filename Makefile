NAME=tutoriel_rpi_qemu

JDHP_PDF_DIR=~/git/pub/projects/jdhp/files/pdf
#JDHP_HEVEA_DIR=~/git/pub/projects/jdhp/files/hevea
# HEVEA doit être mis dans www plutot que dans download pour les stats et le référencement...
JDHP_HEVEA_DIR=~/git/pub/projects/jdhp/jdhp/hevea
JDHP_UPLOAD_PDF_SCRIPT=~/git/pub/projects/jdhp/files_upload.sh
JDHP_UPLOAD_HEVEA_SCRIPT=~/git/pub/projects/jdhp/jdhp/sync_hevea.sh

#############

all: $(NAME).pdf

.PHONY : all clean init jdhp html

## ARTICLE ##

SRCARTICLE=$(NAME).tex\
		   article_packages.tex\
		   commands.tex\
		   bibliography.bib

pdf: $(NAME).pdf

$(NAME).pdf: $(SRCARTICLE)
	pdflatex $(NAME).tex
	bibtex $(NAME)     # this is the name of the .aux file, not the .bib file !
	pdflatex $(NAME).tex
	pdflatex $(NAME).tex

ps: $(NAME).ps

$(NAME).ps: $(SRCARTICLE)
	latex $(NAME).tex
	bibtex $(NAME)     # this is the name of the .aux file, not the .bib file !
	latex $(NAME).tex
	latex $(NAME).tex
	dvips $(NAME).dvi

html: $(NAME).html

$(NAME).html: $(SRCARTICLE)
	hevea -fix $(NAME).tex
	bibhva $(NAME)     # this is the name of the .aux file, not the .bib file !
	hevea -fix $(NAME).tex

jdhp:$(NAME).pdf $(NAME).html
	# Copy PDF
	cp -v $(NAME).pdf  $(JDHP_PDF_DIR)/
	# Copy HTML
	@rm -rf $(JDHP_HEVEA_DIR)/$(NAME)
	@mkdir $(JDHP_HEVEA_DIR)/$(NAME)
	cp -v $(NAME).html $(JDHP_HEVEA_DIR)/$(NAME)
	cp -vr fig $(JDHP_HEVEA_DIR)/$(NAME)
	# Sync
	$(JDHP_UPLOAD_PDF_SCRIPT)
	$(JDHP_UPLOAD_HEVEA_SCRIPT)

## CLEAN ##

clean:
	@echo "suppression des fichiers de compilation"
	@rm -f *.log *.aux *.dvi *.toc *.lot *.lof *.out *.nav *.snm *.bbl *.blg *.vrb
	@rm -f *.haux *.htoc *.hbbl $(NAME).image.tex

init: clean
	@echo "suppression des fichiers cibles"
	@rm -f $(NAME).pdf
	@rm -f $(NAME).ps
	@rm -f $(NAME).html
