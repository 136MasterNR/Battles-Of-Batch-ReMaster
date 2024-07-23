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
	CALL LENGTH !$.ITEM:_= ! ×!I.Held[%%1]!
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
	SET $.oBUFFER=!$.oBUFFER![E[!$.POS!G: %RGB.CYAN%!$.ITEM:_= ![0m ×[1m!I.Held[%%1]![0m
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
	CALL SET $.oBUFFER=!$.oBUFFER![7;79H[1m!$.ITEM![0m %RGB%245;105;105m╀[0m[1m%%W.Strength[!$.ID!]%%[0m
)

IF NOT DEFINED @I.PAGE SET @I.PAGE=1


SET /A $.MAX=17*@I.PAGE
SET /A $.MIN=$.MAX-17
SET $.CNT=0
SET $.IAMOUNT=0
SET $.BUFFER=!$.BUFFER![26H
:: List Owned Items
FOR /F "TOKENS=2,3DELIMS=[]=" %%1 IN ('SET I.Held') DO (
	SET /A $.CNT+=1
	IF !$.CNT! LEQ !$.MAX! (
		IF !$.CNT! GTR !$.MIN! (
			SET /A $.IAMOUNT+=1
			SET $.ITEM=%%1
			FOR %%I IN (!$.ITEM!) DO SET $.BUFFER=!$.BUFFER![E[10G%RGB.CYAN%!I.Name[%%I]:_= ![0m ×[1m%%2[0m
		)
	)
)
IF !$.CNT! LEQ 0 SET "$.oBUFFER=!$.oBUFFER![27;11HYou do not own any items[0m"

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
			SET $.ID=!ID[W]%%1!
			FOR /F "TOKENS=1,2DELIMS= " %%A IN ("!$.ITEM! %%1") DO SET $.BUFFER=!$.BUFFER![E[82G%RGB.YELLOW%!W.Name[%%A]:_= ![0m %RGB.CYAN%↑[0m[1m%%2[0m %RGB%245;105;105m╀[0m[1m!W.Strength[%%B]![0m
		)
	)
)
IF !$.CNT! LEQ 0 SET "$.oBUFFER=!$.oBUFFER![27;82HYou do not own any weapons[0m"

SET /A $.WPAGES=($.CNT+16) / 17
SET $.oBUFFER=!$.oBUFFER![45;96H[1m!@W.PAGE!/!$.WPAGES![0m

ECHO;[?25l[H[0m^
.---.---------------------------------------------------------------------------------------------------------------.[E^
| %RGB.PINK%Q[0m ^|                                                                                                               ^|[E^
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

:: Draw Character
SET $.CNT=0
FOR /F "DELIMS=" %%I IN (.\character.txt) DO (
	SET /A $.POS=7+$.CNT
	ECHO.[!$.POS!;50H%%I
	SET /A $.CNT+=1
)

:QUICK-REFRESH
:: Cursor Correction
IF !@L.SEL! GTR !$.%@L.CAT%AMOUNT! SET /A @L.SEL=!$.%@L.CAT%AMOUNT!
IF !@L.SEL! LSS 1 SET /A @L.SEL=1

:: Selection
SET $.qBUFFER=
SET $.qBUFFER=!$.qBUFFER![?25l[26;6H
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

:: Item Info
SET $.qBUFFER=!$.qBUFFER![26;44H. - - - - - - - - - - - - - - .[27;45H[29X[28;45H[29X[29;45H[29X[30;45H[29X[31;45H[29X[32;45H[29X[33;45H[29X[34;45H[29X[35;45H[29X[36;45H[29X[37;45H[29X[38;45H[29X[39;45H[29X[40;45H[29X[41;45H[29X[42;45H[29X[43;45H[29X[44;45H[29X[45;45H[29X
SET /A $.CNT=1
IF !@L.CAT!==I (
	SET /A "$.REAL_SEL=(@L.SEL+(!@I.PAGE!*17))-17"
	FOR /F "TOKENS=2,*DELIMS=[]=" %%1 IN ('SET I.Held') DO (
		IF !$.CNT! EQU !$.REAL_SEL! (
			CALL LENGTH : !I.Name[%%1]:_= ! :
			SET /A "$.POS=59-($.STRL/2)"
			SET /A $.ODD=!$.STRL! %% 2
			IF !$.ODD! EQU 0 SET /A $.POS+=1
			SET $.qBUFFER=!$.qBUFFER![26;!$.POS!H: %RGB.SKYBLUE%[1m!I.Name[%%1]:_= ![0m :[0m
			
			SET $.ID=%%1
			IF NOT DEFINED I.Recognized?[%%1] SET I.Recognized?[%%1]=False
			IF /I !I.Recognized?[%%1]!==True (
				SET "$.qBUFFER=!$.qBUFFER![27;46H[s[1m!I.Desc[%%1]:$;=[u[B[s![0m"
				FOR /F "TOKENS=2,3,4DELIMS=[]=" %%1 IN ('SET I.Inf[%%1] 2^>NUL') DO (
					SET $.1=%%2
					SET $.2=%%3
					SET "$.qBUFFER=!$.qBUFFER![u[2B[s!$.1:_= !:[u[B[s[1m!$.2![0m"
				)
			) ELSE (
				SET $.qBUFFER=!$.qBUFFER![27;52H^(Not Recognized^)
			)
		)
		SET /A $.CNT+=1
	)
) ELSE IF !@L.CAT!==W (
	SET /A "$.REAL_SEL=(@L.SEL+(!@W.PAGE!*17))-17"
	FOR /F "TOKENS=2,*DELIMS=[]=" %%1 IN ('SET W.Level') DO (
		IF !$.CNT! EQU !$.REAL_SEL! (
			CALL LENGTH : !W.Name[%%1]:_= ! :
			SET /A "$.POS=59-($.STRL/2)"
			SET /A $.ODD=!$.STRL! %% 2
			IF !$.ODD! EQU 0 SET /A $.POS+=1
			SET $.qBUFFER=!$.qBUFFER![26;!$.POS!H: %RGB.SUNNY%!W.Name[%%1]:_= ! :[0m
			
			SET $.ID=%%1
			IF NOT DEFINED W.Recognized?[%%1] SET W.Recognized?[%%1]=False
			IF !W.Recognized?[%%1]!==True (
				SET "$.qBUFFER=!$.qBUFFER![27;46H[s[1m!W.Desc[%%1]:$;=[u[B[s![0m"
				FOR /F "TOKENS=2,3,4DELIMS=[]=" %%1 IN ('SET W.Inf[%%1] 2^>NUL') DO (
					SET $.1=%%2
					SET $.2=%%3
					SET "$.qBUFFER=!$.qBUFFER![u[2B[s!$.1:_= !:[u[B[s[1m!$.2![0m"
				)
			) ELSE (
				SET $.qBUFFER=!$.qBUFFER![27;52H^(Not Recognized^)
			)
		)
		SET /A $.CNT+=1
	)
)

ECHO;!$.qBUFFER:$P;=%%!

:: Choice ::
SET $.BUFFER=
SET $.oBUFFER=
SET $.qBUFFER=
SET /P "=[?25h[2;3H"<NUL

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
