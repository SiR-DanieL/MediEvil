/**
 * MediSplit - Auto Starter and Auto Splitter for the 100% and Max% categories and LiveSplit layouts of MediEvil speedruns on ePSXe.
 *
 * @author SirDarcanos
 * @contributors Xeelze, 7eraser7, BlackMenthol, NoobKillerRoof
 * @version 1.0.1
 * @link https://github.com/SiR-DanieL/MediEvil/tree/main/Auto-Splitters
 * @tested-on ePSXe 2.0.0
 */
state("LiveSplit") {}

startup {
    Assembly.Load(File.ReadAllBytes("Components/emu-help-v3")).CreateInstance("PS1");

    vars.levelID = vars.Helper.Make<byte>(0x80010000);
    vars.newGameHighlight = vars.Helper.Make<byte>(0x80019134);
    vars.musicTrack = vars.Helper.Make<byte>(0x800EEF00);
    vars.isBoss = vars.Helper.Make<byte>(0x800F170C);
    vars.bossHealth = vars.Helper.Make<ushort>(0x800F1714);
    vars.newGamePressed = vars.Helper.Make<byte>(0x800F6E83);
    vars.isGameOverFlame = vars.Helper.Make<byte>(0x800F8814);
    vars.cameraView = vars.Helper.Make<byte>(0x801AF6C0);

    vars.splitTypes = new Dictionary<string, Tuple<string, bool>> {
        {"levels", Tuple.Create("Level Splits", true)},
        {"combatEvents", Tuple.Create("Bosses Splits", true)},
    };

    settings.Add( "includeHOH", true, "Include HOH in current split." );

    vars.splitsData = new Dictionary<string, Tuple<string, string, string, bool, Func<bool>>> {
        {"crypt", Tuple.Create(
            "Dan's Crypt", "Splits upon completing Dan's Crypt.", "levels", true,
            new Func<bool>(() => vars.shouldSplit(6))
        )},
        {"graveyard", Tuple.Create(
            "The Graveyard", "Splits upon completing The Graveyard.", "levels", true,
            new Func<bool>(() => vars.shouldSplit(12))
        )},
        {"cemeteryHill", Tuple.Create(
            "Cemetery Hill", "Split upon completing Cemetery Hill.", "levels", true,
            new Func<bool>(() => vars.shouldSplit(5))
        )},
        {"mausoleum", Tuple.Create(
            "The Hilltop Mausoleum", "Split upon completing The Hilltop Mausoleum or upon reaching the boss, if boss setting is enabled for this level.", "levels", true,
            new Func<bool>(() => vars.isSettingOn("stainedGlassDemon") ? (vars.levelID.Current == 7 && vars.isBoss.Current == 1 && vars.isBoss.Old == 0) : (vars.shouldSplit(7)))
        )},
        {"returnGraveyard", Tuple.Create(
            "Return to the Graveyard", "Split upon completing Return to the Graveyard or upon reaching the boss, if boss setting is enabled for this level.", "levels", true,
            new Func<bool>(() => vars.isSettingOn("guardians") ? (vars.levelID.Current == 13 && vars.isBoss.Current == 1 && vars.isBoss.Old == 0) : (vars.shouldSplit(13)))
        )},
        {"scarecrowFields", Tuple.Create(
            "Scarecrow Fields", "Split upon completing Scarecrow Fields.", "levels", true,
            new Func<bool>(() => vars.shouldSplit(21))
        )},
        {"gorge", Tuple.Create(
            "Pumpkin Gorge", "Split upon completing Pumpkin Gorge.", "levels", true,
            new Func<bool>(() => vars.shouldSplit(19))
        )},
        {"serpent", Tuple.Create(
            "The Pumpkin Serpent", "Split upon completing The Pumpkin Serpent or upon reaching the boss, if boss setting is enabled for this level.", "levels", true,
            new Func<bool>(() => vars.isSettingOn("pumpkinKing") ? (vars.levelID.Current == 20 && vars.isBoss.Current == 1 && vars.isBoss.Old == 0) : (vars.shouldSplit(20)))
        )},
        {"sleepingVillage", Tuple.Create(
            "The Sleeping Village", "Split upon completing The Sleeping Village.", "levels", true,
            new Func<bool>(() => vars.shouldSplit(22))
        )},
        {"asylumGrounds", Tuple.Create(
            "The Asylum Grounds", "Split upon completing The Asylum Grounds.", "levels", true,
            new Func<bool>(() => vars.shouldSplit(3))
        )},
        {"asylum", Tuple.Create(
            "Inside The Asylum", "Split upon completing Inside The Asylum.", "levels", true,
            new Func<bool>(() => vars.shouldSplit(16))
        )},
        {"enchantedEarth", Tuple.Create(
            "The Enchanted Earth", "Split upon completing The Enchanted Earth or upon reaching the boss, if boss setting is enabled for this level.", "levels", true,
            new Func<bool>(() => vars.isSettingOn("wingedDemons") ? (vars.levelID.Current == 8 && vars.isBoss.Current == 1 && vars.isBoss.Old == 0) : (vars.shouldSplit(8)))
        )},
        {"antCaves", Tuple.Create(
            "The Ant Caves", "Split upon completing The Ant Caves or upon reaching the boss, if boss setting is enabled for this level.", "levels", true,
            new Func<bool>(() => vars.isSettingOn("antQueen") ? (vars.levelID.Current == 2 && vars.isBoss.Current == 1 && vars.isBoss.Old == 0) : (vars.shouldSplit(2)))
        )},
        {"pools", Tuple.Create(
            "Pools Of The Ancient Dead", "Split upon completing Pools Of The Ancient Dead.", "levels", true,
            new Func<bool>(() => vars.shouldSplit(18))
        )},
        {"lake", Tuple.Create(
            "The Lake", "Split upon completing The Lake.", "levels", true,
            new Func<bool>(() => vars.shouldSplit(17))
        )},
        {"crystalCaves", Tuple.Create(
            "The Crystal Caves", "Split upon completing The Crystal Caves", "levels", true,
            new Func<bool>(() => vars.shouldSplit(4))
        )},
        {"gallows", Tuple.Create(
            "The Gallows Gauntlet", "Split upon completing The Gallows Gauntlet", "levels", true,
            new Func<bool>(() => vars.shouldSplit(10))
        )},
        {"hauntedRuins", Tuple.Create(
            "The Haunted Ruins", "Split upon completing The Haunted Ruins.", "levels", true,
            new Func<bool>(() => vars.shouldSplit(15))
        )},
        {"ghostShip", Tuple.Create(
            "The Ghost Ship", "Split upon completing The Ghost Ship or upon reaching the boss, if boss setting is enabled for this level.", "levels", true,
            new Func<bool>(() => vars.isSettingOn("pirateCaptain") ? (vars.levelID.Current == 11 && vars.isBoss.Current == 1 && vars.isBoss.Old == 0) : (vars.shouldSplit(11)))
        )},
        {"entranceHall", Tuple.Create(
            "The Entrance Hall", "Split upon completing The Entrance Hall.", "levels", true,
            new Func<bool>(() => vars.shouldSplit(9))
        )},
        {"timeDevice", Tuple.Create(
            "The Time Device", "Split upon completing The Time Device.", "levels", true,
            new Func<bool>(() => vars.shouldSplit(23))
        )},
        {"zarokLair", Tuple.Create(
            "Zarok's Lair", "Split upon killing Zarok in Zarok's Lair.", "levels", true,
            new Func<bool>(() => vars.isZarokLair() && vars.bossHealth.Current == 0 && vars.bossHealth.Old < 65 && vars.musicTrack.Current == 21 )
        )},
        {"stainedGlassDemon", Tuple.Create(
            "The Stainless Glass Demon", "Split upon completing the level after killing the Stainless Glass Demon in The Hilltop Mausoleum.", "combatEvents", false,
            new Func<bool>(() => vars.shouldSplit(7))
        )},
        {"guardians", Tuple.Create(
            "Guardians of the Graveyard", "Split upon completing the level after killing the Guardians of the Graveyard in Return to the Graveyard.", "combatEvents", false,
            new Func<bool>(() => vars.shouldSplit(13))
        )},
        {"pumpkinKing", Tuple.Create(
            "The Pumpkin King", "Split upon killing completing the level after Pumpkin King in The Pumpkin Serpent.", "combatEvents", false,
            new Func<bool>(() => vars.shouldSplit(20))
        )},
        {"antQueen", Tuple.Create(
            "The Ant Queen", "Split upon completing the level after killing the Ant Queen in The Ant Caves.", "combatEvents", false,
            new Func<bool>(() => vars.shouldSplit(2))
        )},
        {"wingedDemons", Tuple.Create(
            "Winged Demons", "Split upon completing the level after killing the Winged Demons in The Enchanted Earth.", "combatEvents", false,
            new Func<bool>(() => vars.shouldSplit(8))
        )},
        {"pirateCaptain", Tuple.Create(
            "Pirate Captain", "Split upon completing the level after killing the Pirate Captain in The Ghost Ship.", "combatEvents", false,
            new Func<bool>(() => vars.shouldSplit(11))
        )},
        {"fazguls", Tuple.Create(
            "The Fazguls' Battle", "Split upon completing the battle between Fazguls and Dan's soldiers in Zarok's Lair.", "combatEvents", true,
            new Func<bool>(() => vars.isSettingOn("fazguls") && vars.isZarokLair() && vars.cameraView.Current == 20 && vars.musicTrack.Current == 16 )
        )},
        {"kardok", Tuple.Create(
            "Kardok", "Split upon killing Kardok in Zarok's Lair.", "combatEvents", true,
            new Func<bool>(() => vars.isSettingOn("kardok") && vars.isZarokLair() && vars.isBoss.Current == 0 && vars.isBoss.Old == 1 )
        )}
    };

    foreach( var data in vars.splitTypes ) {
        settings.Add( data.Key, data.Value.Item2, data.Value.Item1 );
    }

    foreach ( var data in vars.splitsData ) {
        settings.Add( data.Key, data.Value.Item4, data.Value.Item1, data.Value.Item3 );
        settings.SetToolTip( data.Key, data.Value.Item2 );
    }

    settings.Add( "debug", false, "Debug" );
}

