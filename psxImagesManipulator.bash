#!/bin/bash

moveFiles()
{

IFS=$'\n'
for i in $(find . | grep -i "$GAMENAME")
do
	chmod 644 "$i"
	mv "$i" .tmp/
done

cd .tmp/

}

ecmUncompress()
{

ls *.ecm > /dev/null 2>&1

if [[ $? -eq 0 ]]; then
	for i in *.ecm
	do
		DIST=$(uname -a | awk -F " " '{ print $1 }' )
		
		if [[ $DIST==Linux ]]; then
			echo "Uncompressing ECM files, please wait..."
			ecm-uncompress *.ecm > /dev/null 2>&1 && rm -f *.ecm
		else
			if [[ $DIST==Darwin ]]; then
				echo "Uncompressing ECM files, please wait..."
				unecm *.ecm > /dev/null 2>&1 && rm -f *.ecm
			else
				false
			fi
		fi

#		if [[ -e *.bin ]] || [[ -e *.BIN ]]; then
#			rm -f *.bin *.BIN > /dev/null 2>&1
#		fi

	done
fi

}

cueGen() 
{

myarray=(`find . -maxdepth 1 -name "*.cue"`)
if [[ ${#myarray[@]} -gt 0 ]]; then 
	true
else 
    for b in *
		do
		echo $'\x02' | cmp -i 0:15 -n 1 - "$b"
		case $? in
		  0)
		    MODE=MODE2
		    ;;
		  1)
		    MODE=MODE1
		    ;;
		  *)
		    echo "Invalid file format: $b"
		    exit 1
		esac

		NAME=$(basename -- "$b")
		OUTPUT="${NAME}.cue"
		echo "FILE \"${NAME}\" BINARY
		  TRACK 01 ${MODE}/2352
		    INDEX 01 00:00:00" > "${OUTPUT}" &&
		  echo "CUE file generated: ${OUTPUT}" ||
		  echo "Failed to generate CUE file for $b"
		done
fi

}

runSolo()
{

echo "How do you want to rename the image (extension will be automatically set to .chd) ?"
read RENAME

cueGen

for i in *.cue
do
        chdman createcd -i "$i" -o "$i.chd"
done

for i in *.cue.chd
do
	mv "$i" "$RENAME".chd
done

if [[ $? -eq 0 ]]; then
	CURDIR=$(pwd | awk -F "/" '{ print $NF }')
	if [[ $CURDIR == ".tmp" ]]; then
        	rm -f *
	fi
fi

mv * ../.

echo "My work here is done!"
exit 0

}

runMulti()
{

CDNUM=0

echo "How do you want to rename the files and playlist (extensions will be automatically set) ?"
read RENAME

cueGen

for i in *.cue
do
        chdman createcd -i "$i" -o "$i.chd"
done

for i in *.cue.chd
do
        CDNUM=$[CDNUM + 1]
	mv "$i" "$RENAME.CD$CDNUM"
done

if [[ $? -eq 0 ]]; then
	CURDIR=$(pwd | awk -F "/" '{ print $NF }')
	if [[ $CURDIR == ".tmp" ]]; then
        	rm -f *
	fi
fi

for i in *
do
        printf "$i"'%s\n' >> "$RENAME".m3u
done

mv * ../.

echo "My work here is done!"
exit 0

}

echo "What is the name of the files?
Be careful to type the most common part of the files names for multi-discs games!
Example : For ParasiteEve2 CD1.img and ParasiteEve2 CD2.img, type \"ParasiteEve2\" (No quotes or spaces)"
read GAMENAME

if [[ ! -d .tmp/ ]]; then
	mkdir .tmp/
fi

ls -1 |grep -i "$GAMENAME" > /dev/null 2>&1 ;
RETVAL=$?

if [[ $RETVAL -ne 0 ]]; then
	echo "Error : The file does not exist, is it present in your current folder?"
	exit 1
fi

FILENAME=$(find . | grep -i "$GAMENAME")

echo "The following files are going to be processed :
$(ls -1 |grep -i "$GAMENAME")
To confirm, press Y, to cancel, press C."
read CHOICE
case $CHOICE in
        Y|y)
        moveFiles
        ecmUncompress
        ;;
        C|c)
        echo "Cancelling..."
	exit 0
        ;;
        *)
        echo "Incorrect, type Y or C"
        exit 1
esac

echo "Multi-disc (M) or Solo (S)?"
read ANSWER
case $ANSWER in
        M|m)
        runMulti
        ;;
        S|s)
        runSolo
        ;;
        *)
        echo $ANSWER
        echo "Please type M or S"
        exit 1
esac
