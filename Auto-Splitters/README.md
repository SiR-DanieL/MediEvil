# MediSplit - MediEvil Auto Splitters for Live Split

You can find in this section all of the MediEvil PSX auto splitters created for speedrunners, along with a list of known useful memory addresses that you can use to create your custom versions.
The main focus is for ePSXe version 2.0.0 since this is the main emulator used by runnners.

## Auto Splitters for LiveSplit

These auto splitters are all written in ASL and they also auto start LiveSplit when selecting *New Game* in game. You can learn more about how to write ASL in the official [LiveSplit AutoSplitter repository](https://github.com/LiveSplit/LiveSplit.AutoSplitters).

This collection contains the following auto splitters:
* **MediSplit.asl** - Experimental new splitter to handle all category runs and customizations.
* **MediSplit Any%.asl** - All levels have their own split.
* **MediSplit Any% - Zarok Subsplits.asl** - All levels, but Zarok's Lair has subsplits for Fazguls' fight, Kardok, and Zarok.
* **MediSplit Any% - With Rune Smuggle.asl** - All levels and a separate split for *Rune Smuggle*.
* **MediSplit Any% - With Rune Smuggle and Zarok subsplits.asl** - All levels and a separate split for *Rune Smuggle*. Includes subsplits for Zarok's Lair.
* **MediSplit Any% - Subsplits All Bosses.asl** - All levels with subsplits for each boss fight.
* **MediSplit Any% - Subsplits All Bosses and Rune Smuggle.asl** - All levels with subsplits for each boss fight and for *Rune Smuggle*.

This list will be updated as new auto splitters are created with different setups.

## Using an Auto Splitter

To use any of the auto splitters downloaded from this repository, add the *Scriptable Auto Splitter* component to your Layout on LiveSplit and, in its settings, select the ASL file you want to use. Right-click on LiveSplit and choose "Edit Layout..." to open the Layout Editor, then click on the Plus-sign and choose "Scriptable Auto Splitter" from the section "Control". You can set the Path of the Script by going into the component settings of the Scriptable Auto Splitter. To get to the settings of the component, you can either double-click it in the Layout Editor or go into the Scriptable Auto Splitter Tab of the Layout Settings. Once you've set the Path, the script should automatically load and hopefully work.

## Additional Resources
* [MediEvil Speedrun Discord](https://discord.gg/V5DZEq9Fbf)
* [MediEvil on Speedrun.com](https://www.speedrun.com/medievil)
* [LiveSplit Auto Splitters Documentation](https://github.com/LiveSplit/LiveSplit.AutoSplitters)