init {
    refreshRate = 300;
    vars.completedSplits = new HashSet<string>();
    
    vars.checkSplit = (Func<string, bool>)(key => {
        return (vars.completedSplits.Add(key) && settings[key]);
    });

    vars.debug = (Action<string>)(val => {
        if (settings["debug"]) {
            print(val.ToString());
        }
    });

    vars.isMap = (Func<bool>)(() => { return vars.levelID.Current == 26; });
    vars.isHOH = (Func<bool>)(() => { return vars.levelID.Current == 14; });
    vars.wasHOH = (Func<bool>)(() => { return vars.levelID.Old == 14; });
    vars.isIntro = (Func<bool>)(() => { return vars.levelID.Current == 24; });
    vars.wasIntro = (Func<bool>)(() => { return vars.levelID.Old == 24; });
    vars.isZarokLair = (Func<bool>)(() => { return vars.levelID.Current == 25; });
    vars.isGameOver = (Func<bool>)(() => { return vars.isGameOverFlame.Current == 1 || (vars.isIntro() && !vars.wasIntro()); });
    vars.isSettingOn = (Func<string, bool>)((settingName) => { return settings[settingName]; });

    vars.shouldSplit = (Func<int, bool>)(levelId => {
        //Dan's Crypt. No HOH split.
        if (levelId == 6) {
            return (vars.levelID.Old == levelId && vars.isMap());
        }

        if (settings["includeHOH"]) {
            return (vars.wasHOH() && vars.isMap());
        }

        return (vars.levelID.Old == levelId && vars.isHOH());
    });
}

update {
    print(vars.isMap().ToString());
    print(vars.isHOH().ToString());
    print("---");
}

onStart {
    vars.completedSplits.Clear();
}

start {
    bool doStart = vars.newGamePressed.Current == 1 && vars.newGamePressed.Old != 1 && vars.isIntro() && vars.newGameHighlight.Current == 3;
    if (doStart) {
        vars.debug("Game has started. Timer started.");
        return true;
    }
}

split {
    foreach (var data in vars.splitsData) {
        if (data.Value.Item5() && vars.checkSplit(data.Key)) {
            vars.debug("Splitting!");
            return true;
        }
    }
}

reset {
    if (vars.isGameOver()) {
        vars.debug("Game over or quit. Timer reset.");
        return true;
    }
    return false;
}
