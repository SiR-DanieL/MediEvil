/**
 * MediSplit - Auto Starter and Auto Splitter for all categories and LiveSplit layouts of MediEvil speedruns on ePSXe.
 *
 * @author SirDarcanos
 * @contributors Xeelze, 7eraser7, BlackMenthol
 * @version 1.0.0
 * @link https://github.com/SiR-DanieL/MediEvil/tree/main/Auto-Splitters
 * @tested-on ePSXe 2.0.0
 */

state("ePSXe") {
    // General Game Data
    byte levelID : "ePSxe.exe", 0x82A020;
    byte newGameHighlight : "ePSxe.exe", 0x833154;
    byte newGamePressed : "ePSxe.exe", 0x910EA3;
    byte isGameOverFlame : "ePSxe.exe", 0x912834;
    byte musicTrack : "ePSxe.exe", 0x908F20;
    byte cameraView : "ePSxe.exe", 0x9CA074;

    // Bosses Data
    byte isBoss : "ePSxe.exe", 0x90B72C;
    ushort bossHealth : "ePSxe.exe", 0x90B734;

    // Items Data
    ushort starRune : "ePSxe.exe", 0x91225C;
}

startup {
    vars.splitTypes = new Dictionary<string, string> {
        {"anyPercent", "Splits for Any% category."},
        {"anyNoDGS", "Splits for Any% No DGS category."}, // Corrected closing brace
        {"oneHundred", "Splits for All Chalice (and 100%) category."},
        {"combatEvents", "Splits for bosses in specific levels."},
        {"specialEvents", "Splits for optional or alternative events and skips."},
    };

    vars.splitsData = new Dictionary<string, Tuple<string, string, string, Func<bool>>> {
        {"crypt", Tuple.Create(
            "Dan's Crypt",
            "Splits upon completing Dan's Crypt.",
            "anyPercent",
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 6)
        )},
        {"graveyard", Tuple.Create(
            "The Graveyard",
            "Splits upon completing The Graveyard.",
            "anyPercent",
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 12)
        )},
        {"cemeteryHill", Tuple.Create(
            "Cemetery Hill",
            "Split upon completing Cemetery Hill.",
            "anyPercent",
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 5)
        )},
        {"mausoleum", Tuple.Create(
            "The Hilltop Mausoleum",
            "Split upon completing The Hilltop Mausoleum.",
            "anyPercent",
            new Func<bool>(() => vars.isSettingActive("stainedGlassDemon") ? (vars.currLevel == 7 && vars.currIsBoss == 1 && vars.oldIsBoss == 0) : (vars.isMap() && vars.oldLevel == 7))
        )},
        {"returnGraveyard", Tuple.Create(
            "Return to the Graveyard",
            "Split upon completing Return to the Graveyard.",
            "anyPercent",
            new Func<bool>(() => vars.isSettingActive("guardians") ? (vars.currLevel == 13 && vars.currIsBoss == 1 && vars.oldIsBoss == 0) : (vars.isMap() && vars.oldLevel == 13))
        )},
        {"scarecrowFields", Tuple.Create(
            "Scarecrow Fields",
            "Split upon completing Scarecrow Fields.",
            "anyNoDGS",
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 21)
        )},
        {"gorge", Tuple.Create(
            "Pumpkin Gorge",
            "Split upon completing Pumpkin Gorge.",
            "anyNoDGS",
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 19)
        )},
        {"serpent", Tuple.Create(
            "The Pumpkin Serpent",
            "Split upon completing The Pumpkin Serpent.",
            "anyNoDGS",
            new Func<bool>(() => vars.isSettingActive("pumpkinKing") ? (vars.currLevel == 20 && vars.currIsBoss == 1 && vars.oldIsBoss == 0) : (vars.isMap() && vars.oldLevel == 20))
        )},
        {"sleepingVillage", Tuple.Create(
            "The Sleeping Village",
            "Split upon completing The Sleeping Village.",
            "oneHundred",
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 22)
        )},
        {"asylumGrounds", Tuple.Create(
            "The Asylum Grounds",
            "Split upon completing The Asylum Grounds.",
            "anyNoDGS",
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 3)
        )},
        {"asylum", Tuple.Create(
            "Inside The Asylum",
            "Split upon completing Inside The Asylum.",
            "anyNoDGS",
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 16)
        )},
        {"enchantedEarth", Tuple.Create(
            "The Enchanted Earth",
            "Split upon completing The Enchanted Earth.",
            "anyPercent",
            new Func<bool>(() => vars.isSettingActive("wingedDemons") ? (vars.currLevel == 8 && vars.currIsBoss == 1 && vars.oldIsBoss == 0) : (vars.isMap() && vars.oldLevel == 8))
        )},
        {"antCaves", Tuple.Create(
            "The Ant Caves",
            "Split upon completing The Ant Caves.",
            "oneHundred",
            new Func<bool>(() => vars.isSettingActive("antQueen") ? (vars.currLevel == 2 && vars.currIsBoss == 1 && vars.oldIsBoss == 0) : (vars.isMap() && vars.oldLevel == 2))
        )},
        {"pools", Tuple.Create(
            "Pools Of The Ancient Dead",
            "Split upon completing Pools Of The Ancient Dead.",
            "anyPercent",
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 18)
        )},
        {"lake", Tuple.Create(
            "The Lake",
            "Split upon completing The Lake.",
            "anyPercent",
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 17)
        )},
        {"crystalCaves", Tuple.Create(
            "The Crystal Caves",
            "Split upon completing The Crystal Caves",
            "anyPercent",
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 4)
        )},
        {"gallows", Tuple.Create(
            "The Gallows Gauntlet",
            "Split upon completing The Gallows Gauntlet",
            "anyPercent",
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 10)
        )},
        {"hauntedRuins", Tuple.Create(
            "The Haunted Ruins",
            "Split upon completing The Haunted Ruins.",
            "anyPercent",
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 15)
        )},
        {"ghostShip", Tuple.Create(
            "The Ghost Ship",
            "Split upon completing The Ghost Ship.",
            "anyPercent",
            new Func<bool>(() => vars.isSettingActive("pirateCaptain") ? (vars.currLevel == 11 && vars.currIsBoss == 1 && vars.oldIsBoss == 0) : (vars.isMap() && vars.oldLevel == 11))
        )},
        {"entranceHall", Tuple.Create(
            "The Entrance Hall",
            "Split upon completing The Entrance Hall.",
            "anyPercent",
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 9)
        )},
        {"timeDevice", Tuple.Create(
            "The Time Device",
            "Split upon completing The Time Device.",
            "anyPercent",
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 23)
        )},
        {"zarokLair", Tuple.Create(
            "Zarok's Lair",
            "Split upon killing Zarok in Zarok's Lair.",
            "anyPercent",
            new Func<bool>(() => vars.currLevel == 25 && vars.currBossHealth == 0 && vars.oldBossHealth < 65 && vars.currMusicTrack == 21 )
        )},
        {"stainedGlassDemon", Tuple.Create(
            "The Stainless Glass Demon",
            "Split upon killing the Stainless Glass Demon in The Hilltop Mausoleum.",
            "combatEvents",
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 7 )
        )},
        {"guardians", Tuple.Create(
            "Guardians of the Graveyard",
            "Split upon killing the Guardians of the Graveyard in Return to the Graveyard.",
            "combatEvents",
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 13 )
        )},
        {"pumpkinKing", Tuple.Create(
            "The Pumpkin King",
            "Split upon killing Pumpkin King in The Pumpkin Serpent.",
            "combatEvents",
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 20 )
        )},
        {"antQueen", Tuple.Create(
            "The Ant Queen",
            "Split upon killing the Ant Queen in The Ant Caves.",
            "combatEvents",
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 2 )
        )},
        {"wingedDemons", Tuple.Create(
            "Winged Demons",
            "Split upon killing the Winged Demons in The Enchanted Earth.",
            "combatEvents",
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 8 )
        )},
        {"pirateCaptain", Tuple.Create(
            "Pirate Captain",
            "Split upon killing the Pirate Captain in The Ghost Ship.",
            "combatEvents",
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 122 )
        )},
        {"fazguls", Tuple.Create(
            "The Fazguls' Battle",
            "Split upon completing the battle between Fazguls and Dan's soldiers in Zarok's Lair.",
            "combatEvents",
            new Func<bool>(() => vars.isSettingActive("fazguls") && vars.currLevel == 25 && vars.currCameraView == 20 && vars.currMusicTrack == 16 )
        )},
        {"kardok", Tuple.Create(
            "Kardok",
            "Split upon killing Kardok in Zarok's Lair.",
            "combatEvents",
            new Func<bool>(() => vars.isSettingActive("kardok") && vars.currLevel == 25 && vars.currIsBoss == 0 && vars.oldIsBoss == 1 )
        )},
        {"runeSmuggle", Tuple.Create(
            "Star Rune Smuggle",
            "Split upon loading back into the game after smuggling the Star Rune from Dan's Crypt for the alternative Any% route.",
            "specialEvents",
            new Func<bool>(() => vars.isMap() && vars.wasIntro() && vars.currStarRune == 1 )
        )},
    };

    foreach( var splitType in vars.splitTypes ) {
        settings.Add( splitType.Key, true, splitType.Value );
    }

    foreach ( var data in vars.splitsData ) {
        settings.Add( data.Key, true, data.Value.Item1, data.Value.Item3 );
        settings.SetToolTip( data.Key, data.Value.Item2 );
    }
}

