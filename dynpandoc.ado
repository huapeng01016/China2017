*! version 1.0.0  16jul2017
program dynpandoc
	version 15
	
	syntax anything(everything) [, SAVing(string asis)  	/// 
			REPlace					///
			noREMove				///
			from(string)				///
			to(string)				///
			path(string)				///
			pargs(string asis)				///
			]
			
	gettoken file opargs : anything
	local srcfile = strtrim("`file'")
	confirm file "`srcfile'"

	local destfile = strtrim(`"`saving'"')
	if (`"`destfile'"' == "") {
		mata:(void)pathchangesuffix("`srcfile'", "html", "destfile", 0)	
	}

	mata: (void)pathresolve("`c(pwd)'", `"`destfile'"', "destfile") 	

	dyntext `"`srcfile'"' `opargs', saving(`"`destfile'"') 	///
		`replace' `remove' `stop' 

	tempfile mlogfile
	qui copy "`destfile'" `"`mlogfile'"'
	pandocmarkdown `mlogfile', saving(`destfile') 	///
		path(`path') from(`from') to(`to')	/// 
		pargs(`pargs') `msg' `replace'	
end

