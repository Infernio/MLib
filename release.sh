#!/bin/bash

# Compile all scripts
"G:/steam/steamapps/common/Skyrim Special Edition/Papyrus Compiler/PapyrusCompiler.exe" "./scripts/source" -a -op -o="./scripts" -i="E:/Infernio/Desktop/Programming/Skyrim/MLib/scripts/source;G:/Steam/steamapps/common/Skyrim Special Edition/Data/Scripts/Source" -f="G:/Steam/steamapps/common/Skyrim Special Edition/Papyrus Compiler/TESV_Papyrus_Flags.flg"

# If we were launched in interactive mode (no parameter), wait for confirmation
if [ -z $1 ]
then
    echo "All scripts compiled, press any key to continue"
    read -n 1
fi
