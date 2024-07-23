MODE CON:COLS=126 LINES=9216
CLS
%_Subtitle:$=Command Line Enviroment%
::IF %RICHPRESENCE.VALUE%==TRUE START /MIN "RichManager" "%RichManager%" State=nul;Details=Terminal;LargeImage=cmd;LargeImageTooltip=;SmallImage=icon;SmallImageTooltip=Battles of Batch
ECHO;[38;2;166;255;245m^(•^) [38;2;207;255;250mBattles of Batch %RGB.YELLOW%ReMaster [37m[Version %VERTYPE% v!VERCODE:~0,1!.!VERCODE:~1,1!.!VERCODE:~2!]
ECHO;[38;2;166;255;245m^(•^) [38;2;207;255;250mMicrosoft Windows [37m[Version %WINVER:]=%]
ECHO;[38;2;235;64;52m^(^^^!^) [38;2;245;108;98mRun "EXIT" to return.[0m[3H[?25h
PUSHD "!DATA!\core\cmd"
CMD /V:ON /K "PROMPT $E[38;2;132;217;52mbob@terminal$E[0m$E[1m:$E[38;2;113;155;198m%%cd:~-9,9%%[0m$$$S[?25h&SET ^"PATH=%CD%\;%PATH%^""
IF EXIST ".\memory.dmp" (
	FOR /F "TOKENS=1DELIMS== " %%G IN ('set ^| findstr /lv "LF"') DO (
		Set "V=%%G"
		2> nul 1> nul Set !V! && If not "!V:~0,1!"=="_" SET %%G=
	)

	CLS & ECHO.Carrying variables from the dump file ...
	FOR /F "TOKENS=*DELIMS=" %%I IN (.\memory.dmp) DO (
		%%I
	)

	DEL ".\memory.dmp" /Q
)
POPD
MODE CON:COLS=%COLS% LINES=%LINES%
%_Subtitle:$=%
EXIT /B 0
