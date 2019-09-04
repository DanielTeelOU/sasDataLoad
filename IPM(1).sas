OPTIONS nofmterr mlogic mprint source2 symbolgen LS=250 PS=60 NOCENTER nodate ;  

Proc import out=PRAC
		datafile='C:/Users/DanielT/Desktop/SAS/SASpractice.xlsx'
		DBMS=EXCEL REPLACE;
        SHEET="Sheet2";
	GETNAMES=yes;
	MIXED=no;
    usedate=yes;
    scantime=yes;
run;

%macro renameIt(oldvarlist, newvarlist);
  %let k=1;
  %let old = %scan(&oldvarlist, &k);
  %let new = %scan(&newvarlist, &k);
     %do %while(("&old" NE "") & ("&new" NE ""));
      rename &old = &new;
	  %let k = %eval(&k + 1);
      %let old = %scan(&oldvarlist, &k);
      %let new = %scan(&newvarlist, &k);
  %end;
%mend;

data PRAC;
    set PRAC;
    %renameIt(MODEL_NAME, MODEL)
run;

data PRAC;
    set PRAC;
    if MODEL = 'A5 Sportback' then MODEL = 'Sportback';
run;

data PRAC;
    set PRAC;
    MODEL = UPCASE(SUBSTR(MODEL,1,3));
    if MODEL = 'ATL' then delete;
    length S_Name $100;
    S_Name = catx(' ', FIRST_NAME, LAST_NAME);
run;

PROC FREQ data = PRAC;
    tables MODEL * MODEL_YEAR
    / list missing;
    title 'Customer Analysis';
run;

PROC FREQ data = PRAC;
    tables VIN * EMAIL * MODEL * MODEL_YEAR
    /list missing;
run;

PROC FREQ data = PRAC;
    tables S_Name * MODEL
    / list missing;
run;

data PRAC;
    set PRAC;
    MODEL_YEAR_CHAR = put(MODEL_YEAR, best4.);
    MODEL_YEAR_CHAR = (SUBSTR(1,3));
run;

PROC contents data = PRAC;
run;

PROC FREQ data = PRAC (obs = 100);
    title 'First 100 Records';
    tables VIN * Email * Model * MODEL_YEAR
    /list missing;
run;