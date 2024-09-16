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
    byte cameraView : "ePSxe.exe", 0x7880AC, 0x54;

    // Bosses Data
    byte isBoss : "ePSxe.exe", 0x90B72C;
    ushort bossHealth : "ePSxe.exe", 0x90B734;

    // Items Data
    ushort starRune : "ePSxe.exe", 0x91225C;
}

startup {
    vars.splitTypes = new Dictionary<string, Tuple<string, bool>> {
        {"levels", Tuple.Create("Level Splits", true)},
        {"combatEvents", Tuple.Create("Bosses Splits", true)},
        {"specialEvents", Tuple.Create("Optional Splits", false)},
    };

    vars.splitsData = new Dictionary<string, Tuple<string, string, string, bool, Func<bool>>> {
        {"crypt", Tuple.Create(
            "Dan's Crypt", "Splits upon completing Dan's Crypt.", "levels", true,
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 6)
        )},
        {"graveyard", Tuple.Create(
            "The Graveyard", "Splits upon completing The Graveyard.", "levels", true,
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 12)
        )},
        {"cemeteryHill", Tuple.Create(
            "Cemetery Hill", "Split upon completing Cemetery Hill.", "levels", true,
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 5)
        )},
        {"mausoleum", Tuple.Create(
            "The Hilltop Mausoleum", "Split upon completing The Hilltop Mausoleum.", "levels", true,
            new Func<bool>(() => vars.isSettingOn("stainedGlassDemon") ? (vars.curLevel == 7 && vars.curIsBoss == 1 && vars.oldIsBoss == 0) : (vars.isMap() && vars.oldLevel == 7))
        )},
        {"returnGraveyard", Tuple.Create(
            "Return to the Graveyard", "Split upon completing Return to the Graveyard.", "levels", true,
            new Func<bool>(() => vars.isSettingOn("guardians") ? (vars.curLevel == 13 && vars.curIsBoss == 1 && vars.oldIsBoss == 0) : (vars.isMap() && vars.oldLevel == 13))
        )},
        {"scarecrowFields", Tuple.Create(
            "Scarecrow Fields", "Split upon completing Scarecrow Fields.", "levels", true,
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 21)
        )},
        {"gorge", Tuple.Create(
            "Pumpkin Gorge", "Split upon completing Pumpkin Gorge.", "levels", true,
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 19)
        )},
        {"serpent", Tuple.Create(
            "The Pumpkin Serpent", "Split upon completing The Pumpkin Serpent.", "levels", true,
            new Func<bool>(() => vars.isSettingOn("pumpkinKing") ? (vars.curLevel == 20 && vars.curIsBoss == 1 && vars.oldIsBoss == 0) : (vars.isMap() && vars.oldLevel == 20))
        )},
        {"sleepingVillage", Tuple.Create(
            "The Sleeping Village", "Split upon completing The Sleeping Village.", "levels", true,
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 22)
        )},
        {"asylumGrounds", Tuple.Create(
            "The Asylum Grounds", "Split upon completing The Asylum Grounds.", "levels", true,
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 3)
        )},
        {"asylum", Tuple.Create(
            "Inside The Asylum", "Split upon completing Inside The Asylum.", "levels", true,
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 16)
        )},
        {"enchantedEarth", Tuple.Create(
            "The Enchanted Earth", "Split upon completing The Enchanted Earth.", "levels", true,
            new Func<bool>(() => vars.isSettingOn("wingedDemons") ? (vars.curLevel == 8 && vars.curIsBoss == 1 && vars.oldIsBoss == 0) : (vars.isMap() && vars.oldLevel == 8))
        )},
        {"antCaves", Tuple.Create(
            "The Ant Caves", "Split upon completing The Ant Caves.", "levels", true,
            new Func<bool>(() => vars.isSettingOn("antQueen") ? (vars.curLevel == 2 && vars.curIsBoss == 1 && vars.oldIsBoss == 0) : (vars.isMap() && vars.oldLevel == 2))
        )},
        {"pools", Tuple.Create(
            "Pools Of The Ancient Dead", "Split upon completing Pools Of The Ancient Dead.", "levels", true,
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 18)
        )},
        {"lake", Tuple.Create(
            "The Lake", "Split upon completing The Lake.", "levels", true,
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 17)
        )},
        {"crystalCaves", Tuple.Create(
            "The Crystal Caves", "Split upon completing The Crystal Caves", "levels", true,
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 4)
        )},
        {"gallows", Tuple.Create(
            "The Gallows Gauntlet", "Split upon completing The Gallows Gauntlet", "levels", true,
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 10)
        )},
        {"hauntedRuins", Tuple.Create(
            "The Haunted Ruins", "Split upon completing The Haunted Ruins.", "levels", true,
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 15)
        )},
        {"ghostShip", Tuple.Create(
            "The Ghost Ship", "Split upon completing The Ghost Ship.", "levels", true,
            new Func<bool>(() => vars.isSettingOn("pirateCaptain") ? (vars.curLevel == 11 && vars.curIsBoss == 1 && vars.oldIsBoss == 0) : (vars.isMap() && vars.oldLevel == 11))
        )},
        {"entranceHall", Tuple.Create(
            "The Entrance Hall", "Split upon completing The Entrance Hall.", "levels", true,
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 9)
        )},
        {"timeDevice", Tuple.Create(
            "The Time Device", "Split upon completing The Time Device.", "levels", true,
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 23)
        )},
        {"zarokLair", Tuple.Create(
            "Zarok's Lair", "Split upon killing Zarok in Zarok's Lair.", "levels", true,
            new Func<bool>(() => vars.curLevel == 25 && vars.curBossHealth == 0 && vars.oldBossHealth < 65 && vars.curMusicTrack == 21 )
        )},
        {"stainedGlassDemon", Tuple.Create(
            "The Stainless Glass Demon", "Split upon killing the Stainless Glass Demon in The Hilltop Mausoleum.", "combatEvents", false,
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 7 )
        )},
        {"guardians", Tuple.Create(
            "Guardians of the Graveyard", "Split upon killing the Guardians of the Graveyard in Return to the Graveyard.", "combatEvents", false,
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 13 )
        )},
        {"pumpkinKing", Tuple.Create(
            "The Pumpkin King", "Split upon killing Pumpkin King in The Pumpkin Serpent.", "combatEvents", false,
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 20 )
        )},
        {"antQueen", Tuple.Create(
            "The Ant Queen", "Split upon killing the Ant Queen in The Ant Caves.", "combatEvents", false,
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 2 )
        )},
        {"wingedDemons", Tuple.Create(
            "Winged Demons", "Split upon killing the Winged Demons in The Enchanted Earth.", "combatEvents", false,
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 8 )
        )},
        {"pirateCaptain", Tuple.Create(
            "Pirate Captain", "Split upon killing the Pirate Captain in The Ghost Ship.", "combatEvents", false,
            new Func<bool>(() => vars.isMap() && vars.oldLevel == 122 )
        )},
        {"fazguls", Tuple.Create(
            "The Fazguls' Battle", "Split upon completing the battle between Fazguls and Dan's soldiers in Zarok's Lair.", "combatEvents", true,
            new Func<bool>(() => vars.isSettingOn("fazguls") && vars.curLevel == 25 && vars.curCameraView == 20 && vars.curMusicTrack == 16 )
        )},
        {"kardok", Tuple.Create(
            "Kardok", "Split upon killing Kardok in Zarok's Lair.", "combatEvents", true,
            new Func<bool>(() => vars.isSettingOn("kardok") && vars.curLevel == 25 && vars.curIsBoss == 0 && vars.oldIsBoss == 1 )
        )},
        {"runeSmuggle", Tuple.Create(
            "Star Rune Smuggle", "Split upon loading back into the game after smuggling the Star Rune from Dan's Crypt for the alternative Any% route.", "specialEvents", false,
            new Func<bool>(() => vars.isMap() && vars.wasIntro() && vars.curStarRune == 1 )
        )},
    };

    foreach( var data in vars.splitTypes ) {
        settings.Add( data.Key, data.Value.Item2, data.Value.Item1 );
    }

    foreach ( var data in vars.splitsData ) {
        settings.Add( data.Key, data.Value.Item4, data.Value.Item1, data.Value.Item3 );
        settings.SetToolTip( data.Key, data.Value.Item2 );
    }

    /**
     * @link https://learn.microsoft.com/en-us/sysinternals/downloads/debugview
     */
    settings.Add( "debug", false, "Debug" );
}

