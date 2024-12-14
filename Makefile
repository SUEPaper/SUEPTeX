# 以下命令仅保证能在 Linux 或 macOS 环境下执行。
# 如果你是 Windows 用户，可以使用 Git Bash 或者 Cygwin 来执行；
# 或者可以考虑将此脚本移植为 PowerShell。

# Required for brace expansion
SHELL = /bin/bash

PACKAGE = suepthesis

SOURCES = $(PACKAGE).ins $(PACKAGE).dtx
CLSFILE = dtx-style.sty suepthesis.cls

LATEXMK = latexmk

SCAFFOLDDIR = ./templates
TESTDIR = ./tests
EXAMPLEDIR = ./examples

ifeq ($(OS), Windows_NT)
	REGRESSION_TEST_COMMAND=pwsh ./scripts/regression-testing.ps1
else
	REGRESSION_TEST_COMMAND=zsh ./scripts/regression-testing.zsh
endif


.PHONY: all FORCE_MAKE

$(PACKAGE).pdf: cls FORCE_MAKE
	@$(LATEXMK) -xelatex $(PACKAGE).dtx

$(CLSFILE): $(SOURCES)
	yes y | xetex $(PACKAGE).ins

.PHONY: cls
cls: $(CLSFILE)

.PHONY: doc
doc: $(PACKAGE).pdf


.PHONY: graduate
graduate: $(CLSFILE)
	cp suepthesis.cls $(SCAFFOLDDIR)/graduate-thesis
	cd $(SCAFFOLDDIR)/graduate-thesis && latexmk && cd ...
	
.PHONY: viewdoc
viewdoc: doc
	$(LATEXMK) -pv $(PACKAGE).dtx

.PHONY: clean
clean:
	$(LATEXMK) -c $(PACKAGE).dtx
	-rm -rf *.glo $(CLSFILE)

.PHONY: clean-dist
clean-dist:
	-rm -rf $(PACKAGE).pdf

.PHONY: clean-all
clean-all: clean clean-dist FORCE_MAKE

.PHONY: test
test: doc copy FORCE_MAKE
	cd $(SCAFFOLDDIR)/undergraduate-thesis && latexmk && cd ..
	cd $(SCAFFOLDDIR)/paper-translation && latexmk && cd ..
	cd $(SCAFFOLDDIR)/undergraduate-thesis-en && latexmk && cd ..
	cd $(SCAFFOLDDIR)/graduate-thesis && latexmk && cd ..
	cd $(SCAFFOLDDIR)/reading-report && latexmk && cd ..
	cd $(SCAFFOLDDIR)/lab-report && latexmk && cd ..
	cd $(SCAFFOLDDIR)/presentation-slide && latexmk && cd ..
	cd $(TESTDIR)/doctor-thesis && latexmk && cd ..
	cd $(TESTDIR)/autorefs && latexmk && cd ..
	cd ./handbook && latexmk \
		&& GRADUATE=true latexmk -gg && cd ..

.PHONY: regression-test
regression-test: cls
	$(REGRESSION_TEST_COMMAND)

.PHONY: copy-only
copy-only:
	cp {suepthesis.cls,assets/latexmkrc} $(SCAFFOLDDIR)/undergraduate-thesis
	cp {suepthesis.cls,assets/latexmkrc} $(SCAFFOLDDIR)/undergraduate-thesis-en
	cp {suepthesis.cls,assets/latexmkrc} $(SCAFFOLDDIR)/paper-translation
	cp {suepthesis.cls,assets/latexmkrc} $(SCAFFOLDDIR)/graduate-thesis
	cp {suepthesis.cls,assets/latexmkrc} $(SCAFFOLDDIR)/reading-report
	cp {suepthesis.cls,assets/latexmkrc} $(TESTDIR)/doctor-thesis
	cp {suepthesis.cls,assets/latexmkrc} $(TESTDIR)/autorefs
	cp {suepthesis.cls,assets/latexmkrc} ./handbook
	cp {bitreport.cls,assets/latexmkrc} $(SCAFFOLDDIR)/lab-report
	cp {bitbeamer.cls,assets/latexmkrc} $(SCAFFOLDDIR)/presentation-slide

.PHONY: copy
copy: cls copy-only

# Generate scaffolds for overleaf
.PHONY: overleaf
overleaf: doc FORCE_MAKE
	# if $version is not specified, alert the user.
	@if [ -z "$$version" ]; then \
		echo -e "\e[32mPlease specify the version of the template you want to generate.\e[0m"; \
		echo -e "\e[32mFor example: make overleaf version=1.0.0\e[0m"; \
		exit 1; \
	fi
	git clean -fdx ./templates/
	rm -rf overleaf
	make copy
	mkdir overleaf
	ls templates | \
		xargs -I {} sh -c \
		"cp -r ./templates/{} overleaf && cp $(PACKAGE).pdf ./overleaf/{} && (cd overleaf/{}/ && zip -r ../suepthesis-{}-v$(version).zip .)"

.PHONY: dev
dev:
	ls suepthesis.dtx | entr -s 'yes y | make doc && make copy'

.PHONY: dev-doc
dev-doc:
	ls suepthesis.dtx | entr -s 'make clean-all && yes y | make doc && open suepthesis.pdf'

