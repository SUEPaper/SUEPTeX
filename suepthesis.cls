\ProvidesExplClass{suepthesis}{2023/04/01}{SUEP Thesis Class}{Author Name}

% Load base article class
\LoadClass[11pt,a4paper,twoside]{article}

% Geometry & Page Layout
% margins: top 3.0cm, bottom 2.5cm, left/right 2.6cm
% header and footer separation: 2.0cm from the edges
% NOTE: geometry includes the header and footer in the body size by default unless specified. In Word, the margin is the distance to the text body, and header/footer are within.
\RequirePackage[a4paper,
  top=3.0cm, bottom=2.5cm,
  left=2.6cm, right=2.6cm,
  headheight=1.0cm,
  headsep=1.0cm, % Make sure text starts at ~3.0cm. 2.0cm padding + 1.0cm sep = 3.0cm
  footskip=0.5cm % 2.5cm padding - 2.0cm footer = 0.5cm
]{geometry}


\RequirePackage{expl3,l3keys2e}
\RequirePackage{xparse}
\RequirePackage{xeCJK}
\RequirePackage{fontspec}
\RequirePackage{float}
\RequirePackage{graphicx}
\RequirePackage[heading=true]{ctex}
\RequirePackage{fancyhdr}
\RequirePackage{titlesec}
\RequirePackage{titletoc}
\RequirePackage{setspace}

% -------------------------
% 1. Font Definitions
% -------------------------
% The ctex package under Windows automatically sets Times New Roman for English and SimSun/SimHei for Chinese.
% We just need to ensure \kaiti is mapped to the built-in \kaishu
\newcommand{\kaiti}{\kaishu}

% Predefined Chinese standard font sizes
\newcommand{\chuhao}{\fontsize{42pt}{42pt}\selectfont}     % 初号
\newcommand{\xiaochu}{\fontsize{36pt}{36pt}\selectfont}  % 小初号
\newcommand{\yihao}{\fontsize{26pt}{26pt}\selectfont}       % 一号
\newcommand{\xiaoyi}{\fontsize{24pt}{24pt}\selectfont}   % 小一号
\newcommand{\erhao}{\fontsize{22pt} {22pt}\selectfont}      % 二号
\newcommand{\xiaoer}{\fontsize{18pt}{18pt}\selectfont}   % 小二号
\newcommand{\sanhao}{\fontsize{16pt}{16pt}\selectfont}     % 三号
\newcommand{\xiaosan}{\fontsize{15pt}{15pt}\selectfont}  % 小三号
\newcommand{\sihao}{\fontsize{14pt}{14pt}\selectfont}       % 四号
\newcommand{\xiaosi}{\fontsize{12pt}{12pt}\selectfont}   % 小四号
\newcommand{\wuhao}{\fontsize{10.5pt}{10.5pt}\selectfont}% 五号
\newcommand{\xiaowu}{\fontsize{9pt}{9pt}\selectfont}   % 小五号

% Line Spacing (1.25 倍行距)
\setstretch{1.25}

% -------------------------
% 2. Headers and Footers
% -------------------------
\fancypagestyle{suep_header}{
  \fancyhf{}
  % Odd page header: Chapter title (needs setup via marks, here we use leftmark)
  \fancyhead[CO]{\wuhao\songti\leftmark}
  % Even page header:
  \fancyhead[CE]{\wuhao\songti 上海电力大学硕士/博士学位论文}
  
  % Footers - Page number in Center
  \fancyfoot[C]{\wuhao\selectfont\thepage}
  
  % The double line under header
  \renewcommand{\headrulewidth}{1pt}
  \renewcommand{\headrule}{%
    \hrule width\headwidth height\headrulewidth \vskip 1pt%
    \hrule width\headwidth height 0.5pt%
  }
  \renewcommand{\footrulewidth}{0pt}
}

% -------------------------
% 3. Chapters & Sections Format (ctexset)
% -------------------------
\ctexset{
  % Chapter (一级标题) 黑体, 三号, 居中. 段前空3行, 段后空2行.
  section={
    format=\centering\bfseries\sffamily\sanhao,
    name={第,章},
    number=\chinese{section},
    beforeskip=3\baselineskip,
    afterskip=2\baselineskip
  },
  % Section (二级标题) 宋体 加黑, 小三号. 段前空一行, 段后空0.5行.
  subsection={
    format=\bfseries\rmfamily\xiaosan,
    beforeskip=1\baselineskip,
    afterskip=0.5\baselineskip
  },
  % Subsection (三级标题) 宋体 加黑, 四号. 左起空两字符. 段前空0.5行, 段后空0行.
  subsubsection={
    format=\bfseries\rmfamily\sihao,
    indent=2\ccwd,
    beforeskip=0.5\baselineskip,
    afterskip=0pt
  }
}

% Paragraph settings: 宋体, 小四号, 首行缩进两字符
\setlength{\parindent}{2\ccwd}

