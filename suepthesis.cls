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
  top=3.0cm, bottom=2.5cm,
  left=2.6cm, right=2.6cm,
  headheight=15pt,
  headsep=0.47cm, % 3.0cm - 2.0cm = 1.0cm total. 1.0cm - 15pt (~0.53cm) = 0.47cm
  footskip=0.5cm  % 2.5cm - 2.0cm = 0.5cm
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
\RequirePackage{caption}
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

% Setup captions: Masters (Chinese only), PhD (Bilingual)
\DeclareCaptionFont{wuhaosong}{\wuhao\songti}
\DeclareCaptionFont{wuhaotnr}{\wuhao\selectfont} % Times New Roman is default Roman

% Common caption settings
\captionsetup{font=wuhaosong, labelsep=quad, justification=centering}

% If doctor degree, setup bicaption
\str_case:Vn \g__suep_degree_tl
{
  { doctor }
  {
    \captionsetup[bi-first]{font=wuhaosong, labelsep=quad}
    \captionsetup[bi-second]{font=wuhaotnr, labelsep=quad}
  }
}

% Spacing between figure/table and text: 0.5 line
\setlength{\intextsep}{0.5\baselineskip}
\setlength{\textfloatsep}{0.5\baselineskip}
\setlength{\abovetopsep}{0.5\baselineskip} % for booktabs toprule? no, \abovecaptionskip
\setlength{\abovecaptionskip}{0.5\baselineskip}
\setlength{\belowcaptionskip}{0pt}

% -------------------------
% 2. Headers and Footers
% -------------------------
\fancypagestyle{suep_header}{
  \fancyhf{}
  % Header font: Wuhao Songti, Centered
  \fancyhead[C]{\wuhao\songti
    \ifodd\value{page}
      \leftmark % Odd page: Chapter Title or Section Title
    \else
      上海电力大学 \tl_use:N \l__suep_thesis_type_cn_tl % Even page: University + Type
    \fi
  }
  
  % Footers - Page number in Center
  % Font: Wuhao Times New Roman
  \fancyfoot[C]{\wuhao\selectfont\thepage}
  
  % The double line under header: 线粗 1 磅, 线长与页面齐宽
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
  % Chapter (一级标题) 黑体, 三号, 居中. 另起一页. 段前空3行, 段后空2行.
  section={
    format=\clearpage\centering\bfseries\heiti\sanhao,
    name={第,章},
    number=\chinese{section},
    aftername=\hspace{1\ccwd}, % 空一个字
    beforeskip=3\baselineskip,
    afterskip=2\baselineskip
  },
  % Section (二级标题) 宋体 加黑, 小三号. 段前空一行, 段后空0.5行.
  subsection={
    format=\bfseries\songti\xiaosan,
    aftername=\hspace{1\ccwd}, % 空一个字
    beforeskip=1\baselineskip,
    afterskip=0.5\baselineskip
  },
  % Subsection (三级标题) 宋体 加黑, 四号. 左起空两字符. 段前空0.5行, 段后空0行.
  subsubsection={
    format=\bfseries\songti\sihao,
    aftername=\hspace{1\ccwd}, % 空一个字
    indent=2\ccwd,
    beforeskip=0.5\baselineskip,
    afterskip=0pt
  }
}

% Paragraph settings: 宋体, 小四号, 首行缩进两字符. 1.25行间距. 段前段后0磅.
\setlength{\parindent}{2\ccwd}
\setlength{\parskip}{0pt}
\setstretch{1.25}

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
    % 3. Thesis Type (Chinese) - 小一号黑体
    {\centering\bfseries\heiti\xiaoyi \tl_use:N \l__suep_thesis_type_cn_tl \par}
    
    \vspace{5mm}
    % 5. Thesis Type (English) - For Doctor or Professional Master - 三号 TNR Bold
    \str_case:Vn \g__suep_degree_tl
    {
      { doctor }
      { {\centering\bfseries\sanhao \tl_use:N \l__suep_thesis_type_en_tl \par} }
      { master }
      {
        \str_case:Vn \g__suep_degreetype_tl
        {
          { professional }
          {
            {\centering\bfseries\sanhao \tl_use:N \l__suep_thesis_type_en_tl \par}
          }
        }
      }
    }

    \vspace{15mm}
    % 6. Chinese Title - 二号黑体
    {\centering\bfseries\heiti\erhao \tl_use:N \g__suep_c_title_tl \par}
    
    \str_case:Vn \g__suep_degree_tl
      {
        { doctor }
        {
          \vspace{5mm} 
          % 7. English Title (Doctor only) - 二号 TNR Bold
          {\centering\bfseries\erhao \tl_use:N \g__suep_e_title_tl \par}
        }
      }
    
    \vspace{15mm} 
    % 8. Personal info block. - 四号宋体
    \begin{center}
      \sihao\songti
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
      \sihao\songti
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
    % Title (上海电力大学 硕士学位论文) - 小一号黑体
    {\centering\bfseries\heiti\xiaoyi 上海电力大学 \tl_use:N \l__suep_thesis_type_cn_tl \par}

    \vspace{15mm} 
    % Chinese Title - 二号黑体
    {\centering\bfseries\heiti\erhao \tl_use:N \g__suep_c_title_tl \par}
    
    \str_case:Vn \g__suep_degree_tl
      {
        { doctor }
        {
          \vspace{5mm} 
          % English Title - 二号 TNR Bold
          {\centering\bfseries\erhao \tl_use:N \g__suep_e_title_tl \par}
        }
      }
    
    \vspace{25mm} 
    % Personal info block for inner page. - 小四号宋体
    \begin{center}
      \xiaosi\songti
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
      \sihao\songti
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
  % Set leftmark for the odd page header: Use "摘要" instead of title
  \markboth{摘 \quad 要}{摘 \quad 要}
  \addcontentsline{toc}{section}{摘 \quad 要}
  
  \begin{center}
    {\bfseries\heiti\sanhao \tl_use:N \g__suep_c_title_tl \par}
    \vspace{1\baselineskip}
    {\bfseries\heiti\sanhao 摘 \hspace{1\ccwd} 要 \par}
  \end{center}
  \vspace{1\baselineskip}
  \sihao\songti
}{\clearpage}

