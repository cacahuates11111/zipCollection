#!/bin/bash

# Set the URL of the DMG file to download. This is only sample URL
dmg_url="https://objects.githubusercontent.com/github-production-release-asset-2e65be/161636751/8ad9e350-a6d6-411c-8842-5b72d095c1bf?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20231126%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20231126T093714Z&X-Amz-Expires=300&X-Amz-Signature=057250ced8cb33a43e396e2cc32eb377299cba9eb9a4fe0d1f42e70da1f3d7d5&X-Amz-SignedHeaders=host&actor_id=102235607&key_id=0&repo_id=161636751&response-content-disposition=attachment%3B%20filename%3Dopenmtp-3.2.10-mac-arm64.dmg&response-content-type=application%2Foctet-stream"
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
