@ECHO OFF
CALL :%* 2>NUL || FOR /F "TOKENS=1,2DELIMS==" %%A IN ('SET') DO (
	ECHO.%%A[0m=%%B[0m <NUL > CON
)
@EXIT /B 0

:SIZE
SET>".\MEMORY_OUT.DMP"
FOR %%A IN (".\MEMORY_OUT.DMP") DO ECHO Memory usage is at %%~ZA bytes.
DEL /Q ".\MEMORY_OUT.DMP"
EXIT /B 0

:CLEAR
IF /I %1.==ALL. (
	FOR /F "TOKENS=1DELIMS==" %%A IN ('SET') DO SET "%%A="
)
EXIT /B 0

:GC
IF /I %1.==CLEAR. (
	FOR /F "TOKENS=1DELIMS==" %%A IN ('SET $.') DO SET %%A=
	ECHO.Useless variables have been removed.
	CALL :SAVE
) ELSE (
	FOR /F "TOKENS=1,2DELIMS==" %%A IN ('SET $.') DO (
		ECHO.%%A[0m=%%B[0m <NUL > CON
	)
	IF DEFINED ARG ECHO.ARG=%ARG%
)
EXIT /B 0

:SAVE
( :: Provided by T3RR0R
  For /f "tokens=1 Delims==" %%G in ('Set ^| findstr /lv "LF"')Do (
    Set "V=%%G"
    2> nul 1> nul Set !V! && If not "!V:~0,1!"=="_" Echo(Set "%%G=!%%G!"
  )
) >"memory.dmp"
ECHO.[√] Memory dump finished.
@EXIT /B 0
