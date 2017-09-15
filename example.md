<<dd_include: stheader.txt>>


Estimating, graphing, and interpreting interactions using margins
=================================================================

After we fit a model, the effects of covariate interactions are of 
special interest. With **margins** and factor-variable notation, 
I can easily estimate, graph, and interpret effects for models with 
interactions. This is true for linear models and for nonlinear models 
such as probit, logistic, and Poisson. Below, I illustrate how this works. 

Factor variable notation makes my life easier
---------------------------------------------

Suppose I want to fit a model that includes the interactions between 
continuous variables, between discrete variables, or between a combination 
of the two. I do not need to create dummy variables, interaction terms, 
or polynomials. I just use factor-variable notation.

If I want to include the square of a continuous variable x in my model, I type 

~~~~
c.x#c.x
~~~~

If I want a third-order polynomial, I type

~~~~
c.x#c.x#c.x
~~~~

If I want to use a discrete variable a with five levels, I do not need to 
create a dummy variable for four categories. I simply type

~~~~
i.a
~~~~

If I want to include x, a, and their interaction in my model, I type

~~~~
c.x##i.a
~~~~

**Stata** now understands which variables in my model are continuous and which 
variables are discrete. This matters when I am computing effects. If I am 
interested in marginal effects for a continuous variable on an outcome of 
interest, the answer is a derivative. If I am interested in the effect for a 
discrete variable on an outcome, the answer is a discrete change relative to 
a base level. After fitting a model with discrete variables and interactions 
specified in this way with **margins**, I automatically get the effects I want.

margins and factor variables in action
--------------------------------------

Suppose I am interested in modeling the probability of an individual being 
married as a function of years of schooling ("__education__"), the percentile 
of income distribution to which that individual belongs ("**percentile**"), 
the number of times he or she has been divorced ("**divorces**"), and whether 
his or her parents are divorced ("**pdivorced**"). 

I want to use probit to estimate the parameters of the relationship

$P(y|x, d) = \Phi \left(\beta_0 + \beta_1x + \beta_3d + \beta_4xd + \beta_2x^2 \right)$


I fit the model like this: 

~~~~
. probit married c.education##c.percentile c.education#i.divorces i.pdivorced##i.divorces
~~~~


Factor-variable notation helps me introduce the continuous variables 
**education** and **percentile**; the discrete variables **divorces** and 
**pdivorced**; and the interactions between **education** and **percentile**, 
**education** and **divorces**, and **divorces** and **pdivorced**. **Stata** reports

<<dd_do:quietly>>
local oldline = c(linesize)
set linesize 80
clear
set obs 5000
set seed 1111
generate education   = int(rbeta(4,2)*15)
generate percentile  = int(rbeta(1,7)*100)/100
generate divorces    = int(rbeta(1,4)*3)
generate pdivorced   = runiform()<.6
generate e           = rnormal()
generate xbeta       = .35*(education*.06 + .5*percentile +    ///
                       .8*percentile*education                 ///
                       + .07*education*divorce - .5*divorce -  ///
                       .2*pdivorce - divorce*pdivorce - .1)
generate married     = xbeta + e > 0
<</dd_do>>

<<dd_do:quietly>>
probit married c.education##c.percentile c.education#i.divorces i.pdivorced##i.divorces
<</dd_do>>

~~~~
<<dd_do:nocommand>>
probit
<</dd_do>>

~~~~

Using the results from my probit model, I can estimate the average change in 
the probability of being married as the interacted variables **divorces** and 
**education** both change. To get the effect I want, I type

~~~~
. margins divorces, dydx(education) pwcompare 
~~~~

The **dydx(education)** option computes the average marginal effect of 
education on the probability of divorce, while the **divorces** statement 
after **margins** paired with the **pwcompare** option computes the discrete 
differences between the levels of divorce. Stata reports 

~~~~
<<dd_do:nocommand>>
margins divorces, dydx(education) pwcompare
mat define rb_vs = r(b_vs)
<</dd_do>>
~~~~

The average marginal effect of education is <<dd_display: %4.3f rb_vs[1,2]>> 
higher when everyone is divorced two times instead of everyone being divorced 
zero times. The difference in the average marginal effect of education when 
everyone is divorced one time versus when everyone is divorced zero times 
is <<dd_display: %4.3f rb_vs[1,1]>>. This difference is not significantly 
different from 0. The same is true when everyone is divorced two times instead 
of everyone being divorced one time. ~~??~~

<<dd_do:nocommand>>
assert rb_vs[1, 1] < 0.1
assert rb_vs[1, 1] < rb_vs[1, 2] 
<</dd_do>>

What I did above was to change both **education** and **pdivorce** 
simultaneously. In other words, to get the interaction effect, I computed a 
cross or double derivative (technically, for the discrete variable, I do not 
have a derivative but a difference with respect to the base level for the 
discrete variables).

This way of tackling the problem is unconventional. What is usually done is 
to compute the derivative with respect to the continuous variable, evaluate 
it at different values of the discrete covariate, and graph the effects. 
If we do this, we get

~~~~
<<dd_do>>
margins, dydx(education) at(divorces==0) at(divorces==1) at(divorces==2)
<</dd_do>>
~~~~

<<dd_do:qui>>
mat define rb = r(b)
marginsplot, xlabel(, angle(vertical))
<</dd_do>>

<<dd_graph: sav("test.png") replace height(400)>> 

To get the effects from the previous example, I only need to take the 
differences between the different effects. For instance, the first interaction 
effect is the difference of the first and second margins, 
<<dd_display: %4.3f rb[1,2] "-" %4.3f rb[1,1]>> = <<dd_display: %4.3f rb[1,2]-rb[1,1]>>.

## What have we learned?

We can use margins and factor-variable notation to estimate and graph 
interaction effects. In the example above, I computed an interaction effect 
between a continuous and a discrete covariate, but I can also use margins to 
compute interaction effects between two continuous or two discrete covariates, 
as is shown in [this blog article](http://blog.stata.com/2016/07/12/effects-for-nonlinear-models-with-interactions-of-discrete-and-continuous-variables-estimating-graphing-and-interpreting/).

<<dd_do:quietly>>
set linesize `oldline'
<</dd_do>>

 
