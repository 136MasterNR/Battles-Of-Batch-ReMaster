SET STRING=%*
SET STRL=0

FOR /L %%I IN (0,1,117) DO (
	SET /A STRL+=1
	SET STRING=!STRING:~1!
	IF NOT DEFINED STRING EXIT /B
)
