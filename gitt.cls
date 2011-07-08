%
% Book design for Git in the Trenches
%

\NeedsTeXFormat{LaTeX2e}[1994/06/01]

\ProvidesClass{gitt}[2011/05/15 v1.0.0 GITT book design]

\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{memoir}%
}
\ProcessOptions*\relax


\LoadClass[a5paper,openright,10pt]{memoir}

% set paper size
\setlrmarginsandblock{2.16cm}{1.91cm}{*}
\setulmarginsandblock{1.91cm}{1.91cm}{*}
\checkandfixthelayout

% Reset the figure numbering at the beginning of each chapter and print only
% the figure number (not including the chapter number).
\renewcommand{\thefigure}{\arabic{figure}}

% Import packages
\RequirePackage{graphicx}
\RequirePackage{eso-pic}
\PassOptionsToPackage{usenames,dvipsnames,svgnames}{xcolor}
%\RequirePackage[usenames,dvipsnames,svgnames]{xcolor}
\RequirePackage{fancyvrb,relsize}
\RequirePackage[final]{microtype}
\RequirePackage{tikz}

% Use Latin Modern for the sans serif font
\RequirePackage{lmodern}

% Use Palatino for the serif font
\RequirePackage[osf,sc]{mathpazo}

% Ornaments
\RequirePackage{adforn}

% microtype makes justified text look nicer by allowing punctuation and some
% letters to hang slightly into the margin
\RequirePackage{microtype}

%\renewcommand{\familydefault}{\sfdefault}

% Put chapters and sections in the toc, only number the chapter
\setcounter{tocdepth}{3}
\setcounter{secnumdepth}{0}

% Make chapter names disappear
%\renewcommand{\chaptername}{}
%\renewcommand{\thechapter}{}
\renewcommand{\tablename}{}
\renewcommand{\thetable}{}


% Macros for capitalizing and letter-specing text
\RequirePackage{textcase}
\DeclareTextFontCommand{\textsmallcaps}{\scshape}
\newcommand{\allcapsspacing}[1]{\textls[200]{#1}}%
\newcommand{\smallcapsspacing}[1]{\textls[50]{#1}}%
\newcommand{\allcaps}[1]{\allcapsspacing{\MakeTextUppercase{#1}}}%
\newcommand{\smallcaps}[1]{\smallcapsspacing{\scshape\MakeTextLowercase{#1}}}%
\renewcommand{\textsc}[1]{\smallcapsspacing{\textsmallcaps{#1}}}%

% Print just the chapter name without 'Chapter #.' in the running heads
\newcommand{\runninghead}[1]{\textsc{\MakeTextLowercase{#1}}}
\renewcommand{\chaptermark}[1]{\markboth{\runninghead{#1}}{}}
\renewcommand{\sectionmark}[1]{\markright{\runninghead{#1}}}

% Make the pdf have clickable links
\RequirePackage{hyperref}
\hypersetup{%
  bookmarks,
  bookmarksopen,
  bookmarksnumbered=false,
  colorlinks,
  pdfpagemode=UseNone,
  urlcolor=black,
  citecolor=black,
  linkcolor=black,
  plainpages=false,
  pdfpagelabels,
}

\AtBeginDocument{%
  \hypersetup{%
    pdftitle={\thetitle},
    pdfauthor={\theauthor},
  }%
}

\AtBeginDocument{%
  \hyphenpenalty=1000
  \tolerance=1000
}


% Set the chapter heading style
\makechapterstyle{gitt}{%
  \chapterstyle{default}%
  \renewcommand*{\chapterheadstart}{}%
  \renewcommand*{\printchaptername}{}%
  \renewcommand*{\chapternamenum}{}%
  \renewcommand*{\printchapternum}{}%
  \renewcommand*{\afterchapternum}{}%
  \renewcommand*{\printchaptertitle}[1]{%
    %\centering\Large\adforn{64}\quad##1\quad\adforn{36}%
    \begin{center}\Large##1\end{center}%
  }%
  \renewcommand*{\afterchaptertitle}{}%
}
\chapterstyle{gitt}

% Set the sub-heading styles
\setsecheadstyle{\centering\allcaps}
\setsubsecheadstyle{\centering\itshape}
\setsubsubsecheadstyle{\centering\smallcaps}
\newcommand{\paraheading}[1]{\smallcaps{#1}\quad}
\setparaheadstyle{\paraheading}


% give us a begin{trenches}
\newenvironment{trenches}{%
  \begin{quote}%
    \begin{sffamily}%
      \textbf{In the trenches\ldots}\par
}{%
    \end{sffamily}%
  \end{quote}%
}

% Set the default formatting options for the Verbatim environment
\fvset{frame=leftline,rulecolor=\color{gray},framerule=1mm,fontsize=\footnotesize}

% Callout boxes
\newsavebox{\callout@contents}
\newcommand{\callout@type}{}
\newcommand{\callout@title}{}
\newenvironment{callout}[2]{%
  \xdef\callout@type{#1}% typeset in a box along the left
  \xdef\callout@title{#2}% typeset in a box along the top
  \begin{lrbox}{\callout@contents}%
    \begin{minipage}{.9\textwidth}%
}{%
    \end{minipage}%
  \end{lrbox}%
  \begin{figure}[hbt]%
    \tikzstyle{mybox} = [draw=black, fill=gray!20, very thick, rectangle, rounded corners, inner sep=15pt, inner ysep=20pt]
    \tikzstyle{fancytitle} = [fill=black, text=white]
    \hskip-10pt% allows the type block to hang into the left margin
    \begin{tikzpicture}%
      \node[mybox] (box) {\usebox{\callout@contents}};
      \node[fancytitle, right=16pt] at (box.north west) {\callout@title};
      \node[fancytitle, rounded corners] at (box.west) {\rotatebox{90}{\callout@type}};
    \end{tikzpicture}%
  \end{figure}%
}

% Indicates thought breaks
\newcommand{\thoughtbreak}{%
  \par\begin{center}*\quad*\quad*\end{center}\par
}

% Inserts a full-page graphic.
\newcommand{\coverpage}[1]{%
  \thispagestyle{empty}%
  \IfFileExists{#1}{%
    \AddToShipoutPicture*{\put(0,0){\includegraphics[width=\paperwidth,height=\paperheight]{#1}}}%
  }{%
    \ClassWarningNoLine{gitt}{Missing cover page graphic:\MessageBreak #1}%
  }%
  \null\clearpage%
}

