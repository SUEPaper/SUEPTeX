import os
import subprocess
import shutil

# Read the base template from test_format.tex
with open('test_format.tex', 'r', encoding='utf-8') as f:
    lines = f.readlines()

combinations = [
    ('master', 'academic'),
    ('master', 'professional'),
    ('doctor', 'academic'),
    ('doctor', 'professional')
]

for degree, degreetype in combinations:
    new_lines = []
    
    for line in lines:
        if line.strip().startswith('\\documentclass'):
            new_lines.append(f'\\documentclass[degree={degree},degreetype={degreetype}]{{suepthesis}}\n')
        elif line.strip().startswith('\\cdegree{'):
            dt = "学术" if degreetype == 'academic' else "专业"
            dg = "硕士" if degree == 'master' else "博士"
            new_lines.append(f'\\cdegree{{{dt}{dg}}}\n')
        else:
            new_lines.append(line)
            
    filename = f'test_{degree}_{degreetype}.tex'
    with open(filename, 'w', encoding='utf-8') as f:
        f.writelines(new_lines)
    
    print(f'Starting compilation for {filename}...')
    try:
        # Run xelatex twice to ensure TOC and references are updated
        subprocess.run(['xelatex', '-interaction=nonstopmode', filename], check=True)
        subprocess.run(['xelatex', '-interaction=nonstopmode', filename], check=True)
        print(f'Successfully compiled {filename}\n')
    except subprocess.CalledProcessError as e:
        print(f'Error compiling {filename}: {e}\n')

print("All tests generated and compiled.")
