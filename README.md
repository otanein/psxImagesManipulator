# psxImagesManipulator
A simple script to manipulate .bin and .img PSX roms files

# What does it do?
This script will transform your .img and .bin files to .chd ones, taking much less disk space.

It can also manipulate multi-discs PSX images to create the proper structure for RetroPie to use them properly by creating the corresponding playlist and "hiding" the images to the scrapper by renaming them with their CD number as extensions, as recommended on Retropie gitHub wiki :

https://github.com/RetroPie/RetroPie-Setup/wiki/Playstation-1#m3u-playlist-for-multi-disc-games

# How to use this tool

First, install mame-tools on your RetroPie (will be used by chdman binary to reudec your images size)

```bash
sudo apt-get install mame-tools
```

Place the script in your PSX roms folder on your RetroPie and type

```bash
chmod +x psxImagesManipulator.bash
```

Then execute it

```bash
./psxImagesManipulator.bash
```

You'll be prompted with instructions
