IF "%1"=="ALL" (
	FOR %%I IN (
		Items
		Weapons
		Quests
		Map
	) DO CALL :INIT %%I
	EXIT /B 0
)

:INIT
SET $.CATEGORY=
SET $.CNT=0
SET $.NAME=%~n1

FOR /F "TOKENS=1,*DELIMS=]=" %%1 IN ('TYPE "!RAW!\%1.ini"') DO (
	SET $.VAR=%%1
	IF "!$.VAR:~0,1!"=="[" (
		SET $.CATEGORY=!$.VAR:~1!
		SET /A $.CNT+=1
		SET ID[!$.NAME:~0,1!]!$.CATEGORY!=!$.CNT!
		SET !$.NAME:~0,1!.Name[!$.CNT!]=!$.CATEGORY!
	) ELSE (
		SET !$.NAME:~0,1!.%%1[!$.CNT!]=%%2
	)
)

FOR /F "TOKENS=1DELIMS==" %%1 IN ('SET $.') DO SET "%%1="

EXIT /B 0
