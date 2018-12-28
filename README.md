# MLib
MLib is a library for Skyrim that helps with developing MCM menus by making their development more structured.
In particular, it allows splitting MCMs into multiple files (one per page), simplifies the tooltip mechanic and also offers some utility methods for common tasks.

For an example of a mod that uses it, see [Anofeyn](https://github.com/Infernio/Anofeyn/tree/master/scripts/source) (the `_AF_MCM_*` scripts, in particular).

## Requirements
 - Skyrim Special Edition (Legendary should work, but is not tested)
 - [SkyUI](https://www.nexusmods.com/skyrimspecialedition/mods/12604)
 - [SkyUI SDK](https://github.com/schlangster/skyui/wiki#skyui-sdk)

## Building
 - Install all requirements listed above.
 - In `_build.sh`, change the variable `SKYRIM_PATH` to point to your Skyrim installation.
   - *Note: You may need to make further changes to variables here if you use a non-standard Skyrim installation.*
 - Run `./_build.sh`. You will need a bash interpreter for this, I recommend [Git Bash](https://git-scm.com/downloads).

*Note: If you want to use [Atom](https://atom.io) for development, you will have to edit `.build-papyrus.yml` to match your setup.*

## Usage
### Adding it to a project
If you're using git, add MLib as a submodule:

```sh
git submodule add https://github.com/Infernio/MLib
```

In your build script (for an example build script, see [Anofeyn's](https://github.com/Infernio/Anofeyn/blob/master/_build.sh) or [Campfire's](https://github.com/chesko256/Campfire/blob/master/Campfire_BuildRelease.py)), you should then copy the sources from `MLib/scripts` to the temporary build folder.

Feel free to redistribute the script files - it's unlikely that MLib will ever need major updates.
But, if you want to be 100% sure, you can add `MLib.esp` as a master and point users to MLib's nexus page.

### Creating a new MCM with MLib
To create an MCM with this library, first create a quest with a player reference alias and attach SKI_PlayerLoadGameAlias, as you normally would.

Then, open the Scripts tab and add an instance of the `MLib_Config` script.
Edit this script's properties:
  - `ModName`: The title of your mod's MCM. Same as standard SkyUI.
  - `Pages`: Leave this alone. It comes from SkyUI, but will now be filled by MLib automatically.
  - `PageScripts`: This is where you'll add your pages. We'll come back to this one in a minute.
  - `Version`: The current version of your mod's MCM. You can increase this whenever important changes occur to the mod / MCM and take advantage of MLib's `OnVersionUpdate` events (more on that later).

Head back to the Quest Aliases tab and add new player reference aliases, one for each page you want the MCM to have.

Now it's time to create scripts for the actual pages.
Make a new script for each page you want the MCM to have.
Each of those scripts must extend the `MLib_Page` script, giving you something like this:

```papyrus
ScriptName _MyMod_PageGeneral Extends MLib_Page

String Function GetTitle()
    return "$MyModPageGeneral"
EndFunction
```

*Note: The title obviously does not have to be localized.*

After all those scripts have been created, turn your attention back to the player reference aliases you created earlier.
Attach the appropriate script to each of those aliases.

Finally, head back to the Scripts tab on your quest and edit the properties of the `MLib_Config` script again.
Add all the aliases we just created to the `PageScripts` property.

And that's it! You can now head down to the **MLib_Page Reference** section to see documentation on how to add options to the pages.

### Changing an existing MCM to use MLib

## License
MLib is licensed under the [MIT License](LICENSE).
