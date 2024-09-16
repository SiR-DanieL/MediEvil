/**
 * MediSplit - Any%
 *
 * @author SirDarcanos
 * @contributors BlackMenthol, Xeelze
 * @version 1.0.0
 * @link
 * @tested-on ePSxe 2.0.0
 */

state("ePSXe")
{
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
    if( current.newGamePressed == 1 && old.newGamePressed != 1 && current.levelID == 24 && current.newGameHighlight == 3 ) {

        if( vars.debug ) {
            print("Game has started. Timer started.");
        }

        return true;
    }
}

/**
 * This section handles the automatic splits.
 * You can customize it based on your splits layout by commenting/removing and uncommenting some lines.
 * A line that is commented begins with a double-slash symbol (//). Removing the // will uncomment
 * the line and the code will become active.
 * Also, if your splits have different names than the regular level names, you must change them here to match your splits.
 *
 * Follow the instructions in the block below to activate/deactivate some sections.
 */
split {
    var currSegName = timer.CurrentSplit.Name;
    var currLevel = current.levelID;
    var prevLevel = old.levelID;

    if (currSegName == "Dan's Crypt") { return currLevel == 26 && prevLevel == 6; }

    else if (currSegName == "The Graveyard") { return currLevel == 26 && prevLevel == 12; }
    else if (currSegName == "Cemetery Hill") { return currLevel == 26 && prevLevel == 5; }

    /**
     * If you want to use a subsplit to track the Stained Glass Demon fight, delete the following
     * line and uncomment the two lines below.
     *
     * Change the currSegName value to match your splits or subsplits.
     */
    else if (currSegName == "The Hilltop Mausoleum") { return currLevel == 26 && prevLevel == 7; }
    //else if (currSegName == "-Release the Demon") { return currLevel == 7 && current.isBoss == 1 && old.isBoss == 0; }
    //else if (currSegName == "{The Hilltop Mausoleum} Stained Glass Demon") { return currLevel == 26 && prevLevel == 7; }

    /**
     * If you want to use a subsplit to track the Guardians of the graveyard's fight, delete the following
     * line and uncomment the two lines below.
     *
     * Change the currSegName value to match your splits or subsplits.
     */
    else if (currSegName == "Guardians of the Graveyard") { return currLevel == 26 && prevLevel == 13; }
    //else if (currSegName == "-Reach the Guardians") { return currLevel == 13 && current.isBoss == 1 && old.isBoss == 0; }
    //else if (currSegName == "{Return to the Graveyard} Guardians of the Graveyard") { return currLevel == 26 && prevLevel == 13; }

    else if (currSegName == "The Enchanted Earth") { return currLevel == 26 && prevLevel == 8; }
    else if (currSegName == "Pools Of The Ancient Dead") { return currLevel == 26 && prevLevel == 18; }
    else if (currSegName == "The Lake") { return currLevel == 26 && prevLevel == 17; }
    else if (currSegName == "The Crystal Caves") { return currLevel == 26 && prevLevel == 4; }

    /**
     * The following three lines of code handle the Rune Smuggle and Gallows Gauntlet splits.
     *
     * - If you just want a split for the Gallows, leave the code as is.
     * - If you want a Rune Smuggle split but without subsplits, uncomment the two other lines and remove
     *   the - in the Rune Smuggle segment, and {The Gallows Gauntlet} in the subsequent line.
     * - If you want a Rune Smuggle split with subsplits, delete the line
     *   right after this comment block and uncomment the other two lines.
     *
     * Change the currSegName value to match your splits or subsplits.
     */
    else if (currSegName == "The Gallows Gauntlet) { return currLevel == 26 && prevLevel == 10; }
    //else if (currSegName == "-Rune Smuggle") { return currLevel == 26 && prevLevel == 24 && current.starRune == 1; }
    //else if (currSegName == "{The Gallows Gauntlet} The Gallows Gauntlet") { return currLevel == 26 && prevLevel == 10; }

    else if (currSegName == "The Haunted Ruins") { return currLevel == 26 && prevLevel == 15; }
    else if (currSegName == "The Ghost Ship") { return currLevel == 26 && prevLevel == 11; }
    else if (currSegName == "The Entrance Hall") { return currLevel == 26 && prevLevel == 9; }
    else if (currSegName == "The Time Device") {  return currLevel == 26 && prevLevel == 23; }

    /**
     * The following blocks handle Zarok's Lair splits.
     * You can have one with subsplits, one with 3 separate splits, or a single split.
     * By default, the one with subsplits is active. To activate the others, remove or comment the default 3 lines
     * and uncomment the code you want to activate.
     *
     * Change the currSegName value to match your splits or subsplits.
     */
    // Zarok's Lair with subsplits
    else if (currSegName == "-Fazguls") { return currLevel == 25 && current.cameraView == 20 && current.musicTrack == 16; }
    else if (currSegName == "-Kardok") { return currLevel == 25 && current.isBoss == 0 && old.isBoss == 1; }
    else if (currSegName == "{Zarok's Lair} Zarok") { return currLevel == 25 && current.bossHealth == 0 && old.bossHealth < 65 && current.musicTrack == 21; }
    
    // Zarok's Lair with 3 separate splits
    //else if (currSegName == "Fazguls") { return currLevel == 25 && current.cameraView == 20 && current.musicTrack == 16; }
    //else if (currSegName == "Kardok") { return currLevel == 25 && current.isBoss == 0 && old.isBoss == 1; }
    //else if (currSegName == "Zarok") { return currLevel == 25 && current.bossHealth == 0 && old.bossHealth < 65 && current.musicTrack == 21; }

    // Zarok's Lair with single split
    //else if (currSegName == "Zarok's Lair") { return currLevel == 25 && current.bossHealth == 0 && old.bossHealth < 65 && current.music == 21; }
}

reset {
    if( current.isGameOverFlame == 1 || ( current.levelID == 24 && old.levelID != 24 ) ) {
        if( old.levelID == 6 ) {
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
