/* Pointers */
LIBNAME Data '~/MySASData';

/* Data Import ------------------------------------------------------------- */
/* Raw Data saved in RAWData folder as CSV */
/* Smaller Data */
PROC IMPORT DATAFILE='~/RAWData/NBA_19_22_Shots.csv'
	DBMS=CSV 
	OUT=Data.NBAShots
	REPLACE; 
RUN;

/* Larger Data */
PROC IMPORT DATAFILE='~/RAWData/NBA_04_22_Shots.csv'
	DBMS=CSV 
	OUT=Data.NBAShots_Large
	REPLACE; 
RUN;

/* LeBron Subset ------------------------------------------------------------*/
DATA Data.LeBron_Shots_Career;
	SET Data.NBASHOTS_Large;
	WHERE namePlayer = "LeBron James";
RUN;

DATA Data.LeBron_Shots_LAL;
	SET Data.NBASHOTS;
	WHERE namePlayer = "LeBron James";
RUN;

/* LeBron 57 pts (11/3/2017) ------------------------------------------------*/
DATA Data.LeBron_Cavs_High;
	SET Data.LeBron_Shots_Career;
	WHERE dateGame = 20171103;
RUN;

/*export data to file called LeBron.csv*/
PROC EXPORT DATA=Data.LeBron_Cavs_High
    OUTFILE="~/RAWData/LeBron.csv"
    DBMS=CSV
    REPLACE;
RUN;
		  
/* 2015-16 Season ------------------------------------------------------------*/
DATA Data.NBA_2016;
	SET Data.NBASHOTS_Large;
	WHERE slugSeason = "2015-16";
RUN;

/*export data to file called data.csv*/
PROC EXPORT DATA=Data.NBA_2016
    OUTFILE="~/RAWData/NBA16.csv"
    DBMS=CSV
    REPLACE;
RUN;
