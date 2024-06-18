IF DEFINED Config.LicenseAgreed (
	IF !Config.LicenseAgreed!==GNU_GPLv3 EXIT /B 0
) ELSE SET Config.LicenseAgreed=none

IF NOT EXIST .\license.txt >&2 ECHO.No accepted license detected.

CLS
ECHO.[LICENSE AGREEMENT]
ECHO.Agree to the license by closing the text window that opened.
ECHO.If you disagree, close the game before closing the text window.
START /WAIT .\license.txt

SET Config.LicenseAgreed=GNU_GPLv3
CALL CONFIG WRITE

EXIT /B 0