.PHONY: pkg-only
pkg-only:
	rm -rf ./suepthesis ./suepthesis.zip
	mkdir suepthesis
	cp suepthesis.ins suepthesis.dtx suepthesis.pdf ./README*.md ./contributing*.md ./suepthesis
	mv ./suepthesis/README-suepthesis.md ./suepthesis/README.md
	zip -r suepthesis.zip suepthesis

.PHONY: pkg
pkg: doc pkg-only

GRAD_DEST_DIR = ./suepthesis-graduate-thesis-template

.PHONY: handbooks
handbooks: copy FORCE_MAKE
	cd handbook \
		&& GRADUATE=true latexmk -gg && mv main.pdf graduate-handbook.pdf \
		&& latexmk -gg && mv main.pdf undergraduate-handbook.pdf && cd -

# 用于提供给研究生院
.PHONY: grad
grad: doc copy handbooks FORCE_MAKE
	# if $version is not specified, alert the user.
	@if [ -z "$$version" ]; then \
		echo -e "\e[32mPlease specify the version of the template you want to generate.\e[0m"; \
		echo -e "\e[32mFor example: make grad version=1.0.0\e[0m"; \
		exit 1; \
	fi
	rm -rf ${GRAD_DEST_DIR}-${version} ${GRAD_DEST_DIR}-${version}.zip
	cd $(SCAFFOLDDIR)/graduate-thesis && latexmk && latexmk -c && cd -
	mkdir ${GRAD_DEST_DIR}-${version}
	cp -r $(SCAFFOLDDIR)/graduate-thesis/ ${GRAD_DEST_DIR}-${version}/graduate-thesis/
	cp ./suepthesis.pdf ${GRAD_DEST_DIR}-${version}/'3-详细配置手册'.pdf
	cp ./handbook/graduate-handbook.pdf ${GRAD_DEST_DIR}-${version}/'2-快速使用手册'.pdf
	(cd ${GRAD_DEST_DIR}-${version}/graduate-thesis/ && zip -rm ../"1-suepthesis-论文模板-${version}".zip . )
	rmdir ${GRAD_DEST_DIR}-${version}/graduate-thesis
	zip -r ${GRAD_DEST_DIR}-${version}.zip ${GRAD_DEST_DIR}-${version}

UNDERGRAD_DEST_DIR = ./suepthesis-undergraduate-thesis-templates

# 用于提供给教务部
.PHONY: undergrad
undergrad: doc copy handbooks FORCE_MAKE
	@if [ -z "$$version" ]; then \
		echo -e "\e[32mPlease specify the version of the template you want to generate.\e[0m"; \
		echo -e "\e[32mFor example: make grad version=1.0.0\e[0m"; \
		exit 1; \
	fi
	rm -rf ${UNDERGRAD_DEST_DIR}-${version} ${UNDERGRAD_DEST_DIR}-${version}.zip
	cd $(SCAFFOLDDIR)/undergraduate-thesis && latexmk && latexmk -c && cd -
	cd $(SCAFFOLDDIR)/undergraduate-thesis-en && latexmk && latexmk -c && cd -
	cd $(SCAFFOLDDIR)/paper-translation && latexmk && latexmk -c && cd -
	mkdir ${UNDERGRAD_DEST_DIR}-${version}
	cp -r $(SCAFFOLDDIR)/undergraduate-thesis/ ${UNDERGRAD_DEST_DIR}-${version}/undergraduate-thesis/
	cp -r $(SCAFFOLDDIR)/undergraduate-thesis-en/ ${UNDERGRAD_DEST_DIR}-${version}/undergraduate-thesis-en/
	cp -r $(SCAFFOLDDIR)/paper-translation/ ${UNDERGRAD_DEST_DIR}-${version}/paper-translation/
	cp ./suepthesis.pdf ${UNDERGRAD_DEST_DIR}-${version}/'4-详细配置手册'.pdf
	cp ./handbook/undergraduate-handbook.pdf ${UNDERGRAD_DEST_DIR}-${version}/'5-快速使用手册'.pdf
	(cd ${UNDERGRAD_DEST_DIR}-${version}/undergraduate-thesis/ && zip -rm ../"1-suepthesis-本科毕设论文模板-${version}".zip . )
	(cd ${UNDERGRAD_DEST_DIR}-${version}/undergraduate-thesis-en/ && zip -rm ../"2-suepthesis-本科毕设论文模板（全英文）-${version}".zip . )
	(cd ${UNDERGRAD_DEST_DIR}-${version}/paper-translation/ && zip -rm ../"3-suepthesis-本科毕设外文翻译-${version}".zip . )
	rmdir ${UNDERGRAD_DEST_DIR}-${version}/undergraduate-thesis
	rmdir ${UNDERGRAD_DEST_DIR}-${version}/undergraduate-thesis-en
	rmdir ${UNDERGRAD_DEST_DIR}-${version}/paper-translation
	zip -r ${UNDERGRAD_DEST_DIR}-${version}.zip ${UNDERGRAD_DEST_DIR}-${version}

.PHONY: examples
examples: cls
	cp suepthesis.cls $(EXAMPLEDIR)/cover/
	cp suepthesis.cls $(EXAMPLEDIR)/publications/
	cd $(EXAMPLEDIR)/cover && latexmk && cd -
	cd $(EXAMPLEDIR)/publications && latexmk && cd -
