SET "$.SAVPATH=%APPDATA%\HTS_DATA\BattlesOfBatch"

IF NOT DEFINED Config.Profile (
	SET Config.Profile=Wanderer
	CALL CONFIG WRITE
)

IF NOT EXIST "!$.SAVPATH!\!Config.Profile!" MD "!$.SAVPATH!\!Config.Profile!"
CALL :%*

:: Clear all Temporary Variables
FOR /F "TOKENS=1DELIMS==" %%1 IN ('SET $.') DO SET "%%1="
EXIT /B 0


:SAVE
SET $.FILE=%1
SET $.SEARCH=%2

BREAK>"!$.SAVPATH!\!Config.Profile!\!$.FILE!.new"

FOR /F "TOKENS=1,*DELIMS=" %%1 IN ('SET !$.SEARCH!.') DO (
	ECHO;%%1
)>>"!$.SAVPATH!\!Config.Profile!\!$.FILE!.new"

MOVE /Y "!$.SAVPATH!\!Config.Profile!\!$.FILE!.new" "!$.SAVPATH!\!Config.Profile!\!$.FILE!.sav"

EXIT /B 0


:LOAD
SET $.NAME=%1

FOR /F "USEBACKQ TOKENS=*DELIMS=" %%1 IN ("!$.SAVPATH!\!Config.Profile!\!$.NAME!.sav") DO (
	SET %%1
)

EXIT /B 0


:STATS
SET S.Level=0
SET S.ReqExp=

FOR /F "TOKENS=*DELIMS=" %%1 IN ('TYPE "!RAW!\Levels.txt"') DO (
	IF !P.Exp! GEQ %%1 SET /A S.Level+=1
	IF NOT DEFINED S.ReqExp IF !P.Exp! LSS %%1 SET S.ReqExp=%%1
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
	Equipment.sav
	Materials.sav
	Quests.sav
) DO IF NOT EXIST "!$.SAVPATH!\!Config.Profile!\%%I" BREAK>"!$.SAVPATH!\!Config.Profile!\%%I"

:: Fetch data from each save file
FOR %%I IN (
	Player
	Items
	Weapons
	Equipment
	Materials
	Quests
) DO FOR /F "USEBACKQ TOKENS=*DELIMS=" %%1 IN ("!$.SAVPATH!\!Config.Profile!\%%I.sav") DO SET %%1


IF NOT DEFINED P.Money SET P.Money=0
IF NOT DEFINED P.Exp SET P.Exp=0
IF NOT DEFINED P.WorldLvl SET P.WorldLvl=1

:: Calculate stats for the player, such as level, strength, defence, etc.
CALL :STATS

EXIT /B 0
