/* import the 'Raw data'; create a raw SAS dataset */
filename inXlsx "/home/u59450843
/SAS class 2021 fall/Mid-term project
/PCNSL Final Data and Instruction _for Mid-term project 2021.xlsx";

proc IMPORT 
	datafile = inXlsx
	out = raw_SAS_dataset replace
	dbms = xlsx;
range = "Raw data$A2:AR447";
run;

proc contents data = raw_SAS_dataset order = varnum;
run;

proc print data = raw_SAS_dataset style = {asis = on};
run; 

/* create a clean SAS dataset */
libname midterm "/home/u59450843/SAS class 2021 fall
/Mid-term project"; 
data midterm.clean_SAS_dataset 
(   /* drop intermediate variables */
	drop = ECOG_PG_char 
		   cMyc_num 
		   BCL2_num 
		   BCL2_Fish_num
	       BCL6_num
		   MUM1_num
		   CD5_num
		   CD20_num
		   EBER_num
		   OS_event_char
    /* keep new variables */
	keep = Patient_ID 
		   Age 
		   Date_of_Dx
		   Sex
		   ECOG_PG
		   Prior_or_concurrent_cancers
		   Solid_organ_transplant
		   Allogeneic_stem_cell
		   Immunosuppressors
		   PTLD
		   Histology
		   COO
		   cMyc
		   BCL2
		   cMyc_Fish
		   BCL2_Fish
		   BCL6
		   MUM1
		   CD5
		   CD10
		   CD20
		   EBER
		   Brain_parenchyma
		   Parenchyma_sites
		   CSF
		   Spinal_cord
		   Eye
		   Relapse
		   OS_event
		   PFS_mo
		   OS_mo
		   Age_group
		   Days_to_end);
		   
	set raw_SAS_dataset (
	    /* drop original variables */
		drop = "If on immunosuppressors, please"n
			   "If PTLD, 1=monomorphic, 2=polymo"n
			   "If other, specify"n
			   "Ki67 (%)"n
			   "EBV PCR serum (1=Pos, 2=Neg, 3=U"n
			   "If pos, viral load"n
			   "EBV PCR CSF (1=Pos, 2=Neg, 3=Unk"n
			   "if pos, viral load_1"n
			   "Specify parenchyma locations (1="n
			   "If YES relapse or refractory, li"n
			   "Date of last follow-up (2 digit"n
			   "If applicable, date of death (2"n
			   "Lenth of Followup (mos)"n);					 

    /* set length of new and intermediate variables */	
	length Patient_ID $9 Age 3 Date_of_Dx 8 ECOG_PG_char $1 
		   Sex $1 ECOG_PG 8 Prior_or_concurrent_cancers $180 
		   Solid_organ_transplant $99 Allogeneic_stem_cell $1
		   Immunosuppressors $44 PTLD $7 Histology $83 COO $9
		   cMyc_num 3 cMyc $9 BCL2_num 3 BCL2 $9 cMyc_Fish $1
		   BCL2_Fish_num 3 BCL2_Fish $1 BCL6_num 3 BCL6 $3 
		   MUM1_num 3 MUM1 $3 CD5_num 3 CD5 $3 CD10 $3 CD20_num 3 
		   CD20 $3 EBER_num 3 EBER $3 Brain_parenchyma $1
		   Parenchyma_sites $20 CSF $1 Spinal_cord $1 Eye $1
		   Relapse $3 OS_event_char $1 OS_event 3 PFS_mo 3 OS_mo 8
		   Age_group $9 Days_to_end 3;
		   
/* set format */
	format "CMYC >40% by IHC (1=y, 2=n, 3=un"n 1. 
		   "BCL2-positive >50% by IHC (1=y,"n 1.
		   "BCL2 translocated by FISH (1=y,"n 1.
	       "BCL6 IHC (1=Pos, 2=Neg, 3=Unk)"n 1.
	       "MUM1 (1=Pos, 2=Neg, 3=Unk)"n 1.
	       "CD5 (1=Pos, 2=Neg, 3=Unk)"n 1.
	       "CD20  positive (1=Pos, 2=Neg, 3="n 1.
	       "EBER (1=Pos, 2=Neg, 3=Unk)"n 1.;
		   
		   
