/* 
	Author: 	Hua Peng
	Date:		Jul 16, 2017
	Purpose:	Build reveal.js slides deck for 2017 Stata China UGM	
*/

dynpandoc china17.md, sav(china17.html) replace to(revealjs)	/// 
  pargs(-s --template=revealjs.html --standalone                /// 
  --section-divs --variable theme="stata")

exit
