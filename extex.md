\documentclass[11pt]{article}
\usepackage{fullpage}
\usepackage{listings}
\usepackage{hyperref,graphicx}
\usepackage{enumerate}
\usepackage{stata}
\setlength\parindent{0pt} % sets indent to zero
\setlength{\parskip}{\baselineskip}
\title{Use dyntext to include Stata results in LaTeX files}
\author{Hua Peng}
\date{\today}
\begin{document}
\maketitle
\begin{abstract}
This document shows how to use Stata's dynamic tags in LaTeX files.  
\end{abstract}

<<dd_do:qui>>
cap erase ex1.log
cap erase ex1.log.tex
cap erase ex1.log.tex.log.tex
cap erase ex1.smcl
cap erase ex1.smcl.bak
cap erase ex2.log
cap erase ex2.log.tex
cap erase ex2.smcl
cap erase ex2.smcl.bak
cap erase ex2.log.tex.log.tex
cap erase ex3.log
cap erase ex3.log.tex
cap erase ex3.smcl
cap erase ex3.smcl.bak
cap erase ex3.log.tex.log.tex
set linesize 80
<</dd_do>>

We will use the \texttt{auto} dataset. It includes variable \texttt{price} 

\iffalse
<<dd_do>>
sjlog using ex1, replace 
sysuse auto, clear
regress mpg price
sjlog close, replace 
sjlog clean ex1.smcl, sjlog 
<</dd_do>>
\fi

\begin{stlog}[auto]
<<dd_do:nocommand>>
sjlog type ex1.log.tex
<</dd_do>>
\end{stlog}

The mean of price is <<dd_display:%9.0g r(mean)>>. We will also check the 
relationship between \texttt{mpg} and \texttt{weight} visually. 

<<dd_do:quietly>>
scatter mpg weight, mcolor(blue%30)
<</dd_do>>

\begin{center}
\begin{centering}
\includegraphics[height=4in]{<<dd_graph: sav("graph.png") replace pathonly>>}
\end{centering}
\end{center}

The .pdf file is generated with:

\begin{lstlisting}[frame=single]
dyntex extex.md, sav(extex.tex) replace
!pdflatex extex.tex
\end{lstlisting}

\end{document}

<<dd_do:quietly>>
set linesize 80
<</dd_do>>
