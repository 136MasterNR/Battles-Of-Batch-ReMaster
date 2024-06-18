:: List Owned Items
FOR /F "TOKENS=2,3DELIMS=[]=" %%1 IN ('SET I.Owned') DO (
	SET $.ITEM=%%1
	ECHO;[10G%RGB.CYAN%!$.ITEM:_= ![0m ×[1m%%2[0m
)

CALL CHOICE
IF /I !KEY!==Q (
	SET #UI=
)

EXIT /B 0
