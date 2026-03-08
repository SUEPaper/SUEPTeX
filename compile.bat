@echo off
setlocal enabledelayedexpansion

:: SUEP LaTeX Template - Compilation Script (Windows)
echo ------------------------------------------------
echo Compiling all LaTeX files...
echo ------------------------------------------------

for %%f in (*.tex) do (
    echo Compiling %%f...
    xelatex -interaction=nonstopmode "%%f"
    :: Second pass for TOC and references
    xelatex -interaction=nonstopmode "%%f"
    echo ------------------------------------------------
)

echo All files compiled successfully.
pause
