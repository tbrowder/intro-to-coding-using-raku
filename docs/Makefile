# use pandoc to create docx and pdf output

src = Synopsis.md

docs: docx pdf

docx: $(src)
	pandoc -f markdown -t docx -o output/Synopsis.docx $(src)

pdf: $(src)
	pandoc -f markdown -t latex -o output/Synopsis.pdf $(src)
