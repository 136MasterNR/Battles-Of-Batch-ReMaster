IF NOT EXIST "%APPDATA%\HTS_DATA\BattlesOfBatch\main.config" (
	BREAK>"%APPDATA%\HTS_DATA\BattlesOfBatch\main.config"
)

CALL :%*
EXIT /B 0


:READ
FOR /F "TOKENS=*DELIMS=" %%1 IN ('TYPE "%APPDATA%\HTS_DATA\BattlesOfBatch\main.config"') DO (
	SET %%1
)
EXIT /B 0


:WRITE
BREAK>"%APPDATA%\HTS_DATA\BattlesOfBatch\main.config.new"

FOR /F "TOKENS=1,*DELIMS==" %%1 IN ('SET Config.') DO (
	ECHO.%%1=%%2>>"%APPDATA%\HTS_DATA\BattlesOfBatch\main.config.new"
)

MOVE /Y "%APPDATA%\HTS_DATA\BattlesOfBatch\main.config.new" "%APPDATA%\HTS_DATA\BattlesOfBatch\main.config">NUL

EXIT /B 0
