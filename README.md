# ArkSaves
Powershell script to backup save files for the game Ark Survival Ascended

## Location

Drop the powershell script in your Ark Survival Ascended installation directory. E.g. `..\steamapps\common\ARK Survival Ascended`

## Usage

Instead of starting Ark directly, right-click the script and "Run with Powershell."

## Safety

In general it's a bad idea to run some random dude's script you found on the internet. Please read the script as best you can and confirm for yourself that there are now security ramifactions.

## What It Does

Every time the main save file is saved for each of your arks, it will generate a copy of that file with "ArkSaves" in the filename. This puts it outside of Ark's normal save system.  By default the script will only keep the last 50 backups in order to save space on your machine. You can modify this directly in the script if you'd like more or less.

![image](https://github.com/crmckenzie/ArkSaves/assets/947569/9d6e4154-8296-4311-ac44-6dfe986346b1)


## Why I wrote this

200+ hours into my single player save, I opened the game and my mods had not loaded correctly. When Ark opens it reads from the file in `<ARK NAME>\<ARK NAME>_WP.ark`. When it closes, it saves again (in my case saving the missing structures and dinos that were now part of my world) and writes the changes to `<ARK NAME>_WP_AntiCorruptionBackup.bak`.  When you initiate a manual save it just overrites the main save file instead of creating a backup. Ark Survival Ascended currently has a bug in which single player saves are not happening automatically on a regular basis, so even though I was manually saving regularly, there was no way to recover my game.

With this script I will get a new copy of the main save file every time I manually save from within the game.