% -------------------------
% 4. Cover & Title Page
% -------------------------
\newcommand\ful[2][4cm]{\underline{\makebox[#1][c]{#2}}}

\cs_new:Npn \__thesis_draw_image #1 {
    \begin{figure}[H]
        \centering
        \vspace{20mm}
        \includegraphics[height=36.84pt]{#1}
    \end{figure}
}

% Define variables to store meta info
\def\suep@c_title{}
\def\suep@e_title{}
\def\suep@author{}
\def\suep@supervisor{}
\def\suep@major{}
\def\suep@degree{}
\def\suep@school{}
\def\suep@type{}

\newcommand{\ctitle}[1]{\def\suep@c_title{#1}}
\newcommand{\etitle}[1]{\def\suep@e_title{#1}}
\newcommand{\cauthor}[1]{\def\suep@author{#1}}
\newcommand{\csupervisor}[1]{\def\suep@supervisor{#1}}
\newcommand{\cmajor}[1]{\def\suep@major{#1}}
\newcommand{\cdegree}[1]{\def\suep@degree{#1}}
\newcommand{\cschool}[1]{\def\suep@school{#1}}
\newcommand{\ctype}[1]{\def\suep@type{#1}} % 硕（博）士学位论文

\NewDocumentCommand \MakeTitle {} {
  \begin{titlepage}
    % Must be single-sided layout, no headers/footers
    \thispagestyle{empty}
    % Add padding at top
    \vspace*{10mm}
    
    % Classification and student ID rows
    \noindent
    \begin{minipage}{0.45\textwidth}
      \xiaosi 分\,类\,号 \ful[3.5cm]{} \\
      \xiaosi 单位代号 \ful[3.5cm]{10256}
    \end{minipage}
    \hfill
    \begin{minipage}{0.45\textwidth}
      \xiaosi 密级别 \ful[3.5cm]{} \\
      \xiaosi 学~~号 \ful[3.5cm]{}
    \end{minipage}

    \vspace{20mm}
    % Logo
    \begin{center}
      \includegraphics[height=1.5cm]{./images/logo.png}
    \end{center}
  
    \vspace{10mm} 
    % Thesis Type (硕（博）士学位论文)
    {\centering\sffamily\bfseries\yihao \suep@type\par}
    
    \vspace{5mm} 
    % English Title: Times New Roman, 二号 (22pt), 加黑, 居中 (From Shape Annotations)
    {\centering\bfseries\erhao \suep@e_title\par}

    \vspace{15mm} 
    % Chinese Title: 黑体, 二号, 居中
    {\centering\sffamily\bfseries\erhao \suep@c_title\par}
    
    \vspace{20mm} 
    % Personal info block.
    % 填写在下划线上的内容必须是 楷体 (Kaiti). 标签本身是 宋体, 三号 (16pt).
    \begin{center}
      \sanhao
      \def\arraystretch{1.5}
      \begin{tabular}{cl}
        \textbf{学 \enspace 位 \enspace 申 \enspace 请 \enspace 人 :~} & \ful[7cm]{\kaiti \suep@author} \\
        \textbf{指 \enspace 导 \enspace 教 \enspace 师 :~} & \ful[7cm]{\kaiti \suep@supervisor} \\
        \textbf{学 \enspace 科 \enspace 专 \enspace 业 :~} & \ful[7cm]{\kaiti \suep@major} \\
        \textbf{学 \enspace 位 \enspace 类 \enspace 别 :~} & \ful[7cm]{\kaiti \suep@degree} \\
        \textbf{所 \enspace 属 \enspace 院 \enspace 系 :~} & \ful[7cm]{\kaiti \suep@school}
      \end{tabular}
    \end{center}
  \end{titlepage}
}

% -------------------------
% 5. Abstract & TOC
% -------------------------
\newenvironment{cnabstract}{
  \clearpage
  \thispagestyle{empty} % Or roman numerals? For now using roman page numbers
  \begin{center}
    {\sffamily\bfseries\sanhao \suep@c_title \par} % Thesis title in center
    {\sffamily\bfseries\sanhao 摘 \quad 要 \par}      % "摘 要" below, with space in between
  \end{center}
  \par\vspace{1em}
  % Text configuration
  \sihao\songti % Size 4 Songti
}{\clearpage}

\newcommand{\cnkeywords}[1]{
  \par\vspace{\baselineskip}\noindent
  {\sffamily\bfseries\sihao 关键词 : } % Bold size 4 Heiti
  {\sihao\songti #1}
}

\newenvironment{enabstract}{
  \clearpage
  \begin{center}
    {\bfseries\erhao \suep@e_title \par}
    {\bfseries\sanhao ABSTRACT \par}
  \end{center}
  \par\vspace{1em}
  % Text configuration
  \sihao
}{\clearpage}

\newcommand{\enkeywords}[1]{
  \par\vspace{\baselineskip}\noindent
  {\bfseries\sihao KEY WORDS : }
  {\sihao \lowercase{#1}}
}

% End of suepthesis class
