putdocx clear 
putdocx begin

/* formatted text */
putdocx paragraph
putdocx text (". sysuse auto, clear"), bold
sysuse auto, clear

putdocx paragraph
putdocx text (". summarize mpg"), bold
qui summarize mpg
local sum : display %4.2f `r(sum)'

putdocx paragraph
putdocx text ("We can easily add "), font("normal small-caps") 
putdocx text ("Stata "), bold
putdocx text ("results (")
putdocx text ("mpg total"),  shading("red") 
putdocx text ("=")
putdocx text (" `sum'"), italic
putdocx text (").") 


/* formatted text in table cell*/
putdocx paragraph
putdocx text ("We can add formatted text to a table cell.")

putdocx table a = (2,2)
putdocx table a(1,1)=("italicize, "), italic append
putdocx table a(1,1)=("strikeout, "), strikeout append
putdocx table a(1,1)=("underline"), underline append
putdocx table a(1,1)=(", sub/super script"), append
putdocx table a(1,1)=("2 "), script(super) append
putdocx table a(1,1)=(", and "), append
putdocx table a(1,1)=("shade the text."), shading("red") append
putdocx table a(1,1)=(" Stata results too (mpg total = `sum')"), append


/* estimation table */
putdocx paragraph
putdocx text ("We can easily add estimation table using etable.")

putdocx paragraph
putdocx text (". regress mpg foreign weight headroom trunk length turn displacement"), bold
regress mpg foreign weight headroom trunk length turn displacement
putdocx table reg1 = etable


putdocx paragraph
putdocx text (". estimates table"), bold
regress mpg gear turn
estimates store m1
regress mpg gear turn length
estimates store m2
estimates table m1 m2, b(%7.3f) se(%7.3f) stats(N r2_a)
putdocx table reg3 = etable


/* graph in table cell */
putdocx paragraph
putdocx text ("We can put graphs in table cells.")
scatter mpg price if foreign == 1, mcolor(%20)
graph export for1.png, replace
scatter mpg price if foreign == 0, mcolor(%20)
graph export for0.png, replace 
putdocx table img = (1,2), border(all,nil)
putdocx table img(1,1) = image(for1.png)
putdocx table img(1,1) = ("Foreign"), append halign(center) bold
putdocx table img(1,2) = image(for0.png)
putdocx table img(1,2) = (" Domestic"), append halign(center) bold
putdocx table img(1,.), addrows(1)
putdocx table img(2,1)=("Scatter plot: mpg price"), 	///
	halign(center) colspan(2) bold

putdocx save exdocx, replace