\newcommand{\cnkeywords}[1]{
  \par\vspace{1\baselineskip}\noindent
  {\bfseries\heiti\sihao 关键词：} % Bold size 4 Heiti
  {\sihao\songti #1}
}

\newenvironment{enabstract}{
  \clearpage
  \pagestyle{suep_header} % Ensure header is present
  \markboth{ABSTRACT}{ABSTRACT}
  \addcontentsline{toc}{section}{ABSTRACT}
  
  \begin{center}
    \vspace*{3\baselineskip} % 段前空3行
    {\bfseries\sanhao \MakeUppercase{\tl_use:N \g__suep_e_title_tl} \par}
    \vspace{3\baselineskip} % 题目下空三行
    {\bfseries\sanhao ABSTRACT \par}
  \end{center}
  \vspace{2\baselineskip} % 下空二行打印正文
  \sihao % Default Times New Roman size 4
  \setlength{\parindent}{4em} % 留四个字符空格
}{\clearpage}

\newcommand{\enkeywords}[1]{
  \par\vspace{2\baselineskip}\noindent % 下空二行
  {\bfseries\sihao KEY WORDS:~}
  {\sihao \lowercase{#1}} % 关键词小写
}

% TOC formatting
\renewcommand{\contentsname}{目 \hspace{2\ccwd} 录}
\renewcommand{\tableofcontents}{
  \clearpage
  \pagestyle{suep_header}
  \markboth{目 \hspace{1\ccwd} 录}{目 \hspace{1\ccwd} 录} % Header with some space
  \addcontentsline{toc}{section}{\contentsname}
  \begin{center}
    \vspace*{3\baselineskip} % 段前空3行
    \begin{spacing}{1.25} % 1.25 倍行距
      {\bfseries\heiti\sanhao \contentsname \par} % 三号黑体
    \end{spacing}
    \vspace{2\baselineskip} % 段后空2行 (下空两行为目录正文)
  \end{center}
  \@starttoc{toc}
}

% 目录正文: 第一级标题左边顶格对齐 (0em)
% 下一级标题左端空一个字符 (1\ccwd)
\titlecontents{section}[0em]{\vspace{0.2\baselineskip}\sihao\songti}{\thecontentslabel\hspace{1\ccwd}}{}{\titlerule*[0.5pc]{.}\contentspage}
\titlecontents{subsection}[1\ccwd]{\sihao\songti}{\thecontentslabel\hspace{1\ccwd}}{}{\titlerule*[0.5pc]{.}\contentspage}
\titlecontents{subsubsection}[2\ccwd]{\sihao\songti}{\thecontentslabel\hspace{1\ccwd}}{}{\titlerule*[0.5pc]{.}\contentspage}

% English TOC formatting (for doctor)
\titlecontents{esection}[0em]{\vspace{0.2\baselineskip}\sihao\selectfont}{\thecontentslabel\hspace{1\ccwd}}{}{\titlerule*[0.5pc]{.}\contentspage}
\titlecontents{esubsection}[1\ccwd]{\sihao\selectfont}{\thecontentslabel\hspace{1\ccwd}}{}{\titlerule*[0.5pc]{.}\contentspage}
\titlecontents{esubsubsection}[2\ccwd]{\sihao\selectfont}{\thecontentslabel\hspace{1\ccwd}}{}{\titlerule*[0.5pc]{.}\contentspage}

% English TOC for Doctor (PhD)
\newcommand{\englishtableofcontents}{
  \str_if_eq:VnTF \g__suep_degree_tl { doctor }
  {
    \clearpage
    \pagestyle{suep_header}
    \markboth{Contents}{Contents}
    \addcontentsline{toc}{section}{Contents}
    \begin{center}
      \vspace*{3\baselineskip}
      {\bfseries\sanhao CONTENTS \par}
      \vspace{2\baselineskip}
    \end{center}
    \@starttoc{etoc}
  }{
    % Do nothing for master
  }
}

% Helper commands for English TOC entries
\newcommand{\addengcontents}[3]{
  \addcontentsline{etoc}{e#1}{#2 #3}
}

% End of suepthesis class
