@echo off
:: SUEP LaTeX Template - Cleanup Script (Windows)

echo Cleaning up auxiliary files...
del /q *.aux *.log *.toc *.pdf *.out *.etoc *.synctex.gz *.bbl *.blg *.run.xml *.bcf

echo Cleanup complete.
pause
