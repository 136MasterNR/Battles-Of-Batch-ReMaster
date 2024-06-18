SET $.TMP=!%1!
SET $.%1=
SET $.V=

CALL LENGTH !$.TMP!

SET /A $.V=$.STRL %% 3
IF NOT !$.V! EQU 0 IF NOT !$.STRL! LEQ 3 (
	SET /A $.STRL-=!$.V!
	SET $.%1=!$.TMP:~0,%$.V%!,
	SET $.TMP=!$.TMP:~%$.V%!
)

FOR /L %%I IN (1,1,!$.STRL!) DO (
	SET /A $.V=%%I %% 3
	SET $.%1=!$.%1!!$.TMP:~0,1!
	SET $.TMP=!$.TMP:~1!
	IF !$.V! EQU 0 IF DEFINED $.TMP SET $.%1=!$.%1!,
)

EXIT /B 0
