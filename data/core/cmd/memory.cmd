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
IF DEFINED DUMPED ECHO.[X] Cannot dump twice.&EXIT /B 0
FOR /F "TOKENS=1DELIMS==" %%A IN ('SET _') DO SET %%A=
SET \=
SET > "memory.dmp"
ECHO.[√] Memory dump finished.
SET DUMPED=1
@EXIT /B 0
