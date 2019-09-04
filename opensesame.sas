libname pathFile 'C:\Dev\SAS_Load_Fail';
proc contents data='tbldatresp.sas7bdat';
option nofmterr;
run;

proc export data=pathFile.tbldatresp /* Rename the data= statement to include your Library.Dataset*/
outfile='C:\Dev\SAS_Load_Fail\table1.csv'
dbms=csv replace;
run;

data tbldatresp;
infile 'table1.csv' dsd truncover;
run;

* proc export 
*   data=pathFile.tbldatresp
*   dbms=xlsx
*   outfile="C:\temp\myfile.xlsx"
*   replace;
* run;