/******************************** Header **********************************\
/*========================================================================*\
|		         Final-term Project for SPS course 2021 fall               |
|		           Due Wednesday, Dec 1st, 2021, midnight                  |
\*========================================================================*/

/*------------------------------------------------------------------------*\
| PROJECT: Final-term project                                              |
|                                                                          |
| MAIN OBJECTIVES:                                                         |
|	1. Report Title, Your name, Date, Dataset name,                        |
|	   Objectives, Methods, and Results;                                   |
|	2. Use the cleaned_data_zhc2006.sas7bdat and                           |
|	   Table1Macro _ZChen -V2.sas SAS Macro to                             |
|	   generate the Table 1-3;                                             |
|	3. Figure out what statistical methods were used                       |
|	   by that Macro to produce the p-values in Table-3;                   |
|	4. Produce the figure “Histogram of Age by EBER”.                      |
|	5. Write the Reference section.                                        |
|                                                                          |
| AUTHOR: Anni Liu (CWID: ali4006)                                         |
|                                                                          |
| LOGS:                                                                    |
|	1. 11/17/2021: Received data and SAS Macro tutorial;                   |  
|	2. 11/28/2021: Modified SAS Macro tutorial;                            |
|	3. 11/29/2021: Produced report using Macro;                            |
|                                                                          |
\*------------------------------------------------------------------------*/

/****************************** End of header *****************************\

/*====== Prepare data ======*/
libname final "/home/u59450843/SAS class 2021 fall
/Final-term project";

data cleaned_data;
/*--- Use the full dataset: ---*/
	set final.cleaned_data_zhc2006;
run;

proc contents data=cleaned_data order=varnum;
run;

proc print data=cleaned_data(obs=30);
run;

/*====== Now use the modified -V2 version ======*/
/*--- Save the Macro to a folder and Compile it ---*/
%include "/home/u59450843/SAS class 2021 fall/Final-term project/
Table1Macro _ZChen -V2.sas";

/*--- Use the ‘jorunal3a’ style ---*/
ods rtf file="/home/u59450843/SAS class 2021 fall/Final-term project/
Final project_ali4006.rtf" bodytitle style=journal3a;
ods escapechar="~";
ods rtf text="~S={font=('arial',12pt,bold) outputwidth=100% just=center}";

/*--- Report title ---*/
ods rtf text="~S={font=('arial',20pt,bold) just=center}
My Final-term project for SPS 2021";
ods rtf text=" ";
ods rtf text=" ";

/*--- Report name and CWID ---*/
ods rtf text="~S={font=('arial',12pt) just=center}
[by: Anni Liu (ali4006)]";

/*--- Report date ---*/
ods rtf text="~S={font=('arial',12pt) color=red just=center}
Last updated on: 30NOV21";
ods rtf text=" ";

/*--- Report dataset name ---*/
ods rtf text="~S={font=('arial', 16pt, bold) just=left}
Dataset: ~S={font=('arial', 12pt) color = red just=left} 
Cleaned_data_zhc2006 SAS dataset from Mid-term project.";
ods rtf text=" ";

/*--- Report objectives ---*/
ods rtf text="~S={font=('arial', 16pt, bold) just=left}
Objectives: ~S={font=('arial', 12pt) just=left} 
Bivariate association with EBER;";
ods rtf text=" ";

/*--- Report methods ---*/
ods rtf text="~S={font=('arial', 16pt, bold) just=left}
Methods: ~S={font=('arial', 12pt, italic) color = red just=left} 
[in Table-3, two independent sample T-test was used to obtain the 
p-values of continuous variables Age, Overall Survival (months), 
and Progression-free Survival (months) between positive EBER group 
and negative EBER group; Chi-square test was used to obtain the 
p-values of categorical variables Age_group, Sex, COO, Parenchyma_sites, 
and cMyc between positive EBER group and negative EBER group; Fisher’s 
Exact test was used to obtain the p-values of categorical variables 
Prior_or_concurrent_cancers, PTLD, and Histology between positive EBER 
group and negative EBER group];";
ods rtf text=" ";

/*--- Report results ---*/
ods rtf text="~S={font=('arial', 16pt, bold) just=left}
Results:";
ods rtf text=" ";

