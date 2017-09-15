<<dd_include: stheader.txt>>

# Generate markdown tables from Stata commands

- Stata estimation commands using **\_coef_table**, 
- **table**, 
- **estimates table** 

### estimation commands

~~~~
<<dd_do: nooutput>>
use margex, clear
logistic outcome i.sex i.group sex#group age
<</dd_do>>
~~~~

<<dd_do: nocommand>>
_coef_table, markdown
<</dd_do>>


### table 

~~~~
. use byssin, clear
. table workplace smokes race [fw=pop], c(mean prob) format(%9.3f) sc markdown
~~~~

<<dd_do: nocommand>>
use byssin, clear
table workplace smokes race [fw=pop], c(mean prob) format(%9.3f) sc markdown
<</dd_do>>


### estimates table

<<dd_do:quietly>>
sysuse auto, clear
regress mpg gear turn
estimates store small
regress mpg gear turn length
estimates store large
<</dd_do>>

~~~~
. sysuse auto
. regress mpg gear turn
. estimates store small
. regress mpg gear turn length
. estimates store large
. estimates table small large, b(%7.4f) se(%7.4f) stats(N r2_a) markdown
~~~~

<<dd_do:nocommand>>
estimates table small large, b(%7.4f) se(%7.4f) stats(N r2_a) markdown
<</dd_do>>


## The Stata default markdown supports multimarkdown table format

*  There must be at least one | per line
*  The "separator" line between headers and table content must contain only |,-, =, :,., +, or spaces
*  Cell content must be on one line only
*  Columns are separated by |
*  The first line of the table, and the alignment/divider line, must start at the beginning of the line
