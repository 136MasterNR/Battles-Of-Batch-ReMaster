SET $.MONEY_POS=59
CALL THOUSANDS P.Money
CALL LENGTH Money: !$.P.Money! $
SET /A $.MONEY_POS-=$.STRL/2

SET $.EXP_POS=59
CALL LENGTH Level: ↑!S.Level! ^(!P.Exp!/!S.ReqExp! XP^)
SET /A $.EXP_POS-=$.STRL/2

SET $.NEXT_POS=59
CALL LENGTH Next Battle: !Map.Name[%P.WorldLvl%]!
SET /A $.NEXT_POS-=$.STRL/2

ECHO.[?25l
IF "%RAINBOWMODE%"=="TRUE" ( CALL TITLE 2 ) ELSE ( CALL TITLE 1 )
ECHO [0m[H^
.-------------------------------------------------------------------------------------------------------------------.[8E^
'-.--------.--.------------.                                                             .------------------------.-'[E^
.-'--------^|--^|------------'                    .---.-----------.---.                    '------------------------'-.[E^
|          ^|  ^|             .------------------'    :   [1;34mSTATS[0m   :    '------------------.                           ^|[E^
|          ^|  ^|             \                       '-----------'                       /        _   ,_,   _        ^|[E^
|  \_      ^|  ^|      _/     /                                                           \       / `'=^) ^(='` \       ^|[!$.EXP_POS!G%RGB.BLUE%Level[0m:[1m ↑!S.Level![0m ^([0m!P.Exp!/!S.ReqExp! XP[0m^)[E^
|   ]'--___^|__^|___--'[      \                                                           /      /.-.-.\ /.-.-.\      ^|[!$.MONEY_POS!G%RGB.GREEN%Money[0m: [1m!$.P.Money! %RGB.GREEN%$[0m[E^
|   ^|       ^|^|       ^|      /                                                           \      `      ^"      `      ^|[!$.NEXT_POS!G%RGB.RED%Next Battle[0m: [1m!Map.Name[%P.WorldLvl%]:_= ![0m[E^
|   \       ^|^|       /      \             .--------------------------------.            /                           ^|[E^
|    [      ^|^|      ]        '-----------'                                  '----------'                            ^|[E^
|    ^|______^(^)______^|                                  [1;37mWelcome^^![0m                                                     ^|[E^
|    ^|----^(^(^<^>^)^)----^|                                                                                               ^|[E^
|    ]      ^(^)      [                                                                                               ^|[E^
|     \     ^|^|     /                              .--.----------.--.                                                ^|[E^
|      [    ^|^|    ]                   .----------'   : [1;34mCOMMANDS[0m :   '----------.                                    ^|[E^
|      \    ^|^|    /             ,-,_  ^|              '----------'              ^|                                    ^|[E^
|       [   ^|^|   ]              ^|  _T ^| Press %RGB.CYAN%A[0m - [1;37mSelect a level.[0m              ^|                                    ^|[E^
|        \__^|^|__/               '-`^|^| ^| - - - - - - - - - - - - - - - - - - -  ^|                          ,_,       ^|[E^
|          '--'                   :^|^|-^| Press %RGB%138;167;255mQ[0m - [1;37mView your quests.[0m            ^|                         ^(.,.^)      ^|[E^
|                                 :^|^|-^| - - - - - - - - - - - - - - - - - - -  ^|                         ^(   ^)      ^|[E^
|                                  [] ^| Press %RGB%105;255;147mW[0m - [1;37mBuy items ^& skills.[0m %RGB.GRAY%^(Z/X/C^)[0m  ^|                         -"-"-------^|[E^
|                                     ^| - - - - - - - - - - - - - - - - - - -  ^|                                    ^|[E^
|                                     ^| Press %RGB%191;255;221mE[0m - [1;37mManage your character.[0m       ^|                                    ^|[E^
|                                     ^| - - - - - - - - - - - - - - - - - - -  ^|                                    ^|[E^
|                                     ^| Press %RGB%249;241;165mS[0m - [1;37mChange your preferences.[0m     ^|                                    ^|[E^
|              /\_[]_/\               ^| - - - - - - - - - - - - - - - - - - -  ^|                                    ^|[E^
|             ^|] _^|^|_ [^|              '.             Press a [sKey              .'                                    ^|[E^
|        ___   \/ ^|^| \/                '--------------------------------------'                                     ^|[E^
|       ╱\_/╲     ^|^|                                                                                                ^|[E^
|      ^(^|ò ó^|^)    ^|^|                                 .    '    .                                                    ^|[E^
|    __/{\^^^^/}\____^|^|                                   _______                                                      ^|[E^
|   / \  {~}  /__^|_]                              _  .`_^|___^|_`.  _                                                 ^|[E^
|   ^| /\  ~  /    []                                  \ \   / /                             ___                     ^|[E^
|   ^|_^| ^)   ^(     ''                                   \ ' ' /                           __/_  `.  .-'''-. .        ^|[E^
|   \_]/_____\                                          \ ^" /                            \_,` ^| \-'  /   ^)`-'       ^|[E^
|     _\_^| ^|_/_                                          \./                              ___Y  ,    .'7 /^|         ^|[E^
|    ^(_,_^| ^|_,_^)                                          V                              ^(_,___/...-` ^(_/_/         ^|[E^
|                                                                                         [1;30m2023©136MasterNR[0m          ^|[3G[1;30mBATTLES OF BATCH [0;33m%VERFULL% %VERTYPE%[0m[E^
|     .                              .    .                              .    .                              .      ^|[E^
|     ^|       ^|       .       ^|      ^|    ^|       ^|       .       ^|      ^|    ^|       ^|       .       ^|      ^|      ^|[E^
'-----'-------'-------'-------'------'----'-------'-------'-------'------'----'-------'-------'-------'------'------'[A
SET /P "=[?25h[u"<NUL
FOR /F "TOKENS=1DELIMS==" %%1 IN ('SET $.') DO SET "%%1="

CALL CHOICE
IF /I !KEY!==E (
	SET UI=inventory
)

EXIT /B 0
