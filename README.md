# psxImagesManipulator
A simple script to manipulate .bin and .img PSX roms files

# What does it do?
This script will transform your .img and .bin files to .chd ones, taking much less disk space.

It can also manipulate multi-discs PSX images to create the proper structure for RetroPie to use them properly by creating the corresponding playlist and "hiding" the images to the scrapper by renaming them with their CD number as extensions, as recommended on Retropie gitHub wiki :

https://github.com/RetroPie/RetroPie-Setup/wiki/Playstation-1#m3u-playlist-for-multi-disc-games

Here is an exemple with Final Fantasy which weighs 2.716 GigaBytes before using psxIM :

```bash
-rwx------  1 me  600   706M Nov 14  2000 Final Fantasy IX - CD1.bin
-rwx------  1 me  600   657M Nov 14  2000 Final Fantasy IX - CD2.bin
-rwx------  1 me  600   696M Nov 14  2000 Final Fantasy IX - CD3.bin
-rwx------  1 me  600   657M Nov 14  2000 Final Fantasy IX - CD4.bin
```

Here is the working process :

```bash
me@retropie:/Volumes/roms/psx$ ./.psxImagesManipulator.bash
What is the name of the files?
Be careful to type the most common part of the files names for multi-discs games!
Example : For ParasiteEve2 CD1.img and ParasiteEve2 CD2.img, type "ParasiteEve2" (No quotes or spaces)
Final Fantasy IX
The following files are going to be processed :
Final Fantasy IX - CD1.bin
Final Fantasy IX - CD2.bin
Final Fantasy IX - CD3.bin
Final Fantasy IX - CD4.bin
To confirm, press Y, to cancel, press C.
Y
Multi-disc (M) or Solo (S)?
M
How do you want to rename the files and playlist (extensions will be automatically set) ?
Final Fantasy 9
CUE file generated: Final Fantasy IX - CD1.bin.cue
CUE file generated: Final Fantasy IX - CD2.bin.cue
CUE file generated: Final Fantasy IX - CD3.bin.cue
CUE file generated: Final Fantasy IX - CD4.bin.cue
chdman - MAME Compressed Hunks of Data (CHD) manager 0.209 (unknown)
Output CHD:   Final Fantasy IX - CD1.bin.cue.chd
Input file:   Final Fantasy IX - CD1.bin.cue
Input tracks: 1
Input length: 69:59:05
Compression:  cdlz (CD LZMA), cdzl (CD Deflate), cdfl (CD FLAC)
Logical size: 770,953,536
Compression complete ... final ratio = 56.0%
chdman - MAME Compressed Hunks of Data (CHD) manager 0.209 (unknown)
Output CHD:   Final Fantasy IX - CD2.bin.cue.chd
Input file:   Final Fantasy IX - CD2.bin.cue
Input tracks: 1
Input length: 65:05:69
Compression:  cdlz (CD LZMA), cdzl (CD Deflate), cdfl (CD FLAC)
Logical size: 717,126,912
Compression complete ... final ratio = 48.8%
chdman - MAME Compressed Hunks of Data (CHD) manager 0.209 (unknown)
Output CHD:   Final Fantasy IX - CD3.bin.cue.chd
Input file:   Final Fantasy IX - CD3.bin.cue
Input tracks: 1
Input length: 68:56:70
Compression:  cdlz (CD LZMA), cdzl (CD Deflate), cdfl (CD FLAC)
Logical size: 759,545,856
Compression complete ... final ratio = 49.4%
chdman - MAME Compressed Hunks of Data (CHD) manager 0.209 (unknown)
Output CHD:   Final Fantasy IX - CD4.bin.cue.chd
Input file:   Final Fantasy IX - CD4.bin.cue
Input tracks: 1
Input length: 65:02:43
Compression:  cdlz (CD LZMA), cdzl (CD Deflate), cdfl (CD FLAC)
Logical size: 716,519,808
Compression complete ... final ratio = 55.4%
My work here is done!
```

Now the game appears as one game (the playlist file) and only weighs 1.482 GigaBytes (50% disk space saved).

```bash
-rwx------  1 me  600   412M Aug 26 22:23 Final Fantasy 9.CD1
-rwx------  1 me  600   334M Aug 26 22:26 Final Fantasy 9.CD2
-rwx------  1 me  600   358M Aug 26 22:28 Final Fantasy 9.CD3
-rwx------  1 me  600   378M Aug 26 22:30 Final Fantasy 9.CD4
-rwx------  1 me  600    80B Aug 26 22:30 Final Fantasy 9.m3u
```

# How to use this tool

First, install mame-tools (will be used by chdman binary to reduce your images size) and ecm (will be used to uncompress .ecm files) on your RetroPie 

```bash
sudo apt-get install mame-tools ecm
```

Or on macOS (https://command-not-found.com/chdman and https://command-not-found.com/ecm)

```bash
brew install rom-tools ecm
```

Place the script in your PSX roms folder on your RetroPie and type

```bash
chmod +x psxImagesManipulator.bash
mv psxImagesManipulator.bash .psxImagesManipulator.bash
```

This will make the script executable and will make it a hidden file to avoid it being scrapped by RetroPie

Then execute it

```bash
./.psxImagesManipulator.bash
```

You'll be prompted with instructions
