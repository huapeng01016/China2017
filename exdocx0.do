putdocx clear 
putdocx begin

sysuse auto, clear
putdocx paragraph
putdocx text ("putdocx "), bold
putdocx text ("can add formatted text to a paragraph.  You can ")
putdocx text ("italicize, "), italic
putdocx text ("strikeout, "), strikeout
putdocx text ("underline"), underline
putdocx text (", sub/super script")
putdocx text ("2 "), script(super)
putdocx text (", and ")
putdocx text ("shade the text"), shading("red")
qui sum mpg
local sum : display %4.2f `r(sum)'
putdocx text (". Also, you can easily add Stata results to your paragraph (mpg total = `sum')")

sysuse auto, clear
putdocx table a = (2,2)
putdocx table a(1,1)=("putdocx "), bold
putdocx table a(1,1)=("can add formatted text to a cell.  You can "), append
putdocx table a(1,1)=("italicize, "), italic append
putdocx table a(1,1)=("strikeout, "), strikeout append
putdocx table a(1,1)=("underline"), underline append
putdocx table a(1,1)=(", sub/super script"), append
putdocx table a(1,1)=("2 "), script(super) append
putdocx table a(1,1)=(", and "), append
putdocx table a(1,1)=("shade the text"), shading("red") append
qui sum mpg
local sum : display %4.2f `r(sum)'
putdocx table a(1,1)=(". Also, you can easily add Stata results to your cell (mpg total = `sum')"), append

webuse college, clear
collapse (p25) p25=gpa (p75) p75=gpa (min) Min=gpa (median) Median=gpa 	///
	(max) Max=gpa [fw=number], by(year)
putdocx table gpa = data(_all), varnames 				///
	border(all,nil) border(top) border(bottom)
putdocx table gpa(1,.), border(bottom)

forvalues row=1/5 {
	putdocx table gpa(`row',.), halign(right)	
}

sysuse auto, clear
tabstat price weight mpg rep78, by(foreign) stat(mean sd min max) save
mat Stat = r(Stat1) \ r(Stat2) \ r(StatTotal)
putdocx table tab = mat(Stat), nformat(%9.3g) colnames 			///
	border(all,nil) border(bottom)
putdocx table tab(., 1), addcols(1, before) border(right)
putdocx table tab(1, 1) = ("foreign")

local divd 2
foreach x in Foreign Domestic Total {
	putdocx table tab(`divd', .), border(top)
	putdocx table tab(`divd', 1) = ("`x'")
	local divd = `divd' + 4
} 
local nrows = 4*3+1
forvalues row = 1/`nrows' {
	putdocx table tab(`row', .), halign(right)
}

sysuse auto, clear 
regress mpg foreign weight headroom trunk length turn displacement
putdocx table reg1 = etable

sysuse auto, clear 
regress mpg foreign weight headroom trunk length turn displacement, nopvalues cformat(%9.3f)
putdocx table reg2 = etable

sysuse auto, clear
regress mpg gear turn
estimates store m1
regress mpg gear turn length
estimates store m2
estimates table m1 m2, b(%7.3f) se(%7.3f) stats(N r2_a)
putdocx table reg3 = etable

webuse nhanes2, clear
regress bpsystol  agegrp##sex##c.bmi
forvalues v=10(10)20 {
	margins agegrp, over(sex) at(bmi=`v')
	marginsplot 
	graph export bmi`v'.png, replace
}

putdocx table img = (1,2), border(all,nil)
putdocx table img(1,1) = image(bmi10.png)
putdocx table img(1,1) = ("(a) bmi=10"), append halign(center) bold
putdocx table img(1,2) = image(bmi20.png)
putdocx table img(1,2) = ("(a) bmi=20"), append halign(center) bold
putdocx table img(1,.), addrows(1)
putdocx table img(2,1)=("Figure 1: Predictive margins of agegrp"), 	///
	halign(center) colspan(2) bold

putdocx save exdocx, replace
