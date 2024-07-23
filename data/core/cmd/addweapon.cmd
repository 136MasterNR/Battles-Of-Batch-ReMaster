:: Creating Weapons and Items

:: Example
SET #I.Name[$]=Healing Item
SET #I.Held[$]=1
SET #I.Desc[$]=Heal yourself by 20$P; of $;your maximum
SET #I.Inf[$]Base_Healing=20$P; of Base Health
SET #I.Inf[$]Target_Range=Single
SET #I.Recognized?[$]=True
SET #I.HealingPower[$]=20 &:: Custom Attribute
SET #I.ItemIcon[$]=potion
%_INV.Create:$_After=+I.Held%


:: The item/weapon ID goes at the end of the variable, take for example I.Name[1]
::     I          Name       [1]
::     ^          ^           ^
::     Category   Attribute   Object ID (automatically assigned)

:: When creating an item, the ID must be presented as $ to automaticall assign an ID to the item.
:: Using "Inf" as an Attribute will make the value appear at the item's info, you must then add the
:: real name of the attribute after the item ID, e.g.  I.Inf[$]My_Cool_Info  would appear as "My Cool Info"
:: The info values can conveniently change any time, e.g. when upgrading the weapon.

:: The attributes I.Held and I.Name are the only ones required to exist.
:: I.Held indicates the amount of that item the will player have.

:: In the description of the item, using $P; instread of Percentage is required.
:: Additionally, $; indicates next line.


:: Example Weapon Initialization Command
REM %_Create:$_After=W.Level%

:: Example Item Initialization Command
REM %_Create:$_After=I.Held%

:: Using the _Create macro is required in order to process your new item, see how it works:
::   _Create         $_After     I.Held
::   ^               ^           ^
::   Macro command   Collector   Array to collect from

:: The collector assigns the ID to the item, it uses the array as a reference in order to add
:: a unique ID to the item. [Equation: Total_Category_Items + 1]


:: In order to mark an item STACKABLE, you have to add a plus symbol just before the collector array.
:: To increase this item's value, you can run the same exact commands. To make double sure that the player
:: really owns the item, it's highly recommended to always create the hashtag variables even if you just
:: want to increase the stack of the item.

:: Stackable item example:
REM %_Create:$_After=+I.Held%

:: Unique item example
REM %_Create:$_After=I.Held%


:: After _Create is called, it will regenerate the variables you created, assign the ID
:: and remove the hashtag at the beginning of the variable.
:: Additionally, it will be saved automatically using the SAVEALL method.
:: E.g. running a SET command after creation would show:
REM  I.Name[1]=Healing Item
REM  I.Held[1]=1
REM  I.Desc[1]=Heal yourself by 20$P; of $;your maximum 
REM  I.Inf[1]BaseHealing=20$P; of Base Health
REM  I.Inf[1]TargetRange=Single
REM  I.Recognized?[1]=True
REM  I.HealingPower[1]=100
REM  I.ItemIcon[1]=potion


:: _Create will generate a variable to easily find your item's ID by name in case you want to do
:: something special with it, e.g. the item being a key to a door or must have acquired.

:: Example SET ID output
REM ID[I]Healing_Item=1

:: Note: Any spaces in the item's name will be replaced with _ just for this variable.
::    [I]         Healing_Item     =1
::     ^          ^                 ^
::     Category   Simplified Name   Object ID

:: (!) Important - The item MUST BE UNIQUE and not exist multiple times, otherwise there will be major bugs.


:: More Examples
IF NOT DEFINED ID[W]Dustblade ( :: Use this IF to acquire only once
	SET #W.Name[$]=Dustblade
	SET #W.Level[$]=1
	SET #W.Strength[$]=5
	SET #W.Desc[$]=A blade made with the dust $;of your enemies
	SET #W.Inf[$]Type=Short Blade
	SET #W.Recognized?[$]=True
	SET #W.Craftable?[$]=True
	SET #W.CraftMaterials[$]=Stained_Dust;7,none;0,none;0
	%_INV.Create:$_After=W.Level%
)

SET #W.Name[$]=Comrade Hammer
SET #W.Level[$]=1
SET #W.Strength[$]=5
SET #W.Desc[$]=Your comrades give their $;power to your sake.
SET #W.Inf[$]Type=Hammer
SET #W.Inf[$]My_Own_Info=Very cool hammer
SET #W.CustomAttributes[$]=Add any custom attributes here, e.g.:
SET #W.IsWeaponAbilityUnlocked?[$]=False &:: Custom Attribute
SET #W.PlayerLevelRequired[$]=30 &:: Custom Attribute
SET #W.BonusAttack[$]=600 &:: Custom Attribute
:: You could use the above variable in the weapon's main function
:: e.g. to increase the attack by a specific amount. This value
:: can also be changed any time whenever the programmer wants,
:: e.g. by upgrading the weapon or defeating a specific opponent/level
%_INV.Create:$_After=W.Level%

:: It's very easy to use this command for more arrays other than I.Held and W.Level, and for multiple purposes.

MEMORY SAVE

EXIT /B 0
