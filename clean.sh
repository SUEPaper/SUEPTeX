#!/bin/bash
# SUEP LaTeX Template - Cleanup Script (Linux/macOS)

echo "Cleaning up auxiliary files..."
# Delete all pdfs except auth.pdf
find . -maxdepth 1 -name "*.pdf" ! -name "auth.pdf" -delete
rm -f *.aux *.log *.toc *.out *.etoc *.synctex.gz *.bbl *.blg *.run.xml *.bcf
echo "Cleanup complete."
