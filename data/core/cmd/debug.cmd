@ECHO OFF

SET ARGS=%*

:: Manual call handlers
IF DEFINED ARGS (
	IF /I %ARGS%.==LOG. START "" "%~dpfx0" __LIVE&EXIT /B
	IF %ARGS%.==__LIVE. GOTO :live
)

:: Automatic calls handler
IF DEFINED ARGS (
	CLS
	CALL :%ARGS%
	EXIT /B 0
)

IF NOT DEFINED DM (
	ECHO.There was an error.
	EXIT /B 0
)

IF EXIST "%DM%\LET.DEBUG" (DEL "%DM%\LET.DEBUG"&&ECHO.Debug mode disabled.&SET "DEBUG.MODE=") ELSE ECHO.>"%DM%\LET.DEBUG"&&ECHO.Debug mode enabled.&SET "DEBUG.MODE=TRUE"
ECHO ON
@EXIT /B 0





:wscript <[RAW]>
IF /I NOT %1.==RAW. (
	ECHO.[H-----------------------------------------------------------------------------
	FOR /F "TOKENS=1,9DELIMS=," %%1 IN ('TASKLIST /V /FO CSV ^| FINDSTR /C:"wscript"') DO (
		ECHO.Process: %%1
		ECHO.[1A[34CTitle: %%2
		ECHO.-----------------------------------------------------------------------------
	)
) ELSE (
	ECHO.[H
	TASKLIST /V /FO CSV | FINDSTR /C:"wscript"
)

GOTO wscript





:choice <[RAW]>
SETLOCAL ENABLEDELAYEDEXPANSION
CALL CHOICE
ECHO.!KEY!
ECHO.!KEY! | CLIP
IF !KEY!.==TIMEOUT. (ENDLOCAL&EXIT /B 0)
ENDLOCAL

GOTO choice





:live
SET "logFile=%DATA%\logs.txt"

SET OZ=0
SET CONN_TRUE=1
SET CONN_FALSE=1

MODE CON:COLS=60 LINES=40

:LOGEXIST
IF NOT EXIST "%logFile%" (
	TITLE Waiting for log ... ^(%TIME%^)
	TIMEOUT /T 1 1>NUL 2>NUL >NUL
	GOTO LOGEXIST
)
TITLE Now Live Logging - %logFile%

:REPEAT
IF NOT EXIST "%logFile%" (
    ECHO.[0;1mERROR: The log file was not found.
	PAUSE>NUL&EXIT
) 1>NUL 2>NUL >NUL

COPY "%logFile%" ".\logLogger.txt" >NUL
IF NOT EXIST "%logFile%" ECHO.WHAT
FOR /F %%A IN (".\logLogger.txt") DO SET Z=%%~zA

TIMEOUT /T 1 >NUL

IF %OZ%==%Z% GOTO :REPEAT

SET OZ=%Z%
CLS
TYPE .\logLogger.txt
TITLE Now Live Logging - %logFile%

GOTO :REPEAT
