REM : Speical thanks to Grub4K for providing this open source code.
REM : Find it here: https://gist.github.com/Grub4K/2d3f5875c488164b44454cbf37deae80

IF NOT DEFINED VERCODE EXIT
SETLOCAL ENABLEDELAYEDEXPANSION

SET "PROMPT="
SET "SYMBOL="
SET "LENGTH="
SET "ALLOWED="
SET "INVALID==^^^(^)^"*^&?%%^!^|,.^>^</\"

:FLAGS
IF NOT "%~1" == "" (
    SET "%~1"
    SHIFT
    GOTO FLAGS
)
FOR /F %%A IN ('COPY /Z "%COMSPEC%" NUL') DO SET "CR=%%A"
FOR /F %%A IN ('"PROMPT $H&FOR %%B IN (1) DO REM"') DO SET "BS=%%A"
IF NOT DEFINED SYMBOL (
    SET "SYMBOL=^!KEY^!"
)
SET "INPUT=."
>CON <NUL SET /P "=.!BS! !BS!!PROMPT!"
:INPUT
SET "KEY="
FOR /F "DELIMS=" %%A IN ('XCOPY /W "!COMSPEC!" "!COMSPEC!" 2^>NUL') DO (
    IF NOT DEFINED KEY SET "KEY=%%A^!"
)
IF !KEY:~-1!==^^ (
    SET "KEY=^"
) ELSE SET "KEY=!KEY:~-2,1!"
IF !KEY! EQU !BS! (
    IF NOT "!INPUT!" == "." (
        SET "INPUT=!INPUT:~0,-1!"
        <NUL SET /P "=!BS! !BS!" >CON
    )
) ELSE IF !KEY! EQU !CR! (
    >CON ECHO:
    ECHO:!INPUT:~1!
    EXIT /B 0
) ELSE (
    IF DEFINED LENGTH (
        IF "!INPUT:~-%LENGTH%!" NEQ "!INPUT!" (
            GOTO INPUT
        )
    )
    FOR %%A IN ("!KEY!") DO (
        IF DEFINED ALLOWED (
            IF "!ALLOWED:%%~A=!" EQU "!ALLOWED!" (
                GOTO INPUT
            )
        ) ELSE (
            IF DEFINED INVALID (
                IF "!INVALID:%%~A=!" NEQ "!INVALID!" (
                    GOTO INPUT
                )
            )
        )
        SET "INPUT=!INPUT!!KEY!"
		>CON <NUL SET /P "=.!BS! !BS!%SYMBOL%"
    )
)

GOTO INPUT
