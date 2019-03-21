# Overview of WhatApp Message Recovery

Whatsapp is a communication and messaging application owned by Facebook. It stores old messages in encryted databases in a folder in its data directory. We were unable to find the key used by the app to decrypt and display messages to the user.

## Whats app on Jessie Pinkmans phone 

In the data image, running a find for whatsapp reveals:

```
./media/0/Android/data/com.whatsapp
./media/0/Android/data/com.whatsapp/cache/SSLSessionCache/pps.whatsapp.net.443
./media/0/Android/data/com.whatsapp/cache/SSLSessionCache/mmg-fna.whatsapp.net.443
./media/0/Android/data/com.whatsapp/cache/SSLSessionCache/mmg.whatsapp.net.443
./media/0/WhatsApp
./media/0/WhatsApp/Media/WhatsApp Audio
./media/0/WhatsApp/Media/WhatsApp Animated Gifs
./media/0/WhatsApp/Media/WhatsApp Voice Notes
./media/0/WhatsApp/Media/WhatsApp Video
./media/0/WhatsApp/Media/WhatsApp Images
./media/0/WhatsApp/Media/WhatsApp Documents
./media/0/WhatsApp/Media/WhatsApp Profile Photos
./media/0/WhatsApp/Media/WhatsApp Stickers
./data/com.whatsapp
./data/com.whatsapp/files/Logs/whatsapp.log
./data/com.whatsapp/files/Logs/whatsapp-2018-05-16.1.log.gz
./data/com.whatsapp/shared_prefs/com.whatsapp_preferences.xml
./data/com.whatsapp/databases/_jobqueue-WhatsAppJobManager
./data/com.whatsapp/databases/_jobqueue-WhatsAppJobManager-journal
./app/com.whatsapp-1
./app/com.whatsapp-1/lib/arm64/libwhatsapp.so
./dalvik-cache/profiles/com.whatsapp
```

## Finding the meddage database

In ```./media/0/WhatsApp/Databases/``` is the file ```msgstore.db.crypt12```, the database is encryted and requries some key to read messages in. We were unable to find how to decrypt the mesasges in the database. 

## Media used by Whatsapp 

In ```./media/0/WhatsApp/Media/``` there are some image .jpg giles and audio .opus files. These were considered with other image and audio files. 