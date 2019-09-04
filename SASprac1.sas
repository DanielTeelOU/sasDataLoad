Proc import out=work.sample
		datafile='C:/Users/DanielT/Desktop/SASpractice.xlsx'
		out=PRAC1
		DBMS=EXCEL REPLACE;
		sheet="Sheet2";
	GETNAMES=yes;
	MIXED=yes;
run;

PROC PRINT data=WORK.PRAC1;
run;