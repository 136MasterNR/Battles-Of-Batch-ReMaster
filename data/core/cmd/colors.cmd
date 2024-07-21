@FOR /F "TOKENS=1,2DELIMS==" %%1 IN ('SET RGB.') DO @(
	IF %1.==. (
		ECHO.%%2%%%%1%%[0m
	) ELSE (
		ECHO.%%2%*[0m  %RGB.WHITE%-  %%2%%%%1%%[0m
	)
)
@EXIT /B 0