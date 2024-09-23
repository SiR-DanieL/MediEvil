# MediEvil
Tools and docs for MediEvil for PSX.

- [Memory Addresses](#memory-addresses)
    - [General Game Data](#general-game-data)
    - [Movement Data](#movement-data)
    - [Bosses Data](d#bosses-data)
    - [Inventory Data](#inventory-data)
    - [Weapons Data](#weapons-data)
    - [Items Data](#items-data)
- [Level IDs](#level-ids)

## Memory Addresses

These addresses are all consistent between resets of ePSXe. We only want to use permanent addresses on auto splitters to not spend time searching for them every time we start the emulator.

All the addresses are assumed to be prefixed by `ePSxe.exe+`. For example, the full levelID address would be `ePSxe.exe+82A020`. For simplicity, we omit the `ePSxe.exe+` prefix in the tables below.

Generally, the PSX's RAM on ePSXe starts at `ePSxe.exe+81A020`. Where present, the **Offset in RAM** column indicates the address in relation to the beginning address of the RAM in system/kernel format. The RAM would begin at `0x80000000`.

### General Game Data
|Name|Type|Address|Description|Offset in RAM|
|---|---|---|---|---|
|levelID|byte|82A020|Contains the levle ID. Changes in between loading screens.|0x80010000|
|newGameHighlighted|byte|833154|Set to 3 when *New Game* is highlighted on the main menu. Changes to 0 when not highlighted, and brifly to 4 while switching to another menu item.|0x80019134|
|newGamePressed|byte|910EA3|Not sure what exactly this tracks, but it consistently changes values when *New Game* is pressed on the main menu, so it is used to track when a new run begins.|0x800F6E83|
|lifeBottlesOwned|byte|91219D|Tracks the amount of life bottles owned.|0x800F817D|
|fullLifeBottles|byte|912199|Tracks how many full life bottles the player has.|0x800F8179|
|currentLife|byte|90B668|Contains the current life of the player.|0x800F1648|
|gold|ushort|9122AC|Contains the current gold owned.|0x800F828C|
|isGameOverFlame|byte|912834|Changes to 1 when the Game Over flame animation begins. Used to track death.|0x800F8814|
|musicTrack|byte|908F20|Contains the numeric ID of the music track being played.|0x800EEF00|
|cameraView|byte|9C96E0|Contains the numeric ID of the camera view currently used.|0x801AF6C0|

### Movement Data
|Name|Type|Address|Description|Offset|
|---|---|---|---|---|
|movingState|ushort|2A8B23|Describes the state of Dan.||
|movingTimer|ushort|2A8B23|Counts for how long Dan has been moving. Jumping does not affect the timer. Dying pauses the timer but resets it as soon as you are revived.|50|
|stillTimer|ushort|2A8B23|Counts for how long Dan has been standing still. Jumping does not reset the timer.|44|
||ushort|2A8B23|This address changes from 0 (standing still) to 15 (walking) and 27 (running) with different values while stopping movement.|6B|
|direction|ushort|2A8B23|Direction that Dan is facing.|2AC|

**Moving State: HEX (Dec)**
- Still: 00 00 (0)
- Jumping: 02 00 (2)
- Crouching: 01 00 (1)
- Walking: 00 01 (256)
- Walking with shield up: 00 81 (33024)
- Running: 40 00 (64)
- Running with shield up: 40 40 (16448)
- Dashing while running: 40 60 (16480)
- Strafing right: 00 10 (4096)
- Strafing left: 00 08 (2048)
- Walking backward: 20 00 (32)

### Bosses Data
|Name|Type|Address|Description|Offset in RAM|
|---|---|---|---|---|
|isBoss|byte|90B72C|Set to 1 if a boss is present, otherwise 0.|0x800F170C|
|bossHealth|ushort|90B734|Contains the current health of the boss, or 0 when no boss is present.|0x800F1714|

### Inventory Data
These addresses track the ownership and ammos of weapons and other inventory items. They are set to `FF 00` (255 in decimal) when the player does not own the specific item, changing to `00 00` (0 in decimal), `01 00` (1 in decimal), or the amount of ammos/durability when owning the item.

### Weapons Data
|Name|Type|Address|Offset in RAM|
|---|---|---|---|
|smallSword|ushort|912214|0x800F81F4|
|broadSword|ushort|912218|0x800F81F8|
|club|ushort|912220|0x800F8200|
|magicSword|ushort|912222|0x800F8202|
|hammer|ushort|912224|0x800F8204|
|throwingDaggers|ushort|912228|0x800F8208|
|axe|ushort|91222C|0x800F820C|
|chickenDrumsticks|ushort|912230|0x800F8210|
|crossbow|ushort|912234|0x800F8214|
|longbow|ushort|912238|0x800F8218|
|flamingLongbow|ushort|91223C|0x800F821C|
|magicLongbow|ushort|912240|0x800F8220|
|spear|ushort|912244|0x800F8224|
|lightning|ushort|912248|0x800F8228|
|greenLightning|ushort|91224C|0x800F822C|
|dragonArmour|ushort|9122B8|0x800F8298|
|arm|ushort|912298|0x800F8278|
|copperShield|ushort|91229C|0x800F827C|
|silverShield|ushort|9122A0|0x800F8280|
|goldShield|ushort|9122B4|0x800F8294|

### Items Data
|Name|Type|Address|Offset in RAM|
|---|---|---|---|
|chaosRune|ushort|912250|0x800F8230|
|earthRune|ushort|912254|0x800F8234|
|moonRune|ushort|912258|0x800F8238|
|starRune|ushort|91225C|0x800F823C|
|timeRune|ushort|912260|0x800F8240|
|skullKey|ushort|912268|0x800F8248|
|shadowArtefact|ushort|91227C|0x800F825C|
|witchTalisman|ushort|912284|0x800F8264|
|dragonGems|ushort|9122B0|0x800F8290|

## Level IDs
|Level Name|ID|
|---|---|
|Main Menu|24|
|Map|26|
|Dan's Crypt|6|
|The Graveyard|12|
|Cemetery Hill|5|
|The Hilltop Mausoleum|7|
|Return to the Graveyard|13|
|Scarecrow Fields|21|
|Pumpkin Gorge|19|
|The Pumpkin Serpent|20|
|The Sleeping Village|22|
|The Asylum Grounds|3|
|Inside The Asylum|16|
|The Enchanted Earth|8|
|The Ant Caves|2|
|Pools Of the Ancient Dead|18|
|The Lake|17|
|The Crystal Caves|4|
|The Gallows Gauntlet|10|
|The Haunted Ruins|15|
|The Ghost Ship|11|
|The Entrance Hall|9|
|The Time Device|23|
|Zarok's Lair|25|
