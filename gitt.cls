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

% Import packages
\RequirePackage{graphicx}
\RequirePackage[usenames,dvipsnames,svgnames]{xcolor}
\RequirePackage{fancyvrb,relsize}
\RequirePackage[final]{microtype}
\RequirePackage{tikz}

% Use Latin Modern for the sans serif font
\RequirePackage{lmodern}

% Use Palatino for the serif font
\RequirePackage[osf,sc]{mathpazo}

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

% Print just the chapter name without 'Chapter #.' in the running heads
\RequirePackage{textcase}
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
  pdfpagemode=None,
  urlcolor=black,
  citecolor=black,
  linkcolor=black,
  pagecolor=black,
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

% Set the heading styles
\chapterstyle{dash}
\setsecheadstyle{\Large\centering}
\setsubsecheadstyle{\scshape\centering}
\setsubsubsecheadstyle{\itshape\centering}


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


