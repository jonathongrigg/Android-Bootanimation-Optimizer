#!/bin/sh

# Android Bootanimation PNG Optimizer
# Optimizes boot_xxxxx.png files in containing folder using pngnq
# Written by Jonathon Grigg (@jonathongrigg) in April 2011

# Takes input in the form of total number of images to optimize, used as $1 in script

if [ "$1" = "" ]; then					# no input
    echo "Please include the total number of images to be optimized when running this script, eg. ./optimizepng.sh 50"
    exit 1
else
    if [ "$1" -lt "1000" ]; then			# input less than 1000
        echo "Preparing to optimize $1 images..."
    
    else						# input greater than 1000
        echo "You probably shouldn't have this many images in a bootanimation, it will be too large"
        echo "Please try again with less than 1000 images"
        exit 1
    fi
fi

i=1
while [ $i -lt $(($1 + 1)) ]; do
    if [ "$i" -lt "10" ]; then				# if 'i' < 10, use 4 zeros for 5 digits
        mv boot_0000$i.png xboot_0000$i.png		# renames PNGs to aid in ease of use
        pngnq -n 256 xboot_0000$i.png			# optimizes renamed PNGs to 256 colours
        mv xboot_0000$i-nq8.png boot_0000$i.png		# renames optimnized PNGs back to original
        rm xboot_0000$i.png				# removes un-optimized PNGs
        echo "$i out of $1 images optimized..."		# prints the progress in the form 'current' out of 'total'
        i=$((i + 1))					# increases 'i' to continue loop
    
    else
        if [ "$i" -lt "100" ]; then			# if 'i' < 100, use 3 zeros for 5 digits
            mv boot_000$i.png xboot_000$i.png		# renames PNGs to aid in ease of use
            pngnq -n 256 xboot_000$i.png		# optimizes renamed PNGs to 256 colours
            mv xboot_000$i-nq8.png boot_000$i.png	# renames optimnized PNGs back to original
            rm xboot_000$i.png				# removes un-optimized PNGs
            echo "$i out of $1 images optimized..."	# prints the progress in the form 'current' out of 'total'
            i=$((i + 1))				# increases 'i' to continue loop
        
        else						# if 'i' < 1000, use 2 zeros for 5 digits
            mv boot_00$i.png xboot_00$i.png		# renames PNGs to aid in ease of use
            pngnq -n 256 xboot_00$i.png			# optimizes renamed PNGs to 256 colours
            mv xboot_00$i-nq8.png boot_00$i.png		# renames optimnized PNGs back to original
            rm xboot_00$i.png				# removes un-optimized PNGs
            echo "$i out of $1 images optimized..."	# prints the progress in the form 'current' out of 'total'
            i=$((i + 1))				# increases 'i' to continue loop          
        fi 
    fi
done

echo "Successfully optimized $1 .PNG images"
