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
set _Create=(%\%
	set $.CNT=1%\%
	for /F "tokens=1delims==" %%I in ('SET $_After') do (%\%
		SET /A $.CNT+=1%\%
	)%\%
	for /F "tokens=1,*delims=#=" %%1 in ('SET #') do (%\%
		SET $.I=%%1%\%
		FOR /F "TOKENS=1,*DELIMS=#=" %%I IN ("!$.CNT!") DO (%\%
			SET !$.I:$=%%I!=%%2%\%
			SET %%1=%\%
		)%\%
		SET #%%1=%\%
	)%\%
)%\%


:: ::::::::::::::: ::
:: Window Subtitle ::
SET _Subtitle=TITLE Battles of Batch - $


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


EXIT /B 0
