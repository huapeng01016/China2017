putpdf clear 
putpdf begin

sysuse auto, clear
putpdf paragraph
putpdf text ("putpdf "), bold
putpdf text ("can add formatted text to a paragraph.  You can ")
putpdf text ("italicize, "), italic
putpdf text ("strikeout, "), strikeout
putpdf text ("underline"), underline
putpdf text (", sub/super script")
putpdf text ("2 "), script(super)
putpdf text (", and ")
putpdf text ("shade the text"), bgcolor("red")
qui sum mpg
local sum : display %4.2f `r(sum)'
putpdf text (". Also, you can easily add Stata results to your paragraph (mpg total = `sum')")

sysuse auto, clear
putpdf table a = (2,2)
putpdf table a(1,1)=("putpdf "), bold
putpdf table a(1,1)=("can add formatted text to a cell.  You can "), append
putpdf table a(1,1)=("italicize, "), italic append
putpdf table a(1,1)=("strikeout, "), strikeout append
putpdf table a(1,1)=("underline"), underline append
putpdf table a(1,1)=(", sub/super script"), append
putpdf table a(1,1)=("2 "), script(super) append
putpdf table a(1,1)=(", and "), append
putpdf table a(1,1)=("shade the text"), bgcolor("red") append
qui sum mpg
local sum : display %4.2f `r(sum)'
putpdf table a(1,1)=(". Also, you can easily add Stata results to your cell (mpg total = `sum')"), append

webuse college, clear
collapse (p25) p25=gpa (p75) p75=gpa (min) Min=gpa (median) Median=gpa 	///
	(max) Max=gpa [fw=number], by(year)
putpdf table gpa = data(_all), varnames 				///
	border(all,nil) border(top) border(bottom)
putpdf table gpa(1,.), border(bottom)

forvalues row=1/5 {
	putpdf table gpa(`row',.), halign(right)	
}

sysuse auto, clear
tabstat price weight mpg rep78, by(foreign) stat(mean sd min max) save
mat Stat = r(Stat1) \ r(Stat2) \ r(StatTotal)
putpdf table tab = mat(Stat), nformat(%9.3g) colnames 			///
	border(all,nil) border(bottom)
putpdf table tab(., 1), addcols(1, before) border(right)
putpdf table tab(1, 1) = ("foreign")

local divd 2
foreach x in Foreign Domestic Total {
	putpdf table tab(`divd', .), border(top)
	putpdf table tab(`divd', 1) = ("`x'")
	local divd = `divd' + 4
} 
local nrows = 4*3+1
forvalues row = 1/`nrows' {
	putpdf table tab(`row', .), halign(right)
}

sysuse auto, clear 
regress mpg foreign weight headroom trunk length turn displacement
putpdf table reg1 = etable

sysuse auto, clear 
regress mpg foreign weight headroom trunk length turn displacement, nopvalues cformat(%9.3f)
putpdf table reg2 = etable

sysuse auto, clear
regress mpg gear turn
estimates store m1
regress mpg gear turn length
estimates store m2
estimates table m1 m2, b(%7.3f) se(%7.3f) stats(N r2_a)
putpdf table reg3 = etable

webuse nhanes2, clear
regress bpsystol  agegrp##sex##c.bmi
forvalues v=10(10)20 {
	margins agegrp, over(sex) at(bmi=`v')
	marginsplot 
	graph export bmi`v'.png, replace
}

putpdf table img = (2,2), border(all,nil)
putpdf table img(1,1) = image(bmi10.png)
putpdf table img(2,1) = ("(a) bmi=10"), halign(center) bold
putpdf table img(1,2) = image(bmi20.png)
putpdf table img(2,2) = ("(a) bmi=20"), halign(center) bold
putpdf table img(2,.), addrows(1)
putpdf table img(3,1)=("Figure 1: Predictive margins of agegrp"), 	///
	halign(center) colspan(2) bold

putpdf save expdf, replace
