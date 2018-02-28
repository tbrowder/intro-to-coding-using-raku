# used to generate slide and pdf products

all : docs slides

docs :
    <tab>(cd docs; $(MAKE) docs)
    
slides :
    <tab>(cd slides; $(MAKE) slides)