init {
    /**
     * Set to true to see debug logs in DebugView.
     *
     * @link https://learn.microsoft.com/en-us/sysinternals/downloads/debugview
     */
    vars.debug = true;

    vars.currLevel = 0;
    vars.oldLevel = 0;
    vars.currIsBoss = 0;
    vars.oldIsBoss = 0;
    vars.currBossHealth = 0;
    vars.oldBossHealth = 0;
    vars.currStarRune = 0;
    vars.oldStarRune = 0;
    vars.currCameraView = 0;
    vars.currMusicTrack = 0;
    vars.isGameOverFlame = 0;
    vars.completedSplits = new HashSet<string>();

    //This function will check if settings are enabled for a triggered split and adds it to completed splits
    vars.checkSplit = (Func<string, bool>)(key => {
        return ( vars.completedSplits.Add( key ) && settings[key] );
    });

    vars.isMap = (Func<bool>)(() => { return vars.currLevel == 26; });
    vars.isIntro = (Func<bool>)(() => { return vars.currLevel == 24; });
    vars.wasIntro = (Func<bool>)(() => { return vars.oldLevel == 24; });
    vars.isGameOver = (Func<bool>)(() => { return vars.isGameOverFlame == 1 || ( vars.isIntro() && ! vars.wasIntro() ); });
    vars.isSettingActive = (Func<string, bool>)((settingName) => { return settings[settingName]; });
}

