# based on code at:
#   https://github.com/edumentab/rakudo-and-nqp-internals-course

LATEX    = latex
DVIPS    = dvips
PS2PDF   = ps2pdf
MD2TEX   = tools/md2tex
BREAK    = tools/break-after-colon-in-title-slides
INSERT   = tools/insert-into-template
PERL     = perl
PANDOC   = pandoc
PDFLATEX = pdflatex

LESSONS =
LESSONS += lesson-1.md
#LESSONS += lesson-2.md
#LESSONS += lesson-3.md
#LESSONS += lesson-4.md
#LESSONS += lesson-5.md
#LESSONS += lesson-6.md

PROBS   =
#PROBS  += lesson-1-probs.md
#PROBS  += lesson-2-probs.md
#PROBS  += lesson-3-probs.md
#PROBS  += lesson-4-probs.md
#PROBS  += lesson-5-probs.md
#PROBS  += lesson-6-probs.md

ANSWERS =
#ANSWERS += lesson-1-answers.md
#ANSWERS += lesson-2-answers.md
#ANSWERS += lesson-3-answers.md
#ANSWERS += lesson-4-answers.md
#ANSWERS += lesson-5-answers.md
#ANSWERS += lesson-6-answers.md

PRODS = $(LESSONS) $(PROBS) $(ANSWERS)

COMMON +=
COMMON += src/inc/common*md
COMMON += src/inc/headers.md
COMMON += src/inc/background.md

PDFS  = $(patsubst %.md, otp/%.pdf, $(PRODS))
pdocs = $(patsubst %.md, src/%.pdoc, $(PRODS))

.PHONY : all
all: $(PDFS) list-prods

.PHONY : pdoc
pdoc: $(pdocs)

.PHONY : list-prods
list-prods:
	@echo PDF Products:
	@echo ------------
	@-ls -1 otp/*.pdf

src/%.pdoc : src/%.md $(COMMON) src/make-pdoc-from-md.p6
	@echo PDF Source:
	@echo ----------
	@-ls -1 src/*.md
	( cd src ; ./make-pdoc-from-md.p6 -i=$(<) --debug )

fake-src/%.pdoc : src/%.pdoc
	@-cp $< $@

fake-src/%.tex : fake-src/%.pdoc $(MD2TEX)
	$(PERL) $(MD2TEX) $< $@
	$(PERL) -pi.bak -e "s/\(FIXUP\)//g"   $@
	$(PERL) -i.bak $(BREAK)               $@
	@-rm $(trash)

otp/%.pdf : fake-src/%.tex
	$(PDFLATEX) -output-directory=otp $<
	@-rm $(trash)

#.PHONY: deliver
#deliver:
#	cp $(TFREPRODS) $(TFREDIR)
#	cp $(TLINPRODS) $(TLINDIR)
#	cp $(TPERPRODS) $(TPERDIR)
#	cp $(SITEPRODS) $(SITEDIR)
#	@echo "Website updated\n"

.PHONY: clean
clean:
	( cd otp; rm -f *.dvi ; rm -f *.aux ; rm -f *.out ; \
	            rm -f *.nav ; rm -f *.snm ; rm -f *.ps ;  \
	            rm -f *.bak ; rm -f *.vrb ; rm -f *.tex ; \
	            rm -f *.toc ; rm -f *.html ; rm -f *.log )
	( cd src; rm -f *.dvi ; rm -f *.aux ; rm -f *.out ; \
	            rm -f *.nav ; rm -f *.snm ; rm -f *.ps ;  \
	            rm -f *.bak ; rm -f *.vrb ; rm -f *.tex ; \
	            rm -f *.toc ; rm -f *.html ; rm -f *.log )

realclean: clean
	( cd otp; rm -f *.log ; rm -f *.pdf )
	( cd src; rm -f *.pdoc )

distclean: realclean

trash  = $(patsubst %.md, otp/%.log, $(PRODS))
trash += $(patsubst %.md, otp/%.aux, $(PRODS))
trash += $(patsubst %.md, otp/%.dvi, $(PRODS))
trash += $(patsubst %.md, otp/%.snm, $(PRODS))
trash += $(patsubst %.md, otp/%.out, $(PRODS))
trash += $(patsubst %.md, otp/%.nav, $(PRODS))
trash += $(patsubst %.md, otp/%.vrb, $(PRODS))
trash += $(patsubst %.md, otp/%.toc, $(PRODS))
trash += src/*.bak src/*~
trash += fake-src/*.bak
