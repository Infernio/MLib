#!/bin/bash

# Variable definitions
# The path to the Skyrim / Skyrim SE installation to use
SKYRIM_PATH="G:/steam/steamapps/common/Skyrim Special Edition"
# The path to the vanilla skyrim, SKSE and SkyUI sources.
SKYRIM_SOURCES="${SKYRIM_PATH}/Data/Scripts/Source"
# The path to the papyrus compiler.
COMPILER_PATH="${SKYRIM_PATH}/Papyrus Compiler/PapyrusCompiler.exe"
# The path to the flags file for Skyrim.
FLAGS_PATH="${SKYRIM_SOURCES}/TESV_Papyrus_Flags.flg"

# Compile all scripts
"${COMPILER_PATH}" "scripts/source" -a -q -op -o="scripts" -i="scripts/source;${SKYRIM_SOURCES}" -f="${FLAGS_PATH}"

# If we were launched in interactive mode (no parameter), wait for confirmation
if [ -z $1 ]
then
    echo "All scripts compiled, press any key to continue"
    read -s -n 1
fi