/* rename variables */	
	Patient_ID = "Patient ID"n;
	Age = "Age at Diagnosis (yrs)"n;
	Date_of_Dx = "Date of Diagnosis (2 digit month"n;
	Sex = "Sex (M/F)"n;
	ECOG_PG_char = "ECOG PS (0-4, or U for unknown)"n;
	Prior_or_concurrent_cancers = "Any prior or concurrent cancers"n;
	Solid_organ_transplant = "History of solid organ transplan"n; 
	Allogeneic_stem_cell = "History of allogeneic stem cell"n;
	Immunosuppressors = "On Immunosuppressors? (Y/N/Unk)"n;
	PTLD = "Classified as PTLD (Y/N)"n;
	Histology = "Histology (1=DLBCL, 2=MZL, 3=oth"n;
	COO = "If DLBCL, COO (1=Germinal Center"n;
	cMyc_num = "CMYC >40% by IHC (1=y, 2=n, 3=un"n;
	BCL2_num = "BCL2-positive >50% by IHC (1=y,"n;
	cMyc_Fish = "CMYC FISH translocated (1=y, 2=n"n;
	BCL2_Fish_num = "BCL2 translocated by FISH (1=y,"n;
	BCL6_num = "BCL6 IHC (1=Pos, 2=Neg, 3=Unk)"n;
	MUM1_num = "MUM1 (1=Pos, 2=Neg, 3=Unk)"n;
	CD5_num = "CD5 (1=Pos, 2=Neg, 3=Unk)"n;
	CD10 = "CD10 (1=Pos, 2=Neg, 3=Unk)"n;
	CD20_num = "CD20  positive (1=Pos, 2=Neg, 3="n;
	EBER_num = "EBER (1=Pos, 2=Neg, 3=Unk)"n;
	Brain_parenchyma = "Brain parenchyma involved (Y/N/)"n;
	Parenchyma_sites = "If parenchyma involved,  1= sing"n;
	CSF = "CSF involved (Y/N/Unknown)"n;
	Spinal_cord = "Spinal cord involved (Y/N/Unknow"n;
	Eye = "Eyes involved (Y/N/Unknown or un"n; 
	Relapse = "Did patient relapse after (or re"n; 
	OS_event_char = "Patient alive (Y/N)"n;
	PFS_mo = "PFS (mos)"n;
	OS_mo = "OS (mos)"n;

/* recode variables */
/* sex */	
	if strip(Sex) in ("m", "M", "f", "F")
		then Sex = upcase(strip(Sex));
	else Sex = "";
/* ECOG_PG */
	if upcase(ECOG_PG_char) = "U"
		then ECOG_PG_char = '';
	ECOG_PG = input(ECOG_PG_char, 8.);
/* Prior_or_concurrent_cancers */
	if upcase(Prior_or_concurrent_cancers) = "U"
		then Prior_or_concurrent_cancers = "";
	else Prior_or_concurrent_cancers = upcase(substr(Prior_or_concurrent_cancers, 1, 1));
/* Solid_organ_transplant */	
	Solid_organ_transplant = upcase(substr(Solid_organ_transplant, 1, 1));
/* Allogeneic_stem_cell */	
	Allogeneic_stem_cell = upcase(substr(Allogeneic_stem_cell, 1, 1));
/* Immunosuppressors */	
	Immunosuppressors = upcase(substr(Immunosuppressors, 1, 1));
	if Immunosuppressors = ""
		then Immunosuppressors = "U";
/* PTLD */	
	PTLD = upcase(PTLD);
/* Histology */	
	Histology = substr(Histology, 1, 1);
	if upcase(Histology) = "U"
		then Histology = "";
	else if Histology = "1"
		then Histology = "DLBCL";
	else if Histology = "2"
		then Histology = "MZL";
	else if Histology = "3"
		then Histology = "Other";
/* COO */	
	if upcase(COO) = "U"
		then COO = "3_Other";	
	else if COO = "1"
		then COO = "1_GC";
	else if COO = "2"
		then COO = "2_non-GC";
	else if COO = "3"
		then COO = "3_Other";
/* cMyc */
	if cMyc_num = 1
		then cMyc = ">40%";
	else if cMyc_num = 2
		then cMyc = "≤40%";
	else if cMyc_num = 3
		then cMyc = "";
/* BCL2 */
	if BCL2_num = 1
		then BCL2 = ">50%";
	else if BCL2_num = 2
		then BCL2 = "≤50%";
	else if BCL2_num = 3
		then BCL2 = "";	
/* cMyc_Fish */
	if cMyc_Fish = "1"
		then cMyc_Fish = "Y";
	else if strip(cMyc_Fish) in ("2", "N")
		then cMyc_Fish = "N";
	else if cMyc_Fish = "3"
		then cMyc_Fish = "";	
/* BCL2_Fish */
	if BCL2_Fish_num = 1
		then BCL2_Fish = "Y";
	else if BCL2_Fish_num = 2
		then BCL2_Fish = "N";
	else if BCL2_Fish_num = 3
		then BCL2_Fish = "";		
