:::::::::: :::::::::: ::::::::::
::      !! DONT TOUCH !!      ::
:::::::::: :::::::::: ::::::::::
set LF=^


set ^"\=^^^%LF%%LF%^%LF%%LF%^^"
set LF=
:::::::::: :::::::::: ::::::::::
::      !! DONT TOUCH !!      ::
:::::::::: :::::::::: ::::::::::


:: :::::::::::::::::::: ::
:: Create Weapons/Items ::
set _INV.Create=(%\%
	SET $.ARG=$_After%\%
	SET $.STACK=%\%
	SET $.FOUND=%\%
	IF "!$.ARG:~0,1!"=="+" (%\%
		SET $.ARG=!$.ARG:~1!%\%
		SET $.STACK=1%\%
	)%\%
	IF !$.STACK! EQU 1 (%\%
		SET $.NAME=%\%
		SET $.CAT=%\%
		FOR /F "TOKENS=1,2,*DELIMS=#.=" %%1 IN ('SET #') DO (%\%
			IF %%2==Name[$] SET $.NAME=%%3%\%
			SET $.CAT=%%1%\%
		)%\%
		FOR /F "TOKENS=1,2,3DELIMS==[]" %%1 IN ('SET !$.CAT!.Name[') DO (%\%
			IF "%%3"=="!$.NAME!" (%\%
				SET $.FOUND=1%\%
				SET /A !$.ARG![%%2]+=1%\%
				FOR /F "TOKENS=1,*DELIMS=#=" %%1 IN ('SET #') DO (%\%
					SET #%%1=%\%
				)%\%
			)%\%
		)%\%
	)%\%
	IF NOT DEFINED $.FOUND (%\%
		SET $.CNT=1%\%
		FOR /F "TOKENS=1DELIMS==" %%I IN ('SET !$.ARG!') DO (%\%
			SET /A $.CNT+=1%\%
		)%\%
		SET $.NAME=%\%
		FOR /F "TOKENS=1,2,*DELIMS=#.=" %%1 IN ('SET #') DO (%\%
			IF %%2==Name[$] (%\%
				SET $.NAME=%%3%\%
				SET $.CAT=%%1%\%
			)%\%
			SET $.I=%%1.%%2%\%
			FOR /F "TOKENS=1,*DELIMS=#=" %%I IN ("!$.CNT!") DO (%\%
				SET !$.I:$=%%I!=%%3%\%
				SET %%1.%%2=%\%
			)%\%
			SET #%%1.%%2=%\%
		)%\%
		IF DEFINED $.NAME SET ID[!$.CAT!]!$.NAME: =_!=!$.CNT!%\%
	)%\%
)%\%


:: :::::::::: ::
:: Create IDs ::
set _INV.GenID=(%\%
	FOR /F "TOKENS=1,2,3DELIMS==[]" %%1 IN ('SET $_Array.Name[') DO (%\%
		SET $.NAME=%%3%\%
		SET ID[$_Array]!$.NAME: =_!=%%2%\%
	)%\%
)%\%


:: ::::::::::::::: ::
:: Window Subtitle ::
set _Subtitle=(%\%
	IF NOT "$"=="" (%\%
		TITLE Battles of Batch - $%\%
	) ELSE (%\%
		TITLE Battles of Batch%\%
	)%\%
)%\%


:: :::::::: ::
:: Save All ::
set _SaveAll=(%\%
	CALL PLAYER SAVE Equipment E%\%
	CALL PLAYER SAVE Items I%\%
	CALL PLAYER SAVE Materials M%\%
	CALL PLAYER SAVE Player P%\%
	CALL PLAYER SAVE Quests Q%\%
	CALL PLAYER SAVE Weapons W%\%
)%\%


:: :::::::::::::: ::
:: Engine Modules ::
REM SET _ENGINE.start=START /B "" CMD /Q /C engine 2^>NUL
REM SET _ENGINE.stop=BREAK^>"%TEMP%\ENGINE.stop"^&HELP^>NUL^&HELP^>NUL^&HELP^>NUL
REM SET _ASSET.insert=CALL asset insert $
REM SET _ASSET.update=CALL asset update $
REM SET _ASSET.switch=CALL asset switch $
REM SET _ASSET.remove=CALL asset remove $
REM SET _ASSET.removeall=CALL asset removeall
REM SET _SIGNAL.send=IF NOT EXIST "%TEMP%\$.sig" BREAK^>"%TEMP%\$.sig"
REM SET _SIGNAL.exist=IF EXIST "%TEMP%\$.sig"
REM SET _SIGNAL.nexist=IF NOT EXIST "%TEMP%\$.sig"
REM SET _SIGNAL.recieve=IF EXIST "%TEMP%\$.sig" DEL /Q "%TEMP%\$.sig"2^>NUL^&
REM SET _SIGNAL.remove=DEL /Q "%TEMP%\$.sig"
REM SET _CTRL.input=CALL choice
REM SET _CTRL.delay=TIMEOUT /T $ /NOBREAK ^>NUL
REM SET _SCRIPT.child=START /B "" CMD /Q /C $
REM SET _SCRIPT.call=CALL $
REM SET _AUDIO.start=START /B "" CMD /C CALL audiomanager START $ ^^^& EXIT 2^>^&1
REM SET _AUDIO.stop=START /B "" CMD /C CALL audiomanager STOP $ ^^^& EXIT 2^>^&1

SET \=
EXIT /B 0
