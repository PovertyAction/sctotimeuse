{smcl}
	{* *! version 1.1 William Blackmon 12Aug2020}{...}
	{title:Title}

	{phang}
	{cmd:sctotimeuse} {hline 2} Graph enumerator productivity using question-level timestamps captured using SurveyCTO's text_audit feature. 

	{marker syntax}{...}

	{title:Syntax}

	{p 8 10 2}
	{cmd:sctotimeuse}
	{ifin}{cmd:, {opth media(string)} {opth enumerator(varname)} {opth outcome(varname)}} [{opth save(string)} {opth starttime(varname)} {opth type(string)} ]


	{* Using -help bcstats- as a template.}{...}
	{synoptset 23 tabbed}{...}
	{synopthdr}
	{synoptline}
	{p2coldent:* {opth media(string)}}file path to folder containing text audit csv files (automatically named "media" by SurveyCTO){p_end}
	{p2coldent:* {opth enumerator(varname)}}name of variable identifying enumerator who conducted survey{p_end}
	{p2coldent:* {opth outcome(varname)}}name of variable identifying survey outcome (for example, success or refusal){p_end}
	{p2coldent:* {opth save(string)}}(optional) file path to folder where graphs should be saved (in pdf format){p_end}
	{p2coldent:* {opth starttime(varname)}}(optional) name of variable identifying the survey starttime (automatically named starttime by SurveyCTO). If this option is not used, variable name "starttime" will be assumed.{p_end}
	{p2coldent:* {opth type(string)}}(optional) file type of saved graphs. Default is pdf if not specified.{p_end}

	{title:Description}

	{pstd}
	If a "text audit" field is included in a SurveyCTO form, SurveyCTO will generate a csv dataset for each survey conducted that contains detailed information about when individual survey screens were viewed and for how long. This information can be used to build an extremely precise mapping of how enumerators spend their day. This may be particularly useful when conducting remote phone call surveys when most of enumerators' work is done on SurveyCTO (e.g., no physical tracking) and when in-person supervision is not possible. 

	{pstd}
	This command generates graphs showing each enumerator's time use throughout the day. Individual graphs are created for each day when surveys were conducted, but {bf:if} can be used to, for example, limit graphing to the prior day's work. 

