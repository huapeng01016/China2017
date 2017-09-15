# Stata 15 新功能简介

##  [彭华@StataCorp][hpeng]
### 2017 Stata 中国用户大会 

# Why Stata
"Stata is a complete, integrated statistical software package that provides 
everything you need for data analysis, data management, and graphics."

# Stata 15 新功能

##
- Extended regression models
- Latent class analysis (LCA)
- Bayesian prefix command
- Linearized dynamic stochastic general equilibrium (DSGE) models
- Dynamic Markdown documents for the web

##
- Nonlinear mixed-effects models
- Spatial autoregressive models (SAR)
- Interval-censored parametric survival-time models
- Finite mixture models (FMMs)
- Mixed logit models
- Nonparametric regression

##
- Power analysis for cluster randomized designs and regression models
- Word and PDF documents
- Graph color transparency/opacity
- ICD-10-CM/PCS support
- Federal Reserve Economic Data (FRED) support

## 其他
- Bayesian multilevel models
- Threshold regression
- Panel-data tobit with random coefficients
- Multilevel regression for interval-measured outcomes
- Multilevel tobit regression for censored outcomes

##
- Panel data cointegration tests
- Tests for multiple breaks in time series
- Multiple-group generalized SEM
- Heteroskedastic linear regression
- Poisson models with Heckman-style sample selection

##
- Panel-data nonlinear models with random coefficients
- Bayesian panel-data models
- Panel-data interval regression with random coefficients
- SVG export
- Bayesian survival models

##
- Zero-inflated ordered probit
- Add your own power and sample-size methods
- Bayesian sample-selection models
- Stata in Swedish
- Improvements to the Do-file Editor

##
- Stream random-number generator
- Improvements for Java plugins
- More parallelization in Stata/MP

# 新功能举例-可重复文件

减少手工编辑文件

- 混合Stata输出与格式化文句 
- 在句子中包括Stata结果
- 加入Stata图型
- 部分Stata命令支持生成表格 

# Stata 15命令
 
- dyndoc - 转换dynamic Markdown documents成网页 
- putdocx - 生成Word文件
- putpdf - 生成PDF文件

# dyndoc举例 

从[dynamic markdown document](./example.md)生成[a blog article](./example.html)

# dynamic tags

## dd_do - Stata命令
````
<<dd_ignore>>
<<dd_do>>
sysuse auto
regress weight displacement
<</dd_do>>
<</dd_ignore>>
````

##
````
<<dd_do>>
sysuse auto
regress weight displacement
<</dd_do>>
````

##
Attributes改变tag的行为
 
````
<<dd_ignore>>
<<dd_do:quietly>>
matrix define eb = e(b)
<</dd_do>>
<</dd_ignore>>
````

<<dd_do:quietly>>
matrix define eb = e(b)
<</dd_do>>


## dd_display - Stata结果 
<<dd_ignore>>
- **displacement**每增加一单位，预计**weight**增加<<dd_display:%9.4f eb[1,1]>>单位 
<</dd_ignore>>

> - **displacement**每增加一单位，预计**weight**增加<<dd_display:%9.4f eb[1,1]>>单位

## dd_graph - Stata图型
````
<<dd_ignore>>
<<dd_do:quietly>>
scatter weight displacement, mcolor(red%30)
<</dd_do>>
<</dd_ignore>>
````
<<dd_do:quietly>>
scatter weight displacement, mcolor(red%30)
<</dd_do>>

````
<<dd_ignore>>
<<dd_graph>>
<</dd_ignore>>
````

##
#### <<dd_graph>>


# putdocx

从[do-file](./exdocx.do)生成[.docx document](./exdocx.docx) 

- 可具体控制文字格式 
- 灵活可调节的表格输出

# Markdown表格

从[Stata命令](./table.md)生成[Markdown tables](./table.html)

- estimation命令使用 **\_coef_table** 
- **table**
- **estimates table** 

# dyntext
dynamic tag可用于任意文本文件，例如LaTeX

# LaTeX文件

从包含dynamic tags的[LaTeX文件](./extex.md)生成[.pdf file](./extex.pdf)

- **sjlog** （a user written command) 
- **pdflatex**

# 使用pandoc替换Stata's **markdown**命令

使用[**dynpandoc**](./dynpandoc.ado)生成[本次讲座的文件](./china17.md)

# putpdf

从[do-file](./expdf.do)生成[.pdf文件](./expdf.pdf) 

 
# 谢谢

[hpeng]: hpeng@stata.com
