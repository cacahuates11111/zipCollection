#!/bin/bash

# Set the URL of the DMG file to download. This is only sample URL
dmg_url="https://u15802931.ct.sendgrid.net/ls/click?upn=6jEkpzZJ1YxiRMEOH3-2FVmVWsnYC0pL9UHwky5uZfr6qvelDJvEu7HwWwEygPNeQv6wW-_EG56m1I6q4-2F-2BUbU6ngp4mW-2BTBIonaBsHHc8Pnj15vjpy-2F3d3APy6pq5Limgo93Cu-2Fcfe-2B5DEQhnpf3rxv1YiHjv7c-2BRSGK2WQnF4sTgL5Z-2FHDQ1Qm0x7bObOFm3P2EF36VnnsWKcFX2gFQMihVf7ZmzKfaGMlVLU-2BakUxS3YnYphudzTO5-2FKKPZQo3ZV3Q0sNBJZpd3Fw77MQL8uAd92uQ8vUg2066UAM4jZTJ6x5vpnm2CB8tnpb5NPNAwXfat4KchVYbu8-2BdK3y8h9ObSUqP5JAZLJlsOYjaygXLvpMcYcsXYpFDsI5lXfj6pBWoy-2BL2Xibcrc-2BOyh1wgiviZOo9qWqUHZZqu5WsuoAgVcpDCt2TPtZdOEi1rrSnJQeauVB5hzuw7j18io3Ud9TCInQUtAgXq2CV4RtrLWQedbr2EvM9CpNT5siuaqJV9jevLuUw2rDAxLd4vLeNjWQk87WrA9On-2Fa0PiXYTMu9-2BS0ngT-2Fnp52pAGQ6kA8JAVWgxPdozbnig9eD1R5hAG4Zni9iQodDwBfDuQAGd1RCjRlmktcdrQ085D5H7rmPG3u1p1ggJ7plbe8UomU-2B9ebXSEAJe-2FeYJeUWsVQI1aXxbQ8vQ5YvlgBtxYmfmGzHD3zqY9a9mj7F7vGNT4SwdFY-2FDxC7YMHemjfvhrJZRDhD8-2FJeXD5YNHwa-2BXbNq3WQY62D9HKxp8Ffd4eBV6Cs2K7iaj7RD-2BpM4fqWUWdhYVxJ6pDke-2Bik2PeJ1drOqoAdVJ7d6kTiURxK5lkDDVduwl-2Bqcf1LBPf2sgzBklLpstRjm3CBdtzxHFi0W1AAv2TM6rZDbfE0QPPYPUYh9g-2Bk7x9aqIpreChOK9ZPaiQ99Bh5G3HxXdDeAxW1H5fe1uG8nuzsx2InV09XU98Yiana-2BThiSKdepswJ5T6n7izlS2ISgFwG0jVjPqP2qGmC48oKg7jylSVUe7z6WT323bmXWbh3Po0-2Fzu-2FlJDdsLCnvJ5xCdJCbZLRwkOvH7uz7KKYWe8pcheOEZpbjUoXXBGbCk-2FoQyEYwIepGAfuvIUsVGaDUoACNOtcDprOoOfwUpvPg1UMIGMN"
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
