#!/bin/bash

# Color constants
C_RED='\033[1;31m'
C_GREEN='\033[1;32m'
C_BLUE='\033[1;34m'
C_YELLOW='\033[1;33m'
C_NC='\033[0m'

# Variable definitions
# The path to the Skyrim / Skyrim SE installation to use
SKYRIM_PATH="G:/steam/steamapps/common/Skyrim Special Edition"
# The path to the vanilla Skyrim, SKSE and SkyUI sources.
SKYRIM_SOURCES="${SKYRIM_PATH}/Data/Scripts/Source"
# The path to the papyrus compiler.
COMPILER="${SKYRIM_PATH}/Papyrus Compiler/PapyrusCompiler.exe"
# The path to the flags file for Skyrim.
FLAGS="${SKYRIM_SOURCES}/TESV_Papyrus_Flags.flg"
# The version to release the mod with
VERSION="0.1.0"
# The name of the folder in which the mod will be built
TEMP_FOLDER="temp"
# The name to use for the release file
RELEASE_NAME="MLib_${VERSION}.7z"

# Print a nice greeting
echo -e "Welcome to the ${C_RED}MLib release builder${C_NC}!"
echo ""

# Find out if we should build a dev or a release file
release=-1
while [[ release -eq -1 ]]; do
    echo -e "Build a (${C_GREEN}d${C_NC})${C_YELLOW}evelopment${C_NC} or a (${C_GREEN}r${C_NC})${C_YELLOW}elease${C_NC} file?"
    read -s -n 1 key
    if [[ "${key}" == "d" ]]
    then
        release=0
    elif [[ "${key}" == "r" ]]
    then
        release=1
    else
        echo -e "${C_GREEN}${key}${C_NC} is not a valid file type."
    fi
done

# Delete and recreate a temp folder to make sure we have a fresh setup
echo ""
echo -e "${C_RED}==>${C_NC} Creating new temporary build folder..."

rm -rf "${TEMP_FOLDER}"
mkdir -p "${TEMP_FOLDER}/Data"

# Copy everything over
cp -r "scripts" "${TEMP_FOLDER}/Data"
cp "MLib.esp" "${TEMP_FOLDER}"

# These are only used in release mode
if [[ $release -eq 1 ]]
then
    cp "MLibBSAManifest.txt" "${TEMP_FOLDER}"
    cp "MLibBSAScript.txt" "${TEMP_FOLDER}"
fi


# Move into the temp folder to make the rest of this procedure simpler
cd "${TEMP_FOLDER}"

# Compile all scripts, adding the appropriate flags for each mode
echo ""
echo -e "${C_RED}==>${C_NC} Compiling scripts, this may take a while..."

if [[ $release -eq 0 ]]
then
    "${COMPILER}" "Data/scripts/source" -a -q -o="Data/scripts" -i="Data/scripts/source;${SKYRIM_SOURCES}" -f="${FLAGS}"
else
    "${COMPILER}" "Data/scripts/source" -a -q -op -o="Data/scripts" -i="Data/scripts/source;${SKYRIM_SOURCES}" -f="${FLAGS}"
fi

# If we're in development mode, use loose files
# In release mode, use a BSA
echo ""
echo -e "${C_RED}==>${C_NC} Packing files into an archive..."
if [[ $release -eq 0 ]]
then
    cd "Data"
    7z a "../${RELEASE_NAME}" "../MLib.esp" "*"
else
    cp "${SKYRIM_PATH}/Tools/Archive/Archive.exe" "Archive.exe" # TODO This is really ugly
    ./Archive.exe "MLibBSAScript.txt"
    7z a "${RELEASE_NAME}" "MLib.bsa" "MLib.esp"
fi

# If we were launched in interactive mode (no parameter), wait for confirmation
if [ -z $1 ]
then
    echo "All scripts compiled, press any key to continue"
    read -s -n 1
fi
