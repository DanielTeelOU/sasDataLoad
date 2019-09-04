proc import datafile = 'C:/Users/DanielT/Desktop/SASpractice.xlsx'
    out = practice_activity
    DBMS = xlsx
    replace;
    sheet = "Sheet2"
    GETNAMES=yes;
    MIXED=yes;
run;