/* BCL6 */
	if BCL6_num = 1
		then BCL6 = "Pos";
	else if BCL6_num = 2
		then BCL6 = "Neg";
	else if BCL6_num = 3
		then BCL6 = "";
/* MUM1 */
	if MUM1_num = 1
		then MUM1 = "Pos";
	else if MUM1_num = 2
		then MUM1 = "Neg";
	else if MUM1_num = 3
		then MUM1 = "";	
/* CD5 */
	if CD5_num = 1
		then CD5 = "Pos";
	else if CD5_num = 2
		then CD5 = "Neg";
	else if CD5_num = 3
		then CD5 = "";			
/* CD10 */
	if CD10 = "1"
		then CD10 = "Pos";
	else if strip(CD10) in ("2", "N")
		then CD10 = "Neg";
	else if strip(CD10) in ("3", "M")
		then CD10 = "";
/* CD20 */
	if CD20_num = 1
		then CD20 = "Pos";
	else if CD20_num = 2
		then CD20 = "Neg";
	else if CD20_num = 3
		then CD20 = "";
/* EBER */
	if EBER_num = 1
		then EBER = "Pos";
	else if EBER_num = 2
		then EBER = "Neg";
	else if EBER_num = 3
		then EBER = "";
/* Brain_parenchyma */
    Brain_parenchyma = upcase(Brain_parenchyma);
	if Brain_parenchyma = "U"
		then Brain_parenchyma = "";		
/* Parenchyma_sites */
	if Parenchyma_sites = "1"
		then Parenchyma_sites = "Single site";
	else if Parenchyma_sites = "2"
		then Parenchyma_sites = ">Single site";
	else if Parenchyma_sites = "U"
		then Parenchyma_sites = "";
/* CSF */
    CSF = upcase(CSF);
	if strip(CSF) in ("M", 'U')
		then CSF = "";
/* Spinal_cord */
	Spinal_cord = upcase(Spinal_cord);
	if Spinal_cord = "2"
		then Spinal_cord = "N";
	else if Spinal_cord = "U"
		then Spinal_cord = "";
/* Eye */
	Eye = upcase(Eye);
	if Eye = "2"
		then Eye = "N";
	else if Eye = "U"
		then Eye = "";
/* Relapse */
	Relapse = upcase(Relapse);
	if strip(Relapse) in ("NA", "N/A", "U")
		then Relapse = "";
/* OS_event */
	if upcase(OS_event_char) = "Y"
		then OS_event = 1;
	if upcase(OS_event_char) = "N"
		then OS_event = 0;

/* label variables */	
	label Patient_ID = "Patient ID" 
		  Date_of_Dx = "Date of Dx"
		  ECOG_PG = "ECOG Performance"
		  OS_event = "Overall Survival Event"
		  PFS_mo = "Progression-free Survival (months)"
		  OS_mo = "Overall Survival (months)";
		  
/* create variables */
	if Age =. then Age_group = "";
	else if Age < 18 then Age_group = '< 18';
	else if 18 <= Age < 65 then Age_group = '18 - 65';
	else if Age >= 65 then Age_group = '>= 65';
	day_end = "15Oct2021";
	Days_to_end = input(day_end, date9.) - Date_of_Dx + 1;
run;

proc contents data = midterm.clean_SAS_dataset 
			  order = varnum;
run;

proc print data = midterm.clean_SAS_dataset;
run;

/* check quality of data cleaning */
/* not very good approach */
proc print data = midterm.clean_SAS_dataset;
	var CD20;
run;

/* check character variables */
proc freq data = midterm.clean_SAS_dataset nlevels;
	table Patient_ID Sex Prior_or_concurrent_cancers
		  Solid_organ_transplant Allogeneic_stem_cell
		  Immunosuppressors PTLD Histology COO cMyc
		  BCL2 cMyc_Fish BCL2_Fish BCL6 MUM1 CD5 CD10
		  CD20 EBER Brain_parenchyma Parenchyma_sites
		  CSF Spinal_cord Eye Relapse Age_group;
run;

/* check numerical variables */
proc univariate data = midterm.clean_SAS_dataset;
	var Age Date_of_Dx ECOG_PG OS_event PFS_mo OS_mo Days_to_end;
run;

/* run Macro */
%include "/home/u59450843/SAS class 2021 fall/Mid-term project/
Data info and summary macro - V4 (for SPS course 2021).sas";
%DataInfo ( 
    /* summarize new variables in 'New column name' column */
	Dataset = midterm.clean_SAS_dataset(drop = Age_group Days_to_end),
    out = "/home/u59450843/SAS class 2021 fall/Mid-term project/
Sumamry of cleaned data_ali4006.rtf");
