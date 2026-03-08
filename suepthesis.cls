\ProvidesExplClass{suepthesis}{2023/04/01}{SUEP Thesis Class}{Author Name}

\RequirePackage{l3keys2e}

% Define class options
\keys_define:nn { suep }
  {
    degree .choice:,
    degree / master .code:n = { \tl_gset:Nn \g__suep_degree_tl { master } },
    degree / doctor .code:n = { \tl_gset:Nn \g__suep_degree_tl { doctor } },
    degree .initial:n = master,

    degreetype .choice:,
    degreetype / academic .code:n = { \tl_gset:Nn \g__suep_degreetype_tl { academic } },
    degreetype / professional .code:n = { \tl_gset:Nn \g__suep_degreetype_tl { professional } },
    degreetype .initial:n = academic,
  }
\ProcessKeysOptions { suep }

\tl_new:N \l__suep_thesis_type_cn_tl
\tl_new:N \l__suep_thesis_type_en_tl
\tl_new:N \l__suep_header_even_tl
\tl_new:N \l__suep_major_label_tl

\str_case:Vn \g__suep_degree_tl
  {
    { master }
    {
      \str_case:Vn \g__suep_degreetype_tl
        {
          { academic }
          {
            \tl_set:Nn \l__suep_thesis_type_cn_tl { 硕士学位论文 }
            \tl_set:Nn \l__suep_thesis_type_en_tl { Dissertation~for~Master's~Degree }
            \tl_set:Nn \l__suep_header_even_tl { 上海电力大学硕士学位论文 }
            \tl_set:Nn \l__suep_major_label_tl { 学 \enspace 科 \enspace 专 \enspace 业 :~ }
          }
          { professional }
          {
            \tl_set:Nn \l__suep_thesis_type_cn_tl { 专业学位硕士学位论文 }
            \tl_set:Nn \l__suep_thesis_type_en_tl { MASTER~THESIS~FOR~PROFESSIONAL~DEGREE }
            \tl_set:Nn \l__suep_header_even_tl { 上海电力大学专业学位硕士学位论文 }
            \tl_set:Nn \l__suep_major_label_tl { 专 \enspace 业 \enspace 名 \enspace 称 :~ }
          }
        }
    }
    { doctor }
    {
      \str_case:Vn \g__suep_degreetype_tl
        {
          { academic }
          {
            \tl_set:Nn \l__suep_thesis_type_cn_tl { 博士学位论文 }
            \tl_set:Nn \l__suep_thesis_type_en_tl { Dissertation~for~Doctor's~Degree }
            \tl_set:Nn \l__suep_header_even_tl { 上海电力大学博士学位论文 }
            \tl_set:Nn \l__suep_major_label_tl { 学 \enspace 科 \enspace 专 \enspace 业 :~ }
          }
          { professional }
          {
            \tl_set:Nn \l__suep_thesis_type_cn_tl { 专业学位博士学位论文 }
            \tl_set:Nn \l__suep_thesis_type_en_tl { DOCTOR~THESIS~FOR~PROFESSIONAL~DEGREE }
            \tl_set:Nn \l__suep_header_even_tl { 上海电力大学专业学位博士学位论文 }
            \tl_set:Nn \l__suep_major_label_tl { 专 \enspace 业 \enspace 名 \enspace 称 :~ }
          }
        }
    }
  }

\def\suep@type{\l__suep_thesis_type_cn_tl}
\def\suep@type@en{\l__suep_thesis_type_en_tl}
\def\suep@header@even{\l__suep_header_even_tl}
\def\suep@major@label{\l__suep_major_label_tl}

% Load base article class
\LoadClass[11pt,a4paper,twoside]{article}

% Geometry & Page Layout
% margins: top 3.0cm, bottom 2.5cm, left/right 2.6cm
% header and footer separation: 2.0cm from the edges
% NOTE: geometry includes the header and footer in the body size by default unless specified. In Word, the margin is the distance to the text body, and header/footer are within.
\RequirePackage[a4paper,
  top=3.5cm, bottom=2.5cm,
  left=2.5cm, right=2.5cm,
  headheight=1.0cm,
  headsep=0cm, % Make sure text starts at ~3.5cm. headheight at 1.0cm means header starts at 2.5cm
  footskip=0.5cm % 2.5cm margin - 2.0cm footer = 0.5cm
]{geometry}


\RequirePackage{expl3}
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
\RequirePackage{amssymb}
\RequirePackage{booktabs}
\RequirePackage[font=small, labelsep=quad]{caption}
\RequirePackage{bicaption}
\RequirePackage{pdfpages}

% -------------------------
% 1. Font Definitions
% -------------------------
% The ctex package under Windows automatically sets Times New Roman for English and SimSun/SimHei for Chinese.
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

% Setup captions for bilingual if doctor
\DeclareCaptionFont{wuhaosong}{\wuhao\songti}
\captionsetup[figure]{font=wuhaosong, labelsep=quad}
\captionsetup[table]{font=wuhaosong, labelsep=quad}
\captionsetup[equation]{font=wuhaosong, labelsep=quad}

% If doctor degree, setup bicaption
\str_case:Vn \g__suep_degree_tl
{
  { doctor }
  {
    \captionsetup[bi-first]{name=图, font=wuhaosong, labelsep=quad}
    \captionsetup[bi-second]{name=Fig., font=wuhaosong, labelsep=quad} % Actually should be Times New Roman size 5. The base font for English is already set to Times New Roman in xeCJK/ctex
  }
}

% -------------------------
% 2. Headers and Footers
% -------------------------
\fancypagestyle{suep_header}{
  \fancyhf{}
  % Odd page header: Thesis Title (for front matter) or Chapter title (for main matter)
  % We use \thesectionmark or similar if not in chapter, but here usually \leftmark or \rightmark
  \fancyhead[CO]{\wuhao\songti\leftmark}
  % Even page header: University + Thesis Type
  \fancyhead[CE]{\wuhao\songti \tl_use:N \l__suep_header_even_tl}
  
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
\tl_new:N \g__suep_c_title_tl
\tl_new:N \g__suep_e_title_tl
\tl_new:N \g__suep_author_tl
\tl_new:N \g__suep_supervisor_tl
\tl_new:N \g__suep_major_tl
\tl_new:N \g__suep_degree_type_tl
\tl_new:N \g__suep_school_tl

\newcommand{\ctitle}[1]{\tl_gset:Nn \g__suep_c_title_tl {#1}}
\newcommand{\etitle}[1]{\tl_gset:Nn \g__suep_e_title_tl {#1}}
\newcommand{\cauthor}[1]{\tl_gset:Nn \g__suep_author_tl {#1}}
\newcommand{\csupervisor}[1]{\tl_gset:Nn \g__suep_supervisor_tl {#1}}
\newcommand{\cmajor}[1]{\tl_gset:Nn \g__suep_major_tl {#1}}
\newcommand{\cdegree}[1]{\tl_gset:Nn \g__suep_degree_type_tl {#1}}
\newcommand{\cschool}[1]{\tl_gset:Nn \g__suep_school_tl {#1}}
\newcommand{\ctype}[1]{\tl_set:Nn \l__suep_thesis_type_cn_tl {#1}}
\newcommand{\etype}[1]{\tl_set:Nn \l__suep_thesis_type_en_tl {#1}}

\NewDocumentCommand \MakeTitle {} {
  \begin{titlepage}
    \thispagestyle{empty}
    \vspace*{10mm}
    
    % 1. Header (Classification / Student ID)
    \noindent
    \begin{minipage}[t]{0.45\textwidth}
      \xiaosi 分\,类\,号 \ful[3.5cm]{} \\
      \xiaosi 单位代号 \ful[3.5cm]{10256}
    \end{minipage}
    \hfill
    \begin{minipage}[t]{0.45\textwidth}
      \xiaosi 密\quad 级 \ful[3.5cm]{} \\
      \xiaosi 学\quad 号 \ful[3.5cm]{}
    \end{minipage}\par

    \vspace{10mm}

    % 2. Logo (Left Aligned as per Word screenshot)
    \noindent\includegraphics[height=48.25pt]{./images/logo.png}\par

    \vspace{10mm}
    % 3. Thesis Type (Chinese)
    {\centering\sffamily\bfseries\xiaochu \tl_use:N \l__suep_thesis_type_cn_tl \par}
    
    \vspace{5mm}
    % 5. Thesis Type (English) - For Doctor or Professional Master
    \str_case:Vn \g__suep_degree_tl
    {
      { doctor }
      { {\centering\bfseries\xiaosan \tl_use:N \l__suep_thesis_type_en_tl \par} }
      { master }
      {
        \str_case:Vn \g__suep_degreetype_tl
        {
          { professional }
          {
            {\centering\bfseries\xiaosan \tl_use:N \l__suep_thesis_type_en_tl \par}
          }
        }
      }
    }

    \vspace{15mm}
    % 6. Chinese Title
    {\centering\sffamily\bfseries\erhao \tl_use:N \g__suep_c_title_tl \par}
    
    \str_case:Vn \g__suep_degree_tl
      {
        { doctor }
        {
          \vspace{5mm} 
          % 7. English Title (Doctor only)
          {\centering\bfseries\erhao \tl_use:N \g__suep_e_title_tl \par}
        }
      }
    
    \vspace{15mm} 
    % 8. Personal info block.
    \begin{center}
      \sihao\sffamily\bfseries
      \def\arraystretch{1.8}
      \begin{tabular}{cl}
        学 \enspace 位 \enspace 申 \enspace 请 \enspace 人 :~ & \ful[7cm]{\kaiti \tl_use:N \g__suep_author_tl} \\
        指 \enspace 导 \enspace 教 \enspace 师 :~ & \ful[7cm]{\kaiti \tl_use:N \g__suep_supervisor_tl} \\
        \tl_use:N \l__suep_major_label_tl & \ful[7cm]{\kaiti \tl_use:N \g__suep_major_tl} \\
        学 \enspace 位 \enspace 类 \enspace 别 :~ & \ful[7cm]{\kaiti \tl_use:N \g__suep_degree_type_tl} \\
        所 \enspace 属 \enspace 院 \enspace 系 :~ & \ful[7cm]{\kaiti \tl_use:N \g__suep_school_tl}
      \end{tabular}
    \end{center}

    \vfill
    % 9. Date block
    \begin{center}
      \sihao\sffamily\bfseries
      年 \hspace{2cm} 月
    \end{center}
  \end{titlepage}

  % ==============================
  % INNER TITLE PAGE (扉页)
  % ==============================
  \begin{titlepage}
    \thispagestyle{empty}
    \vspace*{10mm}
    
    % Classification and student ID rows
    \noindent
    \begin{minipage}[t]{0.45\textwidth}
      \xiaosi 分\,类\,号 \ful[3.5cm]{} \\
      \xiaosi 单位代号 \ful[3.5cm]{10256}
    \end{minipage}
    \hfill
    \begin{minipage}[t]{0.45\textwidth}
      \xiaosi 密\quad 级 \ful[3.5cm]{} \\
      \xiaosi 学\quad 号 \ful[3.5cm]{}
    \end{minipage}\par

    \vspace{30mm}
    % Title (上海电力大学 硕士学位论文)
    {\centering\bfseries\erhao 上海电力大学 \tl_use:N \l__suep_thesis_type_cn_tl \par}

    \vspace{15mm} 
    % Chinese Title
    {\centering\sffamily\bfseries\erhao \tl_use:N \g__suep_c_title_tl \par}
    
    \str_case:Vn \g__suep_degree_tl
      {
        { doctor }
        {
          \vspace{5mm} 
          % English Title
          {\centering\bfseries\erhao \tl_use:N \g__suep_e_title_tl \par}
        }
      }
    
    \vspace{25mm} 
    % Personal info block for inner page.
    \begin{center}
      \sihao\sffamily\bfseries
      \def\arraystretch{1.8}
      \begin{tabular}{cl}
        学 \enspace 位 \enspace 申 \enspace 请 \enspace 人 :~ & \ful[7cm]{\kaiti \tl_use:N \g__suep_author_tl} \\
        指 \enspace 导 \enspace 教 \enspace 师 :~ & \ful[7cm]{\kaiti \tl_use:N \g__suep_supervisor_tl} \\
        \tl_use:N \l__suep_major_label_tl & \ful[7cm]{\kaiti \tl_use:N \g__suep_major_tl} \\
        学 \enspace 位 \enspace 类 \enspace 别 :~ & \ful[7cm]{\kaiti \tl_use:N \g__suep_degree_type_tl} \\
        论 \enspace 文 \enspace 定 \enspace 稿 \enspace 日 \enspace 期:~ & \ful[7cm]{}
      \end{tabular}
    \end{center}
    
    \vfill
    % Date block
    \begin{center}
      \sihao\sffamily\bfseries
      年 \hspace{2cm} 月
    \end{center}
  \end{titlepage}
}

% ==============================
% 授权书 PAGE (Copyright Authorization)
% ==============================
\newcommand{\makeauthpage}{
  \clearpage
  \thispagestyle{empty}
  \includepdf{auth.pdf}
  \clearpage
}

% -------------------------
% 5. Abstract & TOC
% -------------------------
\newenvironment{cnabstract}{
  \clearpage
  \pagenumbering{Roman}
  \pagestyle{suep_header}
  % Set leftmark for the odd page header
  \markboth{\tl_use:N \g__suep_c_title_tl}{\tl_use:N \g__suep_c_title_tl}
  
  \begin{center}
    {\sffamily\bfseries\erhao \tl_use:N \g__suep_c_title_tl \par}
    \vspace{2\baselineskip}
    {\sffamily\bfseries\sanhao 摘 \quad 要 \par}
  \end{center}
  \par\vspace{1\baselineskip}
  \sihao\songti
}{\clearpage}

\newcommand{\cnkeywords}[1]{
  \par\vspace{2\baselineskip}\noindent
  {\sffamily\bfseries\sihao 关键词：} % Bold size 4 Heiti
  {\sihao\songti #1}
}

\newenvironment{enabstract}{
  \clearpage
  \markboth{\tl_use:N \g__suep_e_title_tl}{\tl_use:N \g__suep_e_title_tl}
  \begin{center}
    {\bfseries\erhao \tl_use:N \g__suep_e_title_tl \par}
    \vspace{2\baselineskip}
    {\bfseries\sanhao ABSTRACT \par}
  \end{center}
  \par\vspace{2\baselineskip}
  \sihao % Default Times New Roman size 4
}{\clearpage}

\newcommand{\enkeywords}[1]{
  \par\vspace{2\baselineskip}\noindent
  {\bfseries\sihao KEY WORDS:~}
  {\sihao #1}
}

% TOC formatting
\renewcommand{\contentsname}{\centerline{\sffamily\bfseries\sanhao 目\quad 录}}
\titlecontents{section}[0em]{\songti\xiaosi}{\thecontentslabel\quad}{}{\titlerule*[0.5pc]{.}\contentspage}
\titlecontents{subsection}[2em]{\songti\xiaosi}{\thecontentslabel\quad}{}{\titlerule*[0.5pc]{.}\contentspage}
\titlecontents{subsubsection}[4em]{\songti\xiaosi}{\thecontentslabel\quad}{}{\titlerule*[0.5pc]{.}\contentspage}

% End of suepthesis class
