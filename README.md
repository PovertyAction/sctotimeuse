# sctotimeuse
Stata command to graph enumerator productivity using question-level timestamps captured using SurveyCTO's text_audit feature 

Author:
William Blackmon

To install: 

```
net install sctotimeuse, from("https://raw.githubusercontent.com/PovertyAction/sctotimeuse/master") replace
```

Help file: 
<pre>
                <b><u>Title</u></b>
<p>
        
    <b>sctotimeuse</b> -- Graph enumerator productivity using question-level
        timestamps captured using SurveyCTO's text_audit feature.
<p>
<a name="syntax"></a>        
        <b><u>Syntax</u></b>
<p>
        
        <b>sctotimeuse</b> [<i>if</i>] [<i>in</i>]<b>, media(</b><i>string</i><b>) enumerator(</b><i>varname</i><b>) outcome(</b>
          <i>varname</i><b>)</b> [<b>save(</b><i>string</i><b>)</b> <b>starttime(</b><i>varname</i><b>)</b> <b>text_audit(</b><i>varname</i><b>)</b>]
<p>
<p>
                            <i>options</i>                  Description
            -----------------------------------------------------------------
        
    * <b>media(</b><i>string</i><b>)</b>          file path to folder containing text audit csv
                               files (automatically named "media" by
                               SurveyCTO)
        
    * <b>enumerator(</b><i>varname</i><b>)</b>    name of variable identifying enumerator who
                               conducted survey
        
    * <b>outcome(</b><i>varname</i><b>)</b>       name of variable identifying survey outcome (for
                               example, success or refusal)
        
    * <b>save(</b><i>string</i><b>)</b>           (optional) file path to folder where graphs
                               should be saved (in pdf format)
        
    * <b>starttime(</b><i>varname</i><b>)</b>     (optional) name of variable identifying the
                               survey starttime (automatically named
                               starttime by SurveyCTO). If this option is not
                               used, variable name "starttime" will be
                               assumed.
<p>
        <b><u>Description</u></b>
<p>
        
    If a "text audit" field is included in a SurveyCTO form, SurveyCTO will
    generate a csv dataset for each survey conducted that contains detailed
    information about when individual survey screens were viewed and for how
    long. This information can be used to build an extremely precise mapping
    of how enumerators spend their day. This may be particularly useful when
    conducting remote phone call surveys when most of enumerators' work is
    done on SurveyCTO (e.g., no physical tracking) and when in-person
    supervision is not possible.
<p>
        
    This command generates graphs showing each enumerator's time use
    throughout the day. Individual graphs are created for each day when
    surveys were conducted, but <b>if</b> can be used to, for example, limit
    graphing to the prior day's work.
<p>
</pre>
