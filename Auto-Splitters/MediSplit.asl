/**
 * MediSplit - Auto Starter and Auto Splitter for all categories and LiveSplit layouts of MediEvil speedruns on ePSXe.
 *
 * @author SirDarcanos
 * @contributors BlackMenthol, Xeelze
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

init {
    /**
     * Set to true to see debug logs in DebugView.
     *
     * @link https://learn.microsoft.com/en-us/sysinternals/downloads/debugview
     */
    vars.debug = false;
}

startup {
    settings.Add( "runeSmuggle", false, "Split Rune Smuggling")
    settings.Add( "zarokSplits", true, "Separate splits for Zarok's Lair")
    settings.Add( "bossesSplits", false, "Separate splits for all Bosses")
    
    settings.SetToolTip("runeSmuggle", "You will be performing Rune Smuggling in your runs and want a separate split for it.");
    settings.SetToolTip("zarokSplits", "You use separate splits or subsplits for Zarok's Lair.");
    settings.SetToolTip("bossesSplits", "You use separate splits or subsplits for all bosses.");
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
    bool doStart = current.newGamePressed == 1 && old.newGamePressed != 1 && current.levelID == 24 && current.newGameHighlight == 3;
    
    if( doStart ) {

        if( vars.debug ) {
            print("Game has started. Timer started.");
        }

        return true;
    }
}

/**
 * This section handles the automatic splits.
 */
split {    
    if( current.level == 25) {
        if( settings["zarokSplits"] ) {
            if( current.cameraView == 20 && current.musicTrack == 16 && current.isBoss == 0 ) { return true; }
            else if( current.isBoss == 0 && old.isBoss == 1 ) { return true; }
            else if( current.bossHealth == 0 && old.bossHealth < 65 && current.musicTrack == 21 ) { return true; }
        } else {
            if( current.bossHealth == 0 && old.bossHealth < 65 && current.musicTrack == 21 ) { return true; }
        }
    } else {
        bool isBossLevel = current.levelID == 7 || current.levelID == 13;
        
        if( settings["runeSmuggling"] && current.levelID == 26 && old.levelID == 24) { return current.starRune == 1; }
        else if( settings["bossesSplits"] && isBossLevel && current.isBoss == 1 && old.isBoss == 0 ) { return true; }
        else if( current.levelID == 26 && old.levelID != 26 ) { return true; }
    }
}

reset {
    if( current.isGameOverFlame == 1 || ( current.levelID == 24 && old.levelID != 24 ) ) {
        if( old.levelID == 6 && settings["runeSmuggling"] ) {
            // This might be a Rune Smuggle. Ensure that before resetting.
            if( vars.debug ) {
                print("Current/Old Star Rune Value: " + current.starRune + "/" + old.starRune);
            }

            if( old.starRune == 1 || current.starRune == 1 ) {
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
