# Explodex
This project is an assignment from AUT's Software Devlpment Practices (COMP602). Our project is a minesweeper game that features both the base game and a expanded version of the game that includes new obsticales and power ups.

## Authors: 
Product Owner: Kimi Realon  
Scrum Master: Flynn Wilson  
Developer: Joaquin Fallar  
Developer: Samuel Kidane  
Developer: Theo Cooks 

## Build Insructions
To build our game, you need to have Godot 4.4.1 installed. You can play the game either in the editor using the play button or by clicking export within the editor. After clicking export you select "Add" where you can configure the platform you are exporting too. There is an option for android, but this should be ignored as our game does't have touch controls configured, for the smoothest playing experience we recommend you build the game for windows.

Our leaderboard is a python API, we do not currently have the API hosted so to use any of its functionality this script must be run in python 3.11 or later. On my own computer, this script only works if you run it directly from the directory it resides in, trying to run the script through quick access, or windows search may result in incorrect behavior, I believe this is because the script uses relative paths but I'm not 100% sure.

The leaderboard script relies on several python modules that need to be installed for it to function correctly, these being uvicorn, pydantic, fastapi and aiofiles.
