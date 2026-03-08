#!/bin/bash
# SUEP LaTeX Template - Cleanup Script (Linux/macOS)

echo "Cleaning up auxiliary files..."
# Delete all pdfs except auth.pdf
find . -maxdepth 1 -name "*.pdf" ! -name "auth.pdf" -delete
# Recursively delete auxiliary files
find . -name "*.aux" -o -name "*.log" -o -name "*.toc" -o -name "*.out" -o -name "*.etoc" -o -name "*.synctex.gz" -o -name "*.bbl" -o -name "*.blg" -o -name "*.run.xml" -o -name "*.bcf" -delete
echo "Cleanup complete."
