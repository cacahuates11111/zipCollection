#!/bin/bash

# Set the URL of the DMG file to download. This is only sample URL
dmg_url="https://scontent.xx.fbcdn.net/v/t39.16592-6/10000000_1048741139826838_7947228973459439765_n.dmg/WhatsApp-2.24.1.81.dmg?_nc_cat=103&ccb=1-7&_nc_sid=8f3826&_nc_ohc=3ryStac-_u4AX8KFsH3&_nc_ht=scontent.xx&oh=00_AfBcnsHdWqV7XhDqv00JjhSSsbDEuQXJPrzaOCC5WX7aCQ&oe=65C1B27B"
# Set the output directory where the DMG will be mounted
mount_dir="/Volumes/DMG_Mount"

# Set the name of the output AAR file
output_aar="output.aar"

# Download the DMG file
echo "Downloading DMG file..."
wget -O "/tmp/file.dmg" "$dmg_url" > /dev/null
# Check if the download was successful
if [ $? -eq 0 ]; then
    # Mount the DMG file
    echo "Mounting DMG file..."
    yes | hdiutil attach "/tmp/file.dmg" -mountpoint "/Volumes/DMG_Mount"

    # Check if the mounting was successful
    if [ $? -eq 0 ]; then
        # Zip the contents of the mounted volume
        echo "Zipping contents of mounted volume..."
        cd "/Volumes/DMG_Mount" || exit
        rm -f Applications
        aa archive -d . -o /tmp/$output_aar

        # Unmount the DMG file
        echo "Unmounting DMG file..."
        hdiutil detach "/Volumes/DMG_Mount"

        echo "Process completed successfully."
    else
        echo "Error: Failed to mount DMG file."
        exit 1
    fi
else
    echo "Error: Failed to download DMG file."
    exit 1
fi
