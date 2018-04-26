# used to generate slide and pdf products

all : docs slides

docs :
	(cd docs; $(MAKE) docs)

slides :
	(cd slides; $(MAKE) slides)
