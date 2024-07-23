:: Buffer ::
SET $.BUFFER=

SET $.BUFFER=!$.BUFFER![26H
SET $.CNT=0
:: List Equipped Items
FOR /F "TOKENS=3DELIMS=[]=" %%1 IN ('SET E.Item') DO (
	SET /A $.CNT+=1
	SET $.ITEM=%%1
	SET $.BUFFER=!$.BUFFER![E[10G!$.CNT!: %RGB.CYAN%!$.ITEM:_= ![0m ×[1m!I.Held[%%1]![0m
)
SET $.MAX=10
SET $.CNT=0
SET $.BUFFER=!$.BUFFER![32H
:: List Owned Items
FOR /F "TOKENS=2,3DELIMS=[]=" %%1 IN ('SET I.Held') DO (
	SET /A $.CNT+=1
	IF !$.CNT! LEQ !$.MAX! (
		SET $.ITEM=%%1
		FOR %%I IN (!$.ITEM!) DO SET $.BUFFER=!$.BUFFER![E[10G%RGB.CYAN%!I.Name[%%I]![0m ×[1m%%2[0m
	)
)
IF !$.CNT! EQU 0 SET $.BUFFER=!$.BUFFER![E[11GYou do not own any items
IF !$.CNT! GTR !$.MAX! (
	SET /A $.CNT-=$.MAX
	IF !$.CNT! EQU 1 (SET $.BUFFER=!$.BUFFER![E[10G!$.CNT! item hidden...) ELSE SET $.BUFFER=!$.BUFFER![E[10G!$.CNT! items hidden...
)
SET $.BUFFER=!$.BUFFER![26H
:: List Owned Materials
FOR /F "TOKENS=2,3DELIMS=[]=" %%1 IN ('SET M.Owned') DO (
	SET $.ITEM=%%1
	SET $.BUFFER=!$.BUFFER![E[46G%RGB.ORANGE%!$.ITEM:_= ![0m ×[1m%%2[0m
)
SET $.BUFFER=!$.BUFFER![26H
SET $.CNT=0
:: List Equipped Weapons
FOR /F "TOKENS=1,*DELIMS==" %%1 IN ('SET E.Weapon') DO (
	SET /A $.CNT+=1
	SET $.ITEM=%%2
	CALL SET $.BUFFER=!$.BUFFER![E[82G!$.CNT!: %RGB.YELLOW%!$.ITEM:_= ! %RGB.CYAN%↑[0m[1m!W.Level[%%2]! %RGB%245;105;105m╀[0m[1m%%W.Strength[!ID[W]%%2!]%%[0m
)
SET $.BUFFER=!$.BUFFER![29H
SET $.MAX=13
SET $.CNT=0
:: List Owned Weapons
FOR /F "TOKENS=2,*DELIMS=[]=" %%1 IN ('SET W.Level') DO (
	SET /A $.CNT+=1
	IF !$.CNT! LEQ !$.MAX! (
		SET $.ITEM=%%1
		FOR /F "TOKENS=1,2DELIMS= " %%A IN ("!$.ITEM! %%1") DO CALL SET $.BUFFER=!$.BUFFER![E[82G%RGB.YELLOW%!W.Name[%%A]:_= ! %RGB.CYAN%↑[0m[1m%%2 %RGB%245;105;105m╀[0m[1m!W.Strength[%%B]![0m
	)
)
IF !$.CNT! GTR !$.MAX! (
	SET /A $.CNT-=$.MAX
	IF !$.CNT! EQU 1 (SET $.BUFFER=!$.BUFFER![E[82G!$.CNT! item hidden...) ELSE SET $.BUFFER=!$.BUFFER![E[82G!$.CNT! items hidden...
)
IF !$.CNT! EQU 0 SET $.BUFFER=!$.BUFFER![E[82GYou do not own any weapons


CALL THOUSANDS P.Money

:: Display ::
ECHO.[?25l[H[0m^
.---.---------------------------------------------------------------------------------------------------------------.[E^
| %RGB.PINK%[sQ[0m ^|                                                                                                               ^|[E^
|---'.-------------------.                    .-----------------------.                    .----------------------. ^|[E^
|    : [1mPress %RGB.YELLOW%[4mP[0m[1m to switch[0m :                 .--: %RGB%158;177;255mCharacter[0m ^& %RGB%133;255;196mEquipment[0m :--.                 : [1mPress %RGB.YELLOW%[4mX[0m[1m to customize[0m : ^|[E^
|    : [1myour profile[0m .----'              .--'  '-----------------------'  '--.              '----. [1myour appearance[0m : ^|[E^
|    '-------------' .-----: %RGB%252;255;179mName[0m :-----:                                   :----: %RGB.TRUE%Health[0m :----. '----------------' ^|[E^
|                    : %RGB%253;255;209m^>[0m                :                                   : %RGB%191;255;186m♥[0m                :                    ^|[26G!Config.Profile![81G!S.Health![E^
|                    '------------------:                                   :------------------'                    ^|[E^
|                                       :                                   :                                       ^|[E^
|                     .----: %RGB%122;255;126mMoney[0m :----:                                   :--: %RGB.FALSE%Strength[0m :---.                     ^|[E^
|                     : %RGB%179;255;181m$[0m               :                                   : %RGB.PINK%╀[0m               :                     ^|[27G!$.P.Money![81G!S.Strength![E^
|                     '-----------------:                                   :-----------------'                     ^|[E^
|                                       :                                   :                                       ^|[E^
|                     .----: %RGB.BLUE%Level[0m :----:                                   :--: %RGB%255;201;125mCrit Rate[0m :--.                     ^|[E^
|                     : %RGB%194;228;255m↑[0m               :                                   : %RGB%255;209;143m֍[0m               :                     ^|[27G!S.Level![81G!S.Luck!%%[E^
|                     '-----------------:                                   :-----------------'                     ^|[E^
|                                       :                                   :                                       ^|[E^
|                       .----: %RGB%176;255;247mExp[0m :----:--------.   %RGB.YELLOW%[4mV[0m[1m view more[0m   .--------:--: %RGB%161;250;255mDefense[0m :--.                       ^|[E^
|                       : %RGB%199;255;249m•[0m             :         '---------------'         : %RGB%201;252;255m▲[0m             :                       ^|[29G!P.Exp![81G!S.Defence![E^
|                       '---------------'                                   '---------------'                       ^|[E^
|                                                                                                                   ^|[E^
|          [1mPress %RGB.CYAN%[4mA[0m[1m to equip an Item[0m                                               [1mPress %RGB.CYAN%[4mD[0m[1m to equip a Weapon[0m         ^|[E^
|      .--------.-----------.--------.     .--------.-----------.--------.     .--------.-----------.--------.      ^|[E^
|      : .-'-.- :   [1mItems[0m   : -.-'-. :     : -/\/\- : [1mMaterials[0m : -/\/\- :     : -^|---- :  [1mWeapons[0m  : ----^|- :      ^|[E^
|      '--------'-----------'--------'     '--------'-----------'--------'     '--------'-----------'--------'      ^|[E^
|      . - - : [1mEQUIPPED  ITEMS[0m : - - .     . - - : [1mOWNED MATERIALS[0m : - - .     . - - : [1mEQUIPPED WEAPON[0m : - - .      ^|[E^
|      :                             :     :                             :     :                             :      ^|[E^
|      :                             :     :                             :     '                             '      ^|[E^
|      :                             :     :                             :     . - - :  [1mOWNED WEAPONS[0m  : - - .      ^|[E^
|      :                             :     :                             :     :                             :      ^|[E^
|      '                             '     :                             :     :                             :      ^|[E^
|      . - - - : [1mOWNED ITEMS[0m : - - - .     :                             :     :                             :      ^|[E^
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
|      :  [1mPress %RGB.CYAN%[4mA[0m[1m to view all Items[0m  :     :                             :     : [1mPress %RGB.CYAN%[4mD[0m[1m to view all Weapons[0m :      ^|[E^
|      '-----------------------------'     '-----------------------------'     '-----------------------------'      ^|[E^
|                                                                                                                   ^|[E^
'-------------------------------------------------------------------------------------------------------------------'[22A
ECHO.!$.BUFFER!

SET $.CNT=0
FOR /F "DELIMS=" %%I IN (.\character.txt) DO (
	SET /A $.POS=7+$.CNT
	ECHO.[!$.POS!;50H%%I
	SET /A $.CNT+=1
)

:: Choice ::
SET $.BUFFER=
SET /P "=[?25h[u"<NUL

CALL CHOICE
IF /I !KEY!==Q (
	SET UI=menu
)
IF /I !KEY!==A (
	SET #UI=items
	IF NOT DEFINED @L.SEL SET @L.SEL=1
	SET @L.CAT=I
)
IF /I !KEY!==D (
	SET #UI=items
	IF NOT DEFINED @L.SEL SET @L.SEL=1
	SET @L.CAT=W
)


EXIT /B 0