/*--- Table-1: Overall summary only ---*/
ods rtf startpage=now;
%Table1Macro(
	dsn=cleaned_data, 
	tableTitle=Table-1: Overall summary, 

/*--- Use categorical variables shown in the Prof. Chen's example report ---*/
	caList=Age_group Sex Prior_or_concurrent_cancers PTLD Histology 
		   Parenchyma_sites COO cMyc, 
	
/*--- Use continuous variables shown in the Prof. Chen's example report ---*/
	coPList=Age OS_mo PFS_mo, 
	outputOrder=Age Age_group Sex OS_mo PFS_mo Prior_or_concurrent_cancers 
				PTLD Histology Parenchyma_sites COO cMyc, 
	overall=yes, 
	variableShading=no, 
	caIncludeMissing=yes, 
	missingPercent=yes, 
	missingTop=no, 
	noTest=yes);

/*--- Table-2: Stratified by EBER and overall column but without p-values---*/
ods rtf startpage=now;
ods rtf text=" ";
ods rtf text=" ";
ods rtf text=" ";
ods rtf text=" ";
%Table1Macro(
	dsn=cleaned_data, 
	tableTitle=Table-2: Stratified by EBER and with overall but without p-values,

/*--- Use categorical variables shown in the Prof. Chen's example report ---*/
	caList=Age_group Sex Prior_or_concurrent_cancers PTLD Histology COO cMyc, 
	
/*--- Use continuous variables shown in the Prof. Chen's example report ---*/
	coPList=Age OS_mo PFS_mo, 
	group=EBER, 
	outputOrder=Age Age_group Sex OS_mo PFS_mo Prior_or_concurrent_cancers 
				PTLD Histology COO cMyc, 
	overall=yes, 
	orientation=portrait, 
	variableShading=no, 
	caIncludeMissing=yes, 
	missingPercent=yes, 
	missingTop=no, 
	noTest=yes);

/*--- Table-3: Stratified by Sex and with overall column and p-values ---*/
ods rtf startpage=now;
ods rtf text=" ";
ods rtf text=" ";
ods rtf text=" ";
ods rtf text=" ";
ods rtf text=" ";
%Table1Macro(
	dsn=cleaned_data, tableTitle=Table-3: Stratified by EBER and with overall column and p-values, 
	
/*--- Use categorical variables shown in the Prof. Chen's example report ---*/
	caList=Age_group Sex Prior_or_concurrent_cancers PTLD Histology COO 
		   Parenchyma_sites cMyc, 
		   
/*--- Use continuous variables shown in the Prof. Chen's example report ---*/
/*--- Only use parametric tests for these variables ---*/
	coPList=Age OS_mo PFS_mo, 
	group=EBER, 
	outputOrder=Age Age_group Sex OS_mo PFS_mo Prior_or_concurrent_cancers 
				PTLD Histology COO Parenchyma_sites cMyc, 
	overall=yes, 
	orientation=portrait, 
	variableShading=no, 
	caIncludeMissing=yes, 
	missingPercent=yes, 
	missingTop=no);

/* Notes:
1. <<coPList>> indicates p values for continuous variables
between two groups are obtained from T-TEST.
2. <<labelvariable = yes>> (not shown in above codes) indicates if p values for categorical
variables are obtained from FISHER’S EXACT TEST.*/

/*--- Make a figure: Histogram of Age by EBER ---*/
ods rtf startpage=now;
ods rtf text=" ";
ods rtf text=" ";
ods rtf text=" ";
ods rtf text=" ";
ods rtf text=" ";
ods rtf text="~S={font=('arial', 14pt, bold) just=left}
Histogram of Age by EBER";
ods rtf text=" ";
ods rtf text=" ";
ods rtf text=" ";
ods rtf text=" ";
ods graphics on / imagefmt=png;

/*--- Set figure resolution as 300 dpi ---*/
ods rtf image_dpi=300;

/*--- Delete title "The UNIVARIATE Procedure" ---*/
ods noproctitle;

proc univariate data=cleaned_data;
	class EBER;
	var Age;
	
/*--- Individualize histogram to resemble the Prof. Chen's example report ---*/
	histogram Age / nrows=2 vaxis=0 to 50 by 10;
	ods select histogram;
run;

/*--- Report references ---*/
ods rtf startpage=now;
ods rtf text=" ";
ods rtf text=" ";
ods rtf text=" ";
ods rtf text=" ";
ods rtf text="~S={font=('arial', 16pt, bold) just=left} 
References:";
ods rtf text=" ";
ods rtf text="~S={font=('arial', 12pt) just=left}
1. Geliang Gan. Create publication-ready variable summary table using SAS® macro. PharmaSUG 2019 - Paper BP-175.";

/*--- End the report ---*/
ods rtf close;
title;
footnote;

/*========================= End of the document ========================*/