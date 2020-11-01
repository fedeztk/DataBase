all: progetto.md 
	pandoc --pdf-engine=xelatex -H head.tex -f markdown+implicit_figures -V geometry:"top=3.7cm, bottom=3.7cm, left=4cm, right=4cm" progetto.md -o progetto.pdf -V toc

eis: progetto.md 
	pandoc progetto.md -o progetto.pdf --from markdown --template eisvogel --listings -V toc

docx: progetto.md 
	pandoc progetto.md -o progetto.docx -V toc

mar: progetto.md 
	pandoc -f markdown --pdf-engine=xelatex -V geometry:"top=3.7cm, bottom=3.7cm, left=2cm, right=2cm" progetto.md -o progetto.pdf -V toc