init {
    vars.curLevel = 0;
    vars.oldLevel = 0;
    vars.curIsBoss = 0;
    vars.oldIsBoss = 0;
    vars.curBossHealth = 0;
    vars.oldBossHealth = 0;
    vars.curStarRune = 0;
    vars.oldStarRune = 0;
    vars.curCameraView = 0;
    vars.curMusicTrack = 0;
    vars.isGameOverFlame = 0;
    vars.completedSplits = new HashSet<string>();

    //This function will check if settings are enabled for a triggered split and adds it to completed splits
    vars.checkSplit = (Func<string, bool>)(key => {
        return ( vars.completedSplits.Add( key ) && settings[key] );
    });

    vars.refreshVars = (Action)(() => {
        vars.curLevel = current.levelID;
        vars.oldLevel = old.levelID;
        vars.curIsBoss = current.isBoss;
        vars.oldIsBoss = old.isBoss;
        vars.curBossHealth = current.bossHealth;
        vars.oldBossHealth = old.bossHealth;
        vars.curStarRune = current.starRune;
        vars.oldStarRune = old.starRune;
        vars.curCameraView = current.cameraView;
        vars.curMusicTrack = current.musicTrack;
        vars.isGameOverFlame = current.isGameOverFlame;
    });

    vars.debug = (Action<string>)(message => {
        if (settings["debug"]) {
            print(message);
        }
    });

    vars.isMap = (Func<bool>)(() => { return vars.curLevel == 26; });
    vars.isIntro = (Func<bool>)(() => { return vars.curLevel == 24; });
    vars.wasIntro = (Func<bool>)(() => { return vars.oldLevel == 24; });
    vars.isGameOver = (Func<bool>)(() => { return vars.isGameOverFlame == 1 || ( vars.isIntro() && ! vars.wasIntro() ); });
    vars.isSettingOn = (Func<string, bool>)((settingName) => { return settings[settingName]; });
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
    vars.refreshVars();

    bool doStart = current.newGamePressed == 1 && old.newGamePressed != 1 && vars.isIntro() && current.newGameHighlight == 3;

    if( doStart ) {
        vars.debug( "Game has started. Timer started.");

        return true;
    }
}

split {
    vars.refreshVars();

    foreach( var data in vars.splitsData ) {
        if( data.Value.Item5() && vars.checkSplit( data.Key ) ) { // Corrected to lowercase 'checkSplit'
            vars.debug( "Split for " + data.Key );

            return true;
        }
    }
}

reset {
    vars.refreshVars();

    if (vars.isGameOver()) {
        if (vars.oldLevel == 6 && settings["runeSmuggle"] && (vars.curStarRune == 1 || vars.oldStarRune == 1)) {
            print("Star Rune smuggle detected. Timer NOT reset.");
            return false;
        }

        vars.debug("Game over or quit. Timer reset.");
        return true;
    }

    return false;
}
