REM : Special thanks to Grub4K for the xcopy input method! (https://gist.github.com/Grub4K/2d3f5875c488164b44454cbf37deae80)

SET "KEY="
SET "$.KEY="

::Set timeout if /t used
IF /I "%1."=="/T." START "CHOICE_AUTO_SKIP" /MIN CMD /C TIMEOUT /T %2^&TASKKILL /IM xcopy.exe /F

::Get user input - provided by Grub4K
FOR /F "DELIMS=" %%A IN ('XCOPY /W "!COMSPEC!" "!COMSPEC!" 2^>NUL ^|^| ECHO.TIMEOUT') DO (
	IF NOT DEFINED $.KEY SET "$.KEY=%%A�"
)

IF "!$.KEY:~-8,7!."=="TIMEOUT." (
	::If /T is used and times out, return it
	SET KEY=TIMEOUT
) ELSE (
	::Take out the key from the xcopy message
	SET "KEY=!$.KEY:~-2,1!"
	SET "$.KEY=!$.KEY:~-3!"
)

IF /I "%1."=="/T." TASKKILL /FI "WINDOWTITLE eq CHOICE_AUTO_SKIP*" /IM cmd.exe 1>NUL
::Make key returns more understandable
IF NOT DEFINED KEY SET KEY=EMPTY
IF "!$.KEY!"==") �" SET KEY=SPACE
IF "!$.KEY!"==")	�" SET KEY=TAB
IF "!$.KEY!"=="),�" SET KEY=COMMA
IF "!$.KEY!"==")=�" SET KEY=EQUAL
IF "!$.KEY!"==")�" SET KEY=BS
IF "!$.KEY!"=="s)�" SET KEY=EXCLAMATION
IF "!$.KEY!"==")&�" SET KEY=AND
IF "!$.KEY!"==")^�" SET KEY=CARET
IF "!$.KEY!"==")<�" SET KEY=LESS
IF "!$.KEY!"==")>�" SET KEY=GREATER
IF !$.KEY!==)^"� SET KEY=QUOTES
IF "!$.KEY!"==")%%�" SET KEY=PERCENT
IF "!$.KEY!"==")|�" SET KEY=PIPE

EXIT /B
