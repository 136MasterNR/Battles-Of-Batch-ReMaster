IF "%1"=="ALL" (
	REM CALL :INIT Items
	REM CALL :INIT Weapons
	CALL :INIT Quests
	CALL :INIT Map Map
	EXIT /B 0
)


:INIT
SET $.NAME=%1
SET $.SUFFIX=%2

IF NOT DEFINED $.SUFFIX SET $.SUFFIX=!$.NAME:~0,1!

SET $.CATEGORY=
SET $.CNT=0

FOR /F "USEBACKQ TOKENS=1,*DELIMS=]=" %%1 IN ("!RAW!\!$.NAME!.ini") DO (
	SET $.VAR=%%1
	IF "!$.VAR:~0,1!"=="[" (
		SET $.CATEGORY=!$.VAR:~1!
		SET /A $.CNT+=1
		SET ID[!$.SUFFIX!]!$.CATEGORY!=!$.CNT!
		SET !$.SUFFIX!.Name[!$.CNT!]=!$.CATEGORY!
	) ELSE (
		SET !$.SUFFIX!.%%1[!$.CNT!]=%%2
	)
)

EXIT /B 0
