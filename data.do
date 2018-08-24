cscript

import excel example.xlsx, firstrow

local no_problems = 10
local max_measure = 7

forval i=1/`no_problems' {
	// use tab, matcell matrow to save results from -tab- to a vector
	// for question i
	tab 第`i'题, matcell(info_`i') matrow(measure_`i')
	summarize 第`i'题
	mat results_`i' = J(1, `max_measure'+3, 0)
	mat results_`i'[1, 1] = r(N)	
	local row = rowsof(measure_`i')
	forval j=1/ `row' {
			mat results_`i'[1, 1+measure_`i'[`j', 1]] = 100*info_`i'[`j', 1]/r(N)
	}
	
	mat results_`i'[1, `max_measure'+1] = r(min)
	mat results_`i'[1, `max_measure'+2] = r(max)
	
	// add the results from question i to the the results of other questions
	// to form a matrix
	if "`i'" == "1" {
		mat define results = results_1
	}
	else {
		mat results = (results\results_`i')
	}
}

// now let's setup row names and col names
local rownames = ""
forval i=1/`no_problems' {
	local rownames = "`rownames' 第`i'题"
}

mat rownames results = `rownames'

local colnames = "样本数"
forval j=1/`max_measure' {
	local colnames = "`colnames' `j'"
}

local colnames = "`colnames' 最小"
local colnames = "`colnames' 最大"

mat colnames results = `colnames'

mat list results

// now export to a word document
putdocx begin
putdocx table t_res = matrix(results), nformat(%9.2f) rownames colnames
// You can further cuastomize the format of the table
putdocx save example.docx, replace
