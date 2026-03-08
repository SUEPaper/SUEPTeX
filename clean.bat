@echo off
:: SUEP LaTeX Template - Cleanup Script (Windows)

echo "Cleaning up auxiliary files..."
:: Delete all pdfs except auth.pdf using a loop or specific names
for %%i in (*.pdf) do if not "%%i"=="auth.pdf" del /q "%%i"
:: Recursively delete auxiliary files
del /s /q *.aux *.log *.toc *.out *.etoc *.synctex.gz *.bbl *.blg *.run.xml *.bcf

echo "Cleanup complete."
pause
