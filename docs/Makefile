# use pandoc to create docx and pdf output

src = Synopsis.md

docx-args = --reference-doc=../pandoc-templates/custom-reference.docx

docs: docx pdf

docx: $(src)
	pandoc $(docx-args) -f markdown -t docx -o output/Synopsis.docx $(src)

pdf: $(src)
	pandoc -f markdown -t latex -o output/Synopsis.pdf $(src)
