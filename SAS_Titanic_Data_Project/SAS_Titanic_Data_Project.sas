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
options fmtsearch = (myfmt);

proc sql;
	select pclass format = pclassf. as Passenger_Class,
		count(*) as Number_of_Passengers,
		sum (case when Survived = 0 then 1 else 0 end) as Number_of_Deaths,
		(calculated Number_of_Deaths / calculated Number_of_Passengers) * 1000
			as Deaths_per_1000
	from mylib.titanic
	group by pclass
	;
quit;

/* Part 2 Problem 5 */
proc means data=sashelp.class noprint;
	var weight;
	output out = stats mean = mean_weight;
run;

data work.class_new;
	if _n_ = 1 then set stats;
	set sashelp.class;
	Weight_minus_MeanWeight = weight - mean_weight;
	drop _type_ _freq_;
run;

proc print data = work.class_new noobs;
	title "SASHELP.CLASS with Weight_minus_MeanWeight";
run;

/* Problem 6 */
data membership;
	infile datalines dsd truncover;
	length Member_ID $9 Gender $1;
	input Member_ID : $9.
		BeginEnroll : ?? date9.
		EndEnroll : ?? date9.
		DOB : ?? date9.
		Gender : $1.;
	format BeginEnroll EndEnroll DOB date9.;
datalines;
M00008501,5FEB2013,31Dec2013,14May1930, M
M00008502,30FEB2013,31Dec2013, 24May1930, F
M00008503,15JUL2013,31Nov2013,30Feb1930, F
M00008504,25AUG2013,31Dec2013,14May1930, M
M00008505,27EB2013,31Dec2013,14May1930, F
;
run;

proc print data = membership noobs;
	title "Membership Data Listing";
run;