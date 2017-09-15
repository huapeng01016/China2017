*! version 1.0.0  11jul2017

program pandocmarkdown
	version 15
	
	syntax anything, SAVing(string) [		///
				REPlace			///
				nomsg			///
				from(string)		///
				to(string)		///
				path(string)		///
				pargs(string asis)	///
				]

	tokenize `"`anything'"'
	local srcfile `"`1'"'
	local fn2 `"`2'"'
	if ("`fn2'"!="") {
		di "invalid syntax"
		exit 198
	}
	confirm file `"`srcfile'"'
	
	local destfile = strtrim("`saving'")

	mata: (void)pathresolve("`c(pwd)'", "`destfile'", "destfile") 
	
	local issame = 0
	mata: (void)filesarethesame("`srcfile'", "`destfile'", "issame")
	
	if ("`issame'" == "1") {
di in error "target file can not be the same as the source file"
		exit 602			
	}
		
	if ("`replace'" == "") {
		confirm new file `"`destfile'"'
	}

	local cmd = "pandoc"
	
	if ("`path'" != "") {
		local cmd = "`path'`cmd'"
	}
	
	if ("`from'" == "") {
		local from = "markdown"
	}
	
	if ("`to'" == "") {
		local to = "html"
	}

    	tempfile tmpfile		
	if (strlower("`to'") == "pdf") {
		local tmpfile = "`tmpfile'.pdf"	
		local to = "latex"
	}
	
	local execmd = `"`cmd' `srcfile' -s -o `tmpfile' -f `from' -t `to' `pargs'"'
 
	qui shell `execmd'	
	qui copy "`tmpfile'" "`destfile'", replace
	cap erase "`tmpfile'"
	
    if ("`msg'" == "") {
		if(substr("`destfile'", 1, 1)=="/") {
			local flink = subinstr("file:`destfile'", " ", "%20", .)			
		}
		else {
			local flink = subinstr("file:/`destfile'", " ", "%20", .)
		}    
di in smcl `"successfully converted {browse "`destfile'"}"'             
    }
end
