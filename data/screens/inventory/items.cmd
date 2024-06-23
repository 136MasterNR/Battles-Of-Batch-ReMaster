IF NOT DEFINED $.LCATEGORY SET $.LCATEGORY=0

:: Buffer ::
SET $.BUFFER=
SET $.oBUFFER=

SET $.oBUFFER=!$.oBUFFER![4H
SET $.CNT=0
:: List Equipped Items
FOR /F "TOKENS=3DELIMS=[]=" %%1 IN ('SET E.Item') DO (
	SET /A $.CNT+=1
	SET $.ITEM=%%1
	CALL LENGTH !$.ITEM:_= ! ×!I.Owned[%%1]!
	IF !$.STRL! LSS 12 SET $.STRL=12
	SET /A "$.LOOP=($.STRL-8)/2"
	SET /A $.POS=38-$.STRL
	SET $.oBUFFER=!$.oBUFFER![2E[!$.POS!G.
	FOR /L %%I IN (1,1,!$.LOOP!) DO (
		SET $.oBUFFER=!$.oBUFFER!-
	)
	SET $.oBUFFER=!$.oBUFFER!: %RGB.YELLOW%Slot !$.CNT![0m :
	FOR /L %%I IN (1,1,!$.LOOP!) DO (
		SET $.oBUFFER=!$.oBUFFER!-
	)
	SET $.oBUFFER=!$.oBUFFER![E[!$.POS!G: %RGB.CYAN%!$.ITEM:_= ![0m ×[1m!I.Owned[%%1]![0m
	SET $.oBUFFER=!$.oBUFFER![E[!$.POS!G'
	FOR /L %%I IN (1,1,!$.STRL!) DO (
		SET $.oBUFFER=!$.oBUFFER!-
	)
)

:: Display Weapon
FOR /F "TOKENS=3DELIMS=[]=" %%1 IN ('SET E.Weapon') DO (
	SET $.ITEM=%%1
	SET $.ID=!ID[W]%%1!
	CALL LENGTH !$.ITEM:_= ! ╀%%W.Strength[!$.ID!]%%
	CALL SET $.oBUFFER=!$.oBUFFER![7;79H[1m!$.ITEM![0m %RGB%245;105;105m╀[0m%%W.Strength[!$.ID!]%%
)

IF NOT DEFINED @I.PAGE SET @I.PAGE=1


SET /A $.MAX=17*@I.PAGE
SET /A $.MIN=$.MAX-17
SET $.CNT=0
SET $.IAMOUNT=0
SET $.BUFFER=!$.BUFFER![26H
:: List Owned Items
FOR /F "TOKENS=2,3DELIMS=[]=" %%1 IN ('SET I.Owned') DO (
	SET /A $.CNT+=1
	IF !$.CNT! LEQ !$.MAX! (
		IF !$.CNT! GTR !$.MIN! (
			SET /A $.IAMOUNT+=1
			SET $.ITEM=%%1
			SET $.BUFFER=!$.BUFFER![E[10G%RGB.CYAN%!$.ITEM:_= ![0m ×[1m%%2[0m
		)
	)
)

SET /A $.IPAGES=($.CNT+16) / 17
SET $.oBUFFER=!$.oBUFFER![45;24H[1m!@I.PAGE!/!$.IPAGES![0m

IF NOT DEFINED @W.PAGE SET @W.PAGE=1

SET /A $.MAX=17*@W.PAGE
SET /A $.MIN=$.MAX-17
SET $.CNT=0
SET $.WAMOUNT=0
SET $.BUFFER=!$.BUFFER![26H
:: List Owned Weapons
FOR /F "TOKENS=2,3DELIMS=[]=" %%1 IN ('SET W.Level') DO (
	SET /A $.CNT+=1
	IF !$.CNT! LEQ !$.MAX! (
		IF !$.CNT! GTR !$.MIN! (
			SET /A $.WAMOUNT+=1
			SET $.ITEM=%%1
			SET $.BUFFER=!$.BUFFER![E[82G%RGB.YELLOW%!$.ITEM:_= ![0m ×[1m%%2[0m
		)
	)
)

SET /A $.WPAGES=($.CNT+16) / 17
SET $.oBUFFER=!$.oBUFFER![45;96H[1m!@W.PAGE!/!$.WPAGES![0m

ECHO;[?25l[H[0m^
.---.---------------------------------------------------------------------------------------------------------------.[E^
| %RGB.PINK%[sQ[0m ^|                                                                                                               ^|[E^
|---'                                         .-----------------------.                                             ^|[E^
|                                          .--: %RGB%158;177;255mCharacter [0m^& %RGB%133;255;196mEquipment[0m :--.                                          ^|[E^
|                                       .--'  '-----------------------'  '--.                                       ^|[E^
|                                      -:                                   :----: %RGB.FALSE%Weapon[0m :----.                    ^|[E^
|                                       :                                   :                  :                    ^|[E^
|                                     --:                                   :------------------'                    ^|[E^
|                                       :                                   :                                       ^|[E^
|                                      -:                                   :--: %RGB.PURPLE%Relic 1[0m :--.                       ^|[E^
|                                       :                                   : Locked        :                       ^|[E^
|                                     --:                                   :---------------'                       ^|[E^
|                                       :                                   :                                       ^|[E^
|                                      -:                                   :--: %RGB.PURPLE%Relic 2[0m :--.                       ^|[E^
|                                       :                                   : Locked        :                       ^|[E^
|                                     --:                                   :---------------'                       ^|[E^
|                                       :                           ╀ 42069 :                                       ^|[E^
|                                      -:--------.   %RGB.PINK%[4mQ[0m [1mto return[0m   .--------:--: %RGB.PURPLE%Relic 3[0m :--.                       ^|[E^
|                                       :         '---------------' ♥ 6666  : Locked        :                       ^|[E^
|                                     --'                                   '---------------'                       ^|[E^
|                                                                                                                   ^|[E^
|                                                                                                                   ^|[E^
|      .--------.-----------.--------.     .--------.-----------.--------.     .--------.-----------.--------.      ^|[E^
|      : .-'-.- :   [1mItems[0m   : -.-'-. :     : --::-- : %RGB.ORANGE%Item Info[0m : --::-- :     : -^|---- :  [1mWeapons[0m  : ----^|- :      ^|[E^
|      '--------'-----------'--------'     '--------'-----------'--------'     '--------'-----------'--------'      ^|[E^
|      . - - - - - - - - - - - - - - .     . - - - - - - - - - - - - - - .     . - - - - - - - - - - - - - - .      ^|[E^
|      :                             :     :                             :     :                             :      ^|[E^
|      :                             :     :                             :     :                             :      ^|[E^
|      :                             :     :                             :     :                             :      ^|[E^
|      :                             :     :                             :     :                             :      ^|[E^
|      :                             :     :                             :     :                             :      ^|[E^
|      :                             :     :                             :     :                             :      ^|[E^
|      :                             :     :                             :     :                             :      ^|[E^
|      :                             :     :                             :     :                             :      ^|[E^
|      :                             :     :                             :     :                             :      ^|[E^
|      :                             :     :                             :     :                             :      ^|[E^
|      :                             :     :                             :     :                             :      ^|[E^
|      :                             :     :                             :     :                             :      ^|[E^
|      :                             :     :                             :     :                             :      ^|[E^
|      :                             :     :                             :     :                             :      ^|[E^
|      :                             :     :                             :     :                             :      ^|[E^
|      :                             :     :                             :     :                             :      ^|[E^
|      :                             :     :                             :     :                             :      ^|[E^
|      :                             :     :                             :     :                             :      ^|[E^
|      :     ← %RGB.CYAN%[4mZ[0m  [1mPage[0m      %RGB.CYAN%[4mC[0m →      :     :                             :     :     ← %RGB.CYAN%[4mZ[0m  [1mPage[0m      %RGB.CYAN%[4mC[0m →      :      ^|[E^
|      '-----------------------------'     '-----------------------------'     '-----------------------------'      ^|[E^
|                                                                                                                   ^|[E^
'-------------------------------------------------------------------------------------------------------------------'[22A^
!$.oBUFFER!
ECHO.!$.BUFFER!
ECHO.!$.BUFFER!

:: Cursor Correction
IF !@L.SEL! GTR !$.%@L.CAT%AMOUNT! SET /A @L.SEL=!$.%@L.CAT%AMOUNT!

:QUICK-REFRESH
SET $.qBUFFER=
SET $.qBUFFER=!$.qBUFFER![26;6H
IF !@L.CAT!==W SET $.qBUFFER=!$.qBUFFER![78G
SET $.qBUFFER=!$.qBUFFER![!@L.SEL!B[1m^>[0m[1D[1B [1D[2A [1B[33C[1m^<[1D[1B [1D[2A 
SET $.qBUFFER=!$.qBUFFER![47;12H
IF !@L.CAT!==W SET $.qBUFFER=!$.qBUFFER![83G
SET $.qBUFFER=!$.qBUFFER![1mUse [4m%RGB.YELLOW%W[0m[1m and [4m%RGB.YELLOW%S[0m [1mto navigate[0m
SET $.qBUFFER=!$.qBUFFER![47;83H
IF !@L.CAT!==W SET $.qBUFFER=!$.qBUFFER![11G
SET $.qBUFFER=!$.qBUFFER!   (%RGB.GRAY%Press [4m
IF !@L.CAT!==I (SET $.qBUFFER=!$.qBUFFER!D) ELSE ^
IF !@L.CAT!==W (SET $.qBUFFER=!$.qBUFFER!A)
SET $.qBUFFER=!$.qBUFFER![24m to switch)   [0m


ECHO.!$.qBUFFER!


SET $.CNT=0
FOR /F "DELIMS=" %%I IN (.\character.txt) DO (
	SET /A $.POS=7+$.CNT
	ECHO.[!$.POS!;50H%%I
	SET /A $.CNT+=1
)

:: Choice ::
SET $.BUFFER=
SET $.oBUFFER=
SET $.qBUFFER=
SET /P "=[?25h[u"<NUL

CALL CHOICE
IF /I !KEY!==Q (
	SET #UI=
)

IF /I !KEY!==C (
	IF !@%@L.CAT%.PAGE! GEQ !$.%@L.CAT%PAGES! (
		SET @!@L.CAT!.PAGE=1
	) ELSE (
		SET /A @!@L.CAT!.PAGE+=1
	)
)
IF /I !KEY!==Z (
	IF !@%@L.CAT%.PAGE! LEQ 1 (
		SET @!@L.CAT!.PAGE=!$.%@L.CAT%PAGES!
	) ELSE SET /A @!@L.CAT!.PAGE-=1
)

IF /I !KEY!==W (
	IF !@L.SEL! GTR 1 SET /A @L.SEL-=1
	GOTO :QUICK-REFRESH
)
IF /I !KEY!==S (
	IF !@L.SEL! LSS !$.%@L.CAT%AMOUNT! SET /A @L.SEL+=1
	GOTO :QUICK-REFRESH
)

IF /I !KEY!==A (
	ECHO.[26;6H[78G[!@L.SEL!B [33C 
	IF !@L.SEL! GTR !$.IAMOUNT! SET @L.SEL=!$.IAMOUNT!
	SET @L.CAT=I
	GOTO :QUICK-REFRESH
)
IF /I !KEY!==D (
	ECHO.[26;6H[!@L.SEL!B [33C 
	IF !@L.SEL! GTR !$.WAMOUNT! SET @L.SEL=!$.WAMOUNT!
	SET @L.CAT=W
	GOTO :QUICK-REFRESH
)

FOR /F "TOKENS=1DELIMS==" %%1 IN ('SET $.') DO SET "%%1="

EXIT /B 0
