<<dd_do: quietly>>
syntax varlist(min=2 max=2) [if] [in]

preserve
if "`if'`in'" != "" {
	keep `if' `in'
}
keep `varlist'
mata:
st_local(st_varname(1), "var1")
st_local(st_varname(2), "var2")
st_local(st_nobs, "nobs")
end
<</dd_do>>

<html>
<head>
<link rel="stylesheet" type="text/css" href="http://dimebox.stata.com/~hop/markdown.css">

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawChart);
function drawChart() {
var data = google.visualization.arrayToDataTable([
  ['<<dd_display:`var1'>>', '<<dd_display:`var2'>>'],
<<dd_do: nocommands>>
forval i=1/`nobs' {
  local a = `var1'[`i']
  local b = `var2'[`i']	
  di "[`a', `b'],"
}	
<</dd_do>>	  
]);

var options = {
  title: '<<dd_display:`var1'>> vs. <<dd_display:`var2'>> comparison',
<<dd_do: qui>>
summ mpg
<</dd_do>>	  
  hAxis: {title: '<<dd_display:`var1'>>', minValue: 0, maxValue: 50},
<<dd_do: qui>>
summ price
<</dd_do>>	  
  vAxis: {title: '<<dd_display:`var2'>>', minValue: 2000, maxValue: 20000},
  legend: 'none'
};

var chart = new google.visualization.ScatterChart(document.getElementById('chart_div'));

chart.draw(data, options);
}
</script>
</head>
</html>

Use Google chart library and Stata dyndoc together
==================================================

<div id="chart_div" style="width: 900px; height: 500px;"></div>

<<dd_do: quietly>>
restore
<</dd_do>>