onStart {
    vars.completedSplits.Clear();
}

/**
 * This section controls the automatic start of the timer.
 *
 * The timer is started automatically if all the following conditions are met:
 * - The menu item "New Game" has been pressed
 * - The menu item "New Game" was not pressed before
 * - The current level ID is 24 (intro level)
 * - The menu item "New Game" is highlighted
 */
start {
    vars.currLevel = current.levelID;
    vars.oldLevel = old.levelID;
    vars.currIsBoss = current.isBoss;
    vars.oldIsBoss = old.isBoss;
    vars.currBossHealth = current.bossHealth;
    vars.oldBossHealth = old.bossHealth;
    vars.currStarRune = current.starRune;
    vars.oldStarRune = old.starRune;
    vars.currCameraView = current.cameraView;
    vars.currMusicTrack = current.musicTrack;
    vars.isGameOverFlame = current.isGameOverFlame;

    bool doStart = current.newGamePressed == 1 && old.newGamePressed != 1 && vars.isIntro() && current.newGameHighlight == 3;

    if( doStart ) {
        if( vars.debug ) {
            print("Game has started. Timer started.");
        }

        return true;
    }
}

split {
    vars.currLevel = current.levelID;
    vars.oldLevel = old.levelID;
    vars.currIsBoss = current.isBoss;
    vars.oldIsBoss = old.isBoss;
    vars.currBossHealth = current.bossHealth;
    vars.oldBossHealth = old.bossHealth;
    vars.currStarRune = current.starRune;
    vars.oldStarRune = old.starRune;
    vars.currCameraView = current.cameraView;
    vars.currMusicTrack = current.musicTrack;
    vars.isGameOverFlame = current.isGameOverFlame;

    foreach( var data in vars.splitsData ) {
        if( data.Value.Item4() && vars.checkSplit( data.Key ) ) { // Corrected to lowercase 'checkSplit'
            if( vars.debug ) {
                print( "Split for " + data.Key );
            }

            return true;
        }
    }
}

reset {
    vars.currLevel = current.levelID;
    vars.oldLevel = old.levelID;
    vars.currIsBoss = current.isBoss;
    vars.oldIsBoss = old.isBoss;
    vars.currBossHealth = current.bossHealth;
    vars.oldBossHealth = old.bossHealth;
    vars.currStarRune = current.starRune;
    vars.oldStarRune = old.starRune;
    vars.isGameOverFlame = current.isGameOverFlame;

    if( vars.isGameOver() ) {
        if( vars.oldLevel == 6 && settings["runeSmuggling"] ) {
            // This might be a Rune Smuggle. Ensure that before resetting.
            if( vars.debug ) {
                print("Current/Old Star Rune Value: " + current.starRune + "/" + old.starRune);
            }

            if( vars.currStarRune == 1 || vars.oldStarRune == 1 ) {
                print( "Star Rune smuggle. Timer NOT reset." );

                return false;
            }

            if( vars.debug ) {
                print("Not a rune smuggle. Game over or quit. Timer reset.");
            }

            return true;
        }

        if( vars.debug ) {
            print("Game over or quit. Timer reset.");
        }

        return true;
    }
}
