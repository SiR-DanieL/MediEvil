/**
 * MediSplit - Auto Starter and Auto Splitter for the 100% and Max% categories and LiveSplit layouts of MediEvil speedruns on ePSXe.
 *
 * @author SirDarcanos
 * @contributors NoobKillerRoof
 * @version 1.0.0
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
    vars.starRune = vars.Helper.Make<ushort>(0x800F823C);
    vars.isGameOverFlame = vars.Helper.Make<byte>(0x800F8814);
    vars.cameraView = vars.Helper.Make<byte>(0x801AF6C0);

    vars.splitTypes = new Dictionary<string, Tuple<string, bool>> {
        {"levels", Tuple.Create("Level Splits", true)}
    };

    vars.splitsData = new Dictionary<string, Tuple<string, string, string, bool, Func<bool>>> {
        {"crypt", Tuple.Create(
            "Dan's Crypt", "Splits upon completing Dan's Crypt.", "levels", true,
            new Func<bool>(() => shouldSplit(6))
        )},
        {"graveyard", Tuple.Create(
            "The Graveyard", "Splits upon completing The Graveyard.", "levels", true,
            new Func<bool>(() => shouldSplit(12))
        )},
        {"cemeteryHill", Tuple.Create(
            "Cemetery Hill", "Split upon completing Cemetery Hill.", "levels", true,
            new Func<bool>(() => shouldSplit(5))
        )},
        {"mausoleum", Tuple.Create(
            "The Hilltop Mausoleum", "Split upon completing The Hilltop Mausoleum or upon reaching the boss, if boss setting is enabled for this level.", "levels", true,
            new Func<bool>(() => shouldSplit(7))
        )},
        {"returnGraveyard", Tuple.Create(
            "Return to the Graveyard", "Split upon completing Return to the Graveyard or upon reaching the boss, if boss setting is enabled for this level.", "levels", true,
            new Func<bool>(() => shouldSplit(13))
        )},
        {"scarecrowFields", Tuple.Create(
            "Scarecrow Fields", "Split upon completing Scarecrow Fields.", "levels", true,
            new Func<bool>(() => shouldSplit(21))
        )},
        {"gorge", Tuple.Create(
            "Pumpkin Gorge", "Split upon completing Pumpkin Gorge.", "levels", true,
            new Func<bool>(() => shouldSplit(19))
        )},
        {"serpent", Tuple.Create(
            "The Pumpkin Serpent", "Split upon completing The Pumpkin Serpent or upon reaching the boss, if boss setting is enabled for this level.", "levels", true,
            new Func<bool>(() => shouldSplit(20))
        )},
        {"sleepingVillage", Tuple.Create(
            "The Sleeping Village", "Split upon completing The Sleeping Village.", "levels", true,
            new Func<bool>(() => shouldSplit(22))
        )},
        {"asylumGrounds", Tuple.Create(
            "The Asylum Grounds", "Split upon completing The Asylum Grounds.", "levels", true,
            new Func<bool>(() => shouldSplit(3))
        )},
        {"asylum", Tuple.Create(
            "Inside The Asylum", "Split upon completing Inside The Asylum.", "levels", true,
            new Func<bool>(() => shouldSplit(16))
        )},
        {"enchantedEarth", Tuple.Create(
            "The Enchanted Earth", "Split upon completing The Enchanted Earth or upon reaching the boss, if boss setting is enabled for this level.", "levels", true,
            new Func<bool>(() => shouldSplit(8))
        )},
        {"antCaves", Tuple.Create(
            "The Ant Caves", "Split upon completing The Ant Caves or upon reaching the boss, if boss setting is enabled for this level.", "levels", true,
            new Func<bool>(() => shouldSplit(2))
        )},
        {"pools", Tuple.Create(
            "Pools Of The Ancient Dead", "Split upon completing Pools Of The Ancient Dead.", "levels", true,
            new Func<bool>(() => shouldSplit(18))
        )},
        {"lake", Tuple.Create(
            "The Lake", "Split upon completing The Lake.", "levels", true,
            new Func<bool>(() => shouldSplit(17))
        )},
        {"crystalCaves", Tuple.Create(
            "The Crystal Caves", "Split upon completing The Crystal Caves", "levels", true,
            new Func<bool>(() => shouldSplit(4))
        )},
        {"gallows", Tuple.Create(
            "The Gallows Gauntlet", "Split upon completing The Gallows Gauntlet", "levels", true,
            new Func<bool>(() => shouldSplit(10))
        )},
        {"hauntedRuins", Tuple.Create(
            "The Haunted Ruins", "Split upon completing The Haunted Ruins.", "levels", true,
            new Func<bool>(() => shouldSplit(15))
        )},
        {"ghostShip", Tuple.Create(
            "The Ghost Ship", "Split upon completing The Ghost Ship or upon reaching the boss, if boss setting is enabled for this level.", "levels", true,
            new Func<bool>(() => shouldSplit(11))
        )},
        {"entranceHall", Tuple.Create(
            "The Entrance Hall", "Split upon completing The Entrance Hall.", "levels", true,
            new Func<bool>(() => shouldSplit(9))
        )},
        {"timeDevice", Tuple.Create(
            "The Time Device", "Split upon completing The Time Device.", "levels", true,
            new Func<bool>(() => shouldSplit(23))
        )},
        {"zarokLair", Tuple.Create(
            "Zarok's Lair", "Split upon killing Zarok in Zarok's Lair.", "levels", true,
            new Func<bool>(() => vars.isZarokLair() && current.bossHealth == 0 && old.bossHealth < 65 && current.musicTrack == 21 )
        )},
        {"fazguls", Tuple.Create(
            "The Fazguls' Battle", "Split upon completing the battle between Fazguls and Dan's soldiers in Zarok's Lair.", "combatEvents", true,
            new Func<bool>(() => vars.isSettingOn("fazguls") && vars.isZarokLair() && current.cameraView == 20 && current.musicTrack == 16 )
        )},
        {"kardok", Tuple.Create(
            "Kardok", "Split upon killing Kardok in Zarok's Lair.", "combatEvents", true,
            new Func<bool>(() => vars.isSettingOn("kardok") && vars.isZarokLair() && current.isBoss == 0 && old.isBoss == 1 )
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
    settings.Add( "includeHOH", true, "Include HOH in current split" );
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

    vars.isMap = (Func<bool>)(() => { return current.levelID == 26; });
    vars.isHOH = (Func<bool>)(() => { return current.levelID == 0; });
    vars.wasHOH = (Func<bool>)(() => { return old.levelID == 0; });
    vars.isIntro = (Func<bool>)(() => { return current.levelID == 24; });
    vars.wasIntro = (Func<bool>)(() => { return old.levelID == 24; });
    vars.isZarokLair = (Func<bool>)(() => { return current.levelID == 25; });
    vars.isGameOver = (Func<bool>)(() => { return current.isGameOverFlame == 1 || (vars.isIntro() && !vars.wasIntro()); });
    vars.isSettingOn = (Func<string, bool>)((settingName) => { return settings[settingName]; });

    shouldSplit = (Func<int, bool>)(levelId => {
        //Dan's Crypt. No HOH split.
        if (levelId == 6) {
            return (old.levelID == levelId && vars.isMap());
        }

        if (settings["includeHOH"]) {
            return (vars.wasHOH() && vars.isMap());
        }

        return (old.levelID == levelId && vars.isHOH());
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
    bool doStart = current.newGamePressed == 1 && old.newGamePressed != 1 && vars.isIntro() && current.newGameHighlight == 3;
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
