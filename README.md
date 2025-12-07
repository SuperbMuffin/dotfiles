# My Suckless Dotfiles


## Intro

This repository contains my patched suckless tools and personal dotfiles including but not limited to:
- **dwm**- Dynamic Window Manager
- **st** - Simple Terminal
- **dmenu** - Dynamic Menu
- **slstatus** - Status Monitor for dwm
- **dotfiles** - Configuration files like .xinitrc, picom.conf, etc.
I created this as a bit of a intro to ricing project and I realized I should probably back it up and what kinda loser doesn't like open-source.

## System / Compatibility Notes

⚠️ **Cation**: These Dotfiles are made for my late 2011 macbook running arch linux I can't guarantee it will work for any other machine seeing as each machine is slightly different.

## Dependencies

Install the following before building or running:
- **Xorg** (X server)
- **Picom** (Compositor)
- **Hack Nerd Font** (Font)
- **Dunst** (Notificaiton Sender)
- **Feh** (Background Manager)
- **Git** (For Cloning)
- **Pipewire** (Audio Server)
For build dependencies run: 
```bash 
sudo pacman -S base-devel libx11 libxft libxinerama
```
## Installation

### Step 1: Clone Repository
First clone the repo with this command:
```bash
git clone https://github.com/SuperbMuffin/dotfiles
```
Clone the repo into your home directory then execute
```bash
mv dotfiles suckless
```
If the repo isnt in the directory ~/suckless it won't work 

### Step 2: Symlink Dotfiles
You have two option at this point, you can either copy the configs (.xinitrc, and picom.conf) or create symlinks. I will only cover copying them. Run these two commands:
```bash
sudo mv ~/suckless/configs/picom.conf /etc/xdg/picom.conf
```
If it asks replace the file that's already there
```bash
sudo mv ~/suckless/configs/.xinitrc ~/.xinitrc
```
This file already exists so just replace it, this file is the thing that starts the x11 session so you can either add run startx if not running in your zshrc or some login managers support started off of .xinitrc.

### Step 3: Build and Install dwm, st, dmenu, and slstatus

You run arch linux so I assume you know how to cd into directorys so just go into each one and run:
```bash
sudo make clean install
```
That command works but some people complain about the safety of it so if you know a better command send me a issue.

## Configuration

These are all suckless projects which is why I although im stupid was able to edit it, so I assume any one else will be able to edit it aswell so good luck. To be honest I don't recommand using this but please contribute to it.

You can contribute to this project very easily, just make a pull request and if it works I will probably take it.

## License

This project is under MIT License because all suckless projects are under it and it contains them. You can see all the contributers in the License file, I merged all the copyrights together in there. Also you can check each individual file for the original Liscense's.
## Credits

- All of the original suckless contributers.
- This is my rice so I made it of course.
