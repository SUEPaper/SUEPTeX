\ProvidesExplClass{suepthesis}{2023/04/01}{SUEP Thesis Class}{Author Name}
\documentclass[11pt,a4paper]{article}
\usepackage[a4paper, top=3.0cm, bottom=2.5cm, left=2.6cm, right=2.6cm]{geometry}
\RequirePackage{expl3,l3keys2e}
\Requirepackage{xparse}
\RequirePackage{fontspec}
\RequirePackage{xeCJK}
\RequirePackage{float}
\RequirePackage{ctexcap}
\RequirePackage{graphicx}
\RequirePackage{ctex}
\RequirePackage{fontspec}

\setCJKmainfont[BoldFont={SimHei}]{SimSun}
\setsansfont{Times New Roman}

\int_new:N \g__thesis_thesis_type_int
\int_set:Nn \g__thesis_thesis_type_int {1} % 初始化整数变量

\cs_new:Npn \__thesis_if_thesis_int_type:nTF #1#2#3
  {
    \int_compare:nNnTF \g__thesis_thesis_type_int = {#1} {#2} {#3}
  }
\cs_new:Npn \__thesis_if_thesis_int_type:nT #1#2
  {
    \__thesis_if_thesis_int_type:nTF {#1} {#2} {}
  }
\cs_new:Npn \__thesis_if_thesis_int_type:nF #1#2
  {
    \__thesis_if_thesis_int_type:nTF {#1} {} {#2}
  }

\cs_new:Npn \__thesis_fontsize:Nn #1#2 { \fontsize{#1}{#2}\selectfont } 

\newcommand\ful[2][4cm]{\underline{\makebox[#1][c]{#2}}}

\cs_new:Npn \__thesis_draw_image #1 {
    \begin{figure}
        \vspace{20mm}
        \includegraphics[width=154.8pt,height=36.84pt]{#1}
    \end{figure}
}

\cs_new:Npn \__thesis_draw_cover #1 {
  \begin{titlepage}
    \fontsize {12} {12} \selectfont
        分 \enspace 类 \enspace 号 \quad \ful[3cm]{填写中图分类号} \qquad \qquad
        &密 \enspace 级: \quad \ful[3cm]{}
    \par
        单位代号 \quad \ful[3cm]{10256} \qquad \qquad
        &学 \enspace 号 \quad \ful[3cm]{}
    \par
    \__thesis_draw_image {./images/logo.png}
    \par

    \vspace{10mm} 
     {\centering\fontsize{22pt}{26.4pt}\bfseries\CJKfamily{zhhei} 博士学位论文题目\par}
    \vspace{5mm} 
    {\centering\fontsize{22pt}{26.4pt}\bfseries Dissertation Title in English\par}
    \vspace{15mm} 
    {\centering\fontsize{22pt}{26.4pt}\bfseries\CJKfamily{zhhei} 中文题目\par}
    {\centering\fontsize{22pt}{26.4pt}\bfseries\CJKfamily{zhhei} 英语题目\par}
    \vspace{20mm} 

    {\qquad\zihao{3}\textbf{学 \enspace 位 \enspace 申 \enspace 请 \enspace 人}} &:& \ful[7cm]{} \par
    {\qquad\zihao{3}\textbf{指 \enspace 导 \enspace 老 \enspace 师 \enspace }} &:& \ful[7cm]{}\par
    {\qquad\zihao{3}\textbf{学 \enspace 科 \enspace 专 \enspace 业 \enspace }} &:& \ful[7cm]{} \par
    {\qquad\zihao{3}\textbf{ \qquad } } && \ful[7cm]{} \par
    {\qquad\zihao{3}\textbf{学 \enspace 位 \enspace 类 \enspace 别 \enspace }} &:& \ful[7cm]{} \par
    {\qquad\zihao{3}\textbf{所 \enspace 属 \enspace 院 \enspace 系 \enspace }} &:& \ful[7cm]{} \par

    \end{titlepage}
}


\NewDocumentCommand \MakeTitle {}
  {
    \__thesis_if_thesis_int_type:nT {1} {\__thesis_draw_cover {zhang}}
  }

