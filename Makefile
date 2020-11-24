all: progetto.md 
	pandoc --pdf-engine=xelatex -H head.tex -f markdown+implicit_figures -V geometry:"top=3.7cm, bottom=3.7cm, left=4cm, right=4cm" progetto.md -o progetto.pdf -V toc

eis: progetto.md 
	pandoc --pdf-engine=xelatex -H head.tex -f markdown+implicit_figures -V geometry:"top=3.7cm, bottom=3.7cm, left=4cm, right=4cm" progetto.md -o progetto.pdf --template eisvogel --listings -V toc

docx: progetto.md 
	pandoc progetto.md -o progetto.docx -V toc

nomar: progetto.md 
	pandoc --pdf-engine=xelatex -H head.tex -f markdown+implicit_figures progetto.md -o progetto.pdf -V toc
