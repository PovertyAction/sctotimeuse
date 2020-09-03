/* 
Graph enumerator productivity using question-level timestamps captured using SurveyCTO's text_audit feature 

Author: William Blackmon, wblackmon@poverty-action.org
*/

cap program drop sctotimeuse
program sctotimeuse
	syntax [if] [in], media(string) enumerator(varname) outcome(varname) [save(string) starttime(varname) key(varname) type(string)]
	quietly {
	
	* preserve a copy of current dataset
	preserve

	* set default type 
	if "`type'" == "" loc type "pdf"

	* set default starttime 
	if "`starttime'" == "" loc starttime "starttime"
	
	* confirm necessary commands are installed
	foreach c in grstyle {
		qui cap which `c'
		if _rc>0 {
			di as error `"Command `c' required. Install by typing "ssc install `c'"."'
			error 1
		}
	}

	* initialize temporary files
	tempfile preserve1
	tempfile preserve2

	* set graph style
	grstyle init
	grstyle set plain, horizontal compact


	* keep according to if/in
	if "`if'" != "" keep `if'
	if "`in'" != "" keep `in'

	* clean up enumerator name variable
	tempvar enum
	cap decode `enumerator', gen(`enum') // in case enumerator variable is encoded
	if _rc>0 gen `enum' = `enumerator'

	* prep text audit data 
	tempfile full 
	n di "Preparing text audit data..."
	count
	loc totobs = `r(N)'
	loc counter = 0
	forvalues n = 1/`=_N' {
		if mod(`n',50)==0 n di "   - `n' of `=_N' complete"
		loc thiskey = subinstr(key[`n'], "uuid:", "", 1)
		loc thisstart = `starttime'[`n']
		loc thisenum = `enum'[`n']
		loc thisoutcome = `outcome'[`n']
		save `preserve1', replace
		cap import delimited "`media'/TA_`thiskey'", clear
		if _rc == 0 {
			loc ++counter
			gen start = `thisstart'
			gen enum = "`thisenum'"
			gen outcome = "`thisoutcome'"
			keep enum outcome start firstappeared
			if `counter'>1 append using `full', force
			save `full', replace
		}
		use `preserve1', clear
	}
	loc failed = `totobs' - `counter'
	if `failed' > 0 n di "Note `failed' observations do not match with text audit data."

	* prep data for graphing
	use `full', clear
	encode enum, gen(enum_enc)
	gen double first = start + firstappeared*1000
	format first start %tc
	gen date = dofc(start)
	gen time = hh(first) + mm(first)/60 + ss(first)/60/60
	lab def hours 0 "12AM" 1 "1AM" 2 "2AM" 3 "3AM" 4 "4AM" 5 "5AM" 6 "6AM" 7 "7AM" 8 "8AM" 9 "9AM" 10 "10AM" 11 "11AM" ///
	12 "12PM" 13 "1PM" 14 "2PM" 15 "3PM" 16 "4PM" 17 "5PM" 18 "6PM" 19 "7PM" 20 "8PM" 21 "9PM" 22 "10PM" 23 "11PM" 24 "12AM"
	lab val time hours

	// graph
	sum enum_enc
	loc enummax = r(max)
	sum time
	loc xmin = floor(r(min))
	loc xmax = ceil(r(max))	
	levelsof date, loc(dates)
	foreach d of local dates { // loop over survey dates creating a separate graph for each
		save `preserve2', replace
		keep if date==`d'
		loc thisdate : di %tdDayname,_Month_dd,_YYYY `d'
		loc thisdatenum : di %tdYYYYNNDD `d'
		loc grtext
		loc legtext
		loc i = 0
		levelsof outcome, loc(outs)
		foreach out of local outs { // loop over survey outcomes 
			loc ++i
			loc grtext = `"`grtext' (scatter enum_enc time if outcome=="`out'", msize(vsmall))"'
			loc legtext = `"`legtext' `i' "`out'""'
		}
		twoway `grtext', title("`thisdate'") xtitle("") ytitle("") ///
			xlabel(`xmin'(1)`xmax', valuelabels) ylabel(1(1)`enummax', valuelabels) ///
			legend(order(`legtext'))
		if "`save'" != "" graph export "`save'/timeuse_`thisdatenum'.`type'", replace
		pause
		graph close
		use `preserve2', clear
	}
	} // end quietly

	* re-open original dataset
	grstyle clear 
	restore

end
