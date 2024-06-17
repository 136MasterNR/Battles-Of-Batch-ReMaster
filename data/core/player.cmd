SET "$.SAVPATH=%APPDATA%\HTS_DATA\BattlesOfBatch\Wanderer"
IF NOT EXIST "!SAVPATH!" MD "!SAVPATH!"
CALL :%*

:: Clear all Temporary Variables
FOR /F "TOKENS=1DELIMS==" %%1 IN ('SET $.') DO SET "%%1="
EXIT /B 0


:SAVE
SET $.NAME=%1
SET $.SEARCH=
SET W.Level[1]=1

IF /I !$.NAME!==Weapons SET $.SEARCH=W.Level
IF /I !$.NAME!==Items SET $.SEARCH=I.Owned
IF /I !$.NAME!==Materials SET $.SEARCH=M.Owned
IF /I !$.NAME!==Quests SET $.SEARCH=Q.Progress
IF /I !$.NAME!==Player SET $.SEARCH=P.

BREAK>"!$.SAVPATH!\weapons.new"

FOR /F "TOKENS=1,*DELIMS=" %%1 IN ('SET !$.SEARCH!') DO (
	ECHO;%%1
)>>"!$.SAVPATH!\!$.NAME!.new"

MOVE /Y "!$.SAVPATH!\!$.NAME!.new" "!$.SAVPATH!\!$.NAME!.sav"

EXIT /B 0


:LOAD
SET $.NAME=%1

FOR /F "TOKENS=*DELIMS=" %%1 IN ('TYPE "!$.SAVPATH!\!$.NAME!.sav"') DO (
	SET %%1
)

EXIT /B 0


:STATS
SET S.Level=0

FOR /F "TOKENS=*DELIMS=" %%1 IN ('TYPE "!RAW!\Levels.txt"') DO (
	IF !P.Exp! GEQ %%1 SET /A S.Level+=1
)

FOR /F "TOKENS=*DELIMS=" %%1 IN ('TYPE "!RAW!\BaseStats.txt"') DO (
	SET %%1
)

EXIT /B 0


:INIT
:: Make sure save files are not missing
FOR %%I IN (
	Player.sav
	Items.sav
	Weapons.sav
	Materials.sav
	Equipped.sav
	Quests.sav
) DO IF NOT EXIST "!$.SAVPATH!\%%I" BREAK>"!$.SAVPATH!\%%I"

:: Fetch data from each save file
FOR %%I IN (
	Player
	Items
	Weapons
	Materials
	Quests
) DO CALL :LOAD %%I

IF NOT DEFINED P.Money SET P.Money=0
IF NOT DEFINED P.Exp SET P.Exp=0
IF NOT DEFINED P.WorldLvl SET p.WorldLvl=1

:: Calculate stats for the player, such as level, strength, defence, etc.
CALL :STATS

EXIT /B 0
