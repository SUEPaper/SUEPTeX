#!/bin/bash
# SUEP LaTeX Template - Compilation Script (Linux/macOS)

# Compile all .tex files in the current directory
for file in *.tex; do
    if [ -f "$file" ]; then
        echo "------------------------------------------------"
        echo "Compiling $file..."
        echo "------------------------------------------------"
        xelatex -interaction=nonstopmode "$file"
        # Second pass for Table of Contents and references
        xelatex -interaction=nonstopmode "$file"
    fi
done

echo "------------------------------------------------"
echo "All files compiled successfully."
echo "------------------------------------------------"
