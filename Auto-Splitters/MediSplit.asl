/**
 * MediSplit - Auto Starter and Auto Splitter for all categories and LiveSplit layouts of MediEvil speedruns on ePSXe.
 *
 * @author SirDarcanos
 * @contributors Xeelze, 7eraser7, BlackMenthol
 * @version 1.0.0
 * @link https://github.com/SiR-DanieL/MediEvil/tree/main/Auto-Splitters
 * @tested-on ePSXe 2.0.0
 */
state("LiveSplit") {}

startup {
    /**
     * @link https://github.com/Jujstme/emu-help/
     */
    Assembly.Load(File.ReadAllBytes("Components/emu-help-v2")).CreateInstance("PS1");

    vars.Helper.Load = (Func<dynamic, bool>)(emu => {
        emu.Make<byte>("levelID", 0x80010000);
        emu.Make<byte>("newGameHighlight", 0x80019134);
        emu.Make<byte>("musicTrack", 0x800EEF00);
        emu.Make<byte>("isBoss", 0x800F170C);
        emu.Make<ushort>("bossHealth", 0x800F1714);
        emu.Make<byte>("newGamePressed", 0x800F6E83);
        emu.Make<ushort>("starRune", 0x800F823C);
        emu.Make<byte>("isGameOverFlame", 0x800F8814);
        emu.Make<byte>("cameraView", 0x801AF6C0);
        return true;
    });

    vars.splitTypes = new Dictionary<string, Tuple<string, bool>> {
        {"levels", Tuple.Create("Level Splits", true)},
        {"combatEvents", Tuple.Create("Bosses Splits", true)},
        {"specialEvents", Tuple.Create("Optional Splits", false)},
    };

    vars.splitsData = new Dictionary<string, Tuple<string, string, string, bool, Func<bool>>> {
        {"crypt", Tuple.Create(
            "Dan's Crypt", "Splits upon completing Dan's Crypt.", "levels", true,
            new Func<bool>(() => vars.isMap() && vars.Helper["levelID"].Old == 6)
        )},
        {"graveyard", Tuple.Create(
            "The Graveyard", "Splits upon completing The Graveyard.", "levels", true,
            new Func<bool>(() => vars.isMap() && vars.Helper["levelID"].Old == 12)
        )},
        {"cemeteryHill", Tuple.Create(
            "Cemetery Hill", "Split upon completing Cemetery Hill.", "levels", true,
            new Func<bool>(() => vars.isMap() && vars.Helper["levelID"].Old == 5)
        )},
        {"mausoleum", Tuple.Create(
            "The Hilltop Mausoleum", "Split upon completing The Hilltop Mausoleum.", "levels", true,
            new Func<bool>(() => vars.isSettingOn("stainedGlassDemon") ? (vars.Helper["levelID"].Current == 7 && vars.Helper["isBoss"].Current == 1 && vars.Helper["isBoss"].Old == 0) : (vars.isMap() && vars.Helper["levelID"].Old == 7))
        )},
        {"returnGraveyard", Tuple.Create(
            "Return to the Graveyard", "Split upon completing Return to the Graveyard.", "levels", true,
            new Func<bool>(() => vars.isSettingOn("guardians") ? (vars.Helper["levelID"].Current == 13 && vars.Helper["isBoss"].Current == 1 && vars.Helper["isBoss"].Old == 0) : (vars.isMap() && vars.Helper["levelID"].Old == 13))
        )},
        {"scarecrowFields", Tuple.Create(
            "Scarecrow Fields", "Split upon completing Scarecrow Fields.", "levels", true,
            new Func<bool>(() => vars.isMap() && vars.Helper["levelID"].Old == 21)
        )},
        {"gorge", Tuple.Create(
            "Pumpkin Gorge", "Split upon completing Pumpkin Gorge.", "levels", true,
            new Func<bool>(() => vars.isMap() && vars.Helper["levelID"].Old == 19)
        )},
        {"serpent", Tuple.Create(
            "The Pumpkin Serpent", "Split upon completing The Pumpkin Serpent.", "levels", true,
            new Func<bool>(() => vars.isSettingOn("pumpkinKing") ? (vars.Helper["levelID"].Current == 20 && vars.Helper["isBoss"].Current == 1 && vars.Helper["isBoss"].Old == 0) : (vars.isMap() && vars.Helper["levelID"].Old == 20))
        )},
        {"sleepingVillage", Tuple.Create(
            "The Sleeping Village", "Split upon completing The Sleeping Village.", "levels", true,
            new Func<bool>(() => vars.isMap() && vars.Helper["levelID"].Old == 22)
        )},
        {"asylumGrounds", Tuple.Create(
            "The Asylum Grounds", "Split upon completing The Asylum Grounds.", "levels", true,
            new Func<bool>(() => vars.isMap() && vars.Helper["levelID"].Old == 3)
        )},
        {"asylum", Tuple.Create(
            "Inside The Asylum", "Split upon completing Inside The Asylum.", "levels", true,
            new Func<bool>(() => vars.isMap() && vars.Helper["levelID"].Old == 16)
        )},
        {"enchantedEarth", Tuple.Create(
            "The Enchanted Earth", "Split upon completing The Enchanted Earth.", "levels", true,
            new Func<bool>(() => vars.isSettingOn("wingedDemons") ? (vars.Helper["levelID"].Current == 8 && vars.Helper["isBoss"].Current == 1 && vars.Helper["isBoss"].Old == 0) : (vars.isMap() && vars.Helper["levelID"].Old == 8))
        )},
        {"antCaves", Tuple.Create(
            "The Ant Caves", "Split upon completing The Ant Caves.", "levels", true,
            new Func<bool>(() => vars.isSettingOn("antQueen") ? (vars.Helper["levelID"].Current == 2 && vars.Helper["isBoss"].Current == 1 && vars.Helper["isBoss"].Old == 0) : (vars.isMap() && vars.Helper["levelID"].Old == 2))
        )},
        {"pools", Tuple.Create(
            "Pools Of The Ancient Dead", "Split upon completing Pools Of The Ancient Dead.", "levels", true,
            new Func<bool>(() => vars.isMap() && vars.Helper["levelID"].Old == 18)
        )},
        {"lake", Tuple.Create(
            "The Lake", "Split upon completing The Lake.", "levels", true,
            new Func<bool>(() => vars.isMap() && vars.Helper["levelID"].Old == 17)
        )},
        {"crystalCaves", Tuple.Create(
            "The Crystal Caves", "Split upon completing The Crystal Caves", "levels", true,
            new Func<bool>(() => vars.isMap() && vars.Helper["levelID"].Old == 4)
        )},
        {"gallows", Tuple.Create(
            "The Gallows Gauntlet", "Split upon completing The Gallows Gauntlet", "levels", true,
            new Func<bool>(() => vars.isMap() && vars.Helper["levelID"].Old == 10)
        )},
        {"hauntedRuins", Tuple.Create(
            "The Haunted Ruins", "Split upon completing The Haunted Ruins.", "levels", true,
            new Func<bool>(() => vars.isMap() && vars.Helper["levelID"].Old == 15)
        )},
        {"ghostShip", Tuple.Create(
            "The Ghost Ship", "Split upon completing The Ghost Ship.", "levels", true,
            new Func<bool>(() => vars.isSettingOn("pirateCaptain") ? (vars.Helper["levelID"].Current == 11 && vars.Helper["isBoss"].Current == 1 && vars.Helper["isBoss"].Old == 0) : (vars.isMap() && vars.Helper["levelID"].Old == 11))
        )},
        {"entranceHall", Tuple.Create(
            "The Entrance Hall", "Split upon completing The Entrance Hall.", "levels", true,
            new Func<bool>(() => vars.isMap() && vars.Helper["levelID"].Old == 9)
        )},
        {"timeDevice", Tuple.Create(
            "The Time Device", "Split upon completing The Time Device.", "levels", true,
            new Func<bool>(() => vars.isMap() && vars.Helper["levelID"].Old == 23)
        )},
        {"zarokLair", Tuple.Create(
            "Zarok's Lair", "Split upon killing Zarok in Zarok's Lair.", "levels", true,
            new Func<bool>(() => vars.isZarokLair() && vars.Helper["bossHealth"].Current == 0 && vars.Helper["bossHealth"].Old < 65 && vars.Helper["musicTrack"].Current == 21 )
        )},
        {"stainedGlassDemon", Tuple.Create(
            "The Stainless Glass Demon", "Split upon killing the Stainless Glass Demon in The Hilltop Mausoleum.", "combatEvents", false,
            new Func<bool>(() => vars.isMap() && vars.Helper["levelID"].Old == 7 )
        )},
        {"guardians", Tuple.Create(
            "Guardians of the Graveyard", "Split upon killing the Guardians of the Graveyard in Return to the Graveyard.", "combatEvents", false,
            new Func<bool>(() => vars.isMap() && vars.Helper["levelID"].Old == 13 )
        )},
        {"pumpkinKing", Tuple.Create(
            "The Pumpkin King", "Split upon killing Pumpkin King in The Pumpkin Serpent.", "combatEvents", false,
            new Func<bool>(() => vars.isMap() && vars.Helper["levelID"].Old == 20 )
        )},
        {"antQueen", Tuple.Create(
            "The Ant Queen", "Split upon killing the Ant Queen in The Ant Caves.", "combatEvents", false,
            new Func<bool>(() => vars.isMap() && vars.Helper["levelID"].Old == 2 )
        )},
        {"wingedDemons", Tuple.Create(
            "Winged Demons", "Split upon killing the Winged Demons in The Enchanted Earth.", "combatEvents", false,
            new Func<bool>(() => vars.isMap() && vars.Helper["levelID"].Old == 8 )
        )},
        {"pirateCaptain", Tuple.Create(
            "Pirate Captain", "Split upon killing the Pirate Captain in The Ghost Ship.", "combatEvents", false,
            new Func<bool>(() => vars.isMap() && vars.Helper["levelID"].Old == 11 )
        )},
        {"fazguls", Tuple.Create(
            "The Fazguls' Battle", "Split upon completing the battle between Fazguls and Dan's soldiers in Zarok's Lair.", "combatEvents", true,
            new Func<bool>(() => vars.isSettingOn("fazguls") && vars.isZarokLair() && vars.Helper["cameraView"].Current == 20 && vars.Helper["musicTrack"].Current == 16 )
        )},
        {"kardok", Tuple.Create(
            "Kardok", "Split upon killing Kardok in Zarok's Lair.", "combatEvents", true,
            new Func<bool>(() => vars.isSettingOn("kardok") && vars.isZarokLair() && vars.Helper["isBoss"].Current == 0 && vars.Helper["isBoss"].Old == 1 )
        )},
        {"runeSmuggle", Tuple.Create(
            "Star Rune Smuggle", "Split upon loading back into the game after smuggling the Star Rune from Dan's Crypt for the alternative Any% route.", "specialEvents", false,
            new Func<bool>(() => vars.isMap() && vars.Helper["starRune"].Current == 1 )
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
    refreshRate = 1;
    vars.completedSplits = new HashSet<string>();
    
    vars.checkSplit = (Func<string, bool>)(key => {
        return ( vars.completedSplits.Add( key ) && settings[key] );
    });

    vars.debug = (Action<string>)(val => {
        if (settings["debug"]) {
            print(val.ToString());
        }
    });

    vars.isMap = (Func<bool>)(() => { return current.levelID == 26; });
    vars.isIntro = (Func<bool>)(() => { return current.levelID == 24; });
    vars.wasIntro = (Func<bool>)(() => { return old.levelID == 24; });
    vars.isZarokLair = (Func<bool>)(() => { return current.levelID == 25; });
    vars.isGameOver = (Func<bool>)(() => { return current.isGameOverFlame == 1 || ( vars.isIntro() && ! vars.wasIntro() ); });
    vars.isSettingOn = (Func<string, bool>)((settingName) => { return settings[settingName]; });
}

update {
    print((vars.isMap() && vars.Helper["starRune"].Current == 1).ToString());
    print(vars.isMap().ToString());
    print((vars.Helper["starRune"].Current == 1).ToString());
    print("---");
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
    bool doStart = current.newGamePressed == 1 && old.newGamePressed != 1 && vars.isIntro() && current.newGameHighlight == 3;

    if( doStart ) {
        vars.debug( "Game has started. Timer started.");

        return true;
    }
}

split {
    foreach( var data in vars.splitsData ) {
        if( data.Value.Item5() && vars.checkSplit( data.Key ) ) {
            vars.debug( "Splitting!" );

            return true;
        }
    }
}

reset {
    if (vars.isGameOver()) {
        if (old.levelID == 6 && settings["runeSmuggle"] && (current.starRune == 1 || old.starRune == 1)) {
            print("Star Rune smuggle detected. Timer NOT reset.");
            return false;
        }

        vars.debug("Game over or quit. Timer reset.");
        return true;
    }

    return false;
}
