/*problem 1 part a*/
filename reffile '/home/u63613043/titanic.csv';

proc import datafile=reffile dbms=csv out=work.import replace;
	getnames=yes;
run;

proc contents data=work.import;
run;

libname mylib "/home/u63613043/mylib";

data mylib.titanic;
	set work.import;
run;

/* part b */
proc sql;
	select Total_Observations, Total_Variables from
		(select count(*) as Total_Observations from mylib.titanic) as 
		Total_Observations, (select count(distinct name) as Total_Variables from 
		dictionary.columns where libname="MYLIB" and memname="TITANIC") as 
		Total_Variables;
quit;

/* part c */
proc sql;
	select name as Variable_Name,
		type as Data_Type,
		length as Variable_Length,
		format as Variable_Format,
		label as Variable_Label
	from dictionary.columns
	where libname = 'MYLIB' and memname = 'TITANIC';
quit;

/* part d */
data _null_;
    set sashelp.vcolumn end = last;
    where libname = 'MYLIB' and memname = 'TITANIC';
    if type='num' then numeric_count+1;
    else if type = 'char' then character_count+1;

    if last then do;	
    	file print;
        put "Numeric Variables = " numeric_count;
        put "Character Variables = " character_count;
    end;
run;

/* Problem 2 */
libname myfmt "/home/u63613043/myfmt";
proc format library=myfmt;
	value pclassf
		1 = 'Upper Class'
        2 = 'Middle Class'
        3 = 'Lower Class'
        other = 'Unknown'
    ;
    value $embarkf
        'C' = 'Cherbourg'
        'Q' = 'Queenstown'
        'S' = 'Southampton'
        other = 'Unknown'
    ;
run;
options fmtsearch=(myfmt);

/* Problem 3 */
options fmtsearch=(myfmt);

proc sort data = mylib.titanic out = work.titanic_sorted;
	by Pclass;
run;

data work.death_count;
	set work.titanic_sorted;
	by Pclass;
	retain Deaths 0;
	
	if first.Pclass then Deaths = 0;
	if Survived = 0 then Deaths +1;
	if last.Pclass then output;
	
	keep Pclass Deaths;
run;

proc print data = work.death_count noobs label;
	var Pclass Deaths;
	format Pclass pclassf.;
	
	label Pclass = "Passenger Class"
		Deaths = "Number of Deaths";
		
	title "Number of Deaths by Passenger Class";
run;

/* Problem 4 */






