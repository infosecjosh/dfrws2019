# Analysis of Jessie Pinkman’s Samsung phone
  
  File/Folder: Samsung GSM_SM-G925F Galaxy S6 Edge.7z
  
  SHA256: ae83b8ec1d4338f6c4e0a312e73d7b410904fab504f7510723362efe6186b757
  
## Download and verify the integrity of downloaded artifact

First we downloaded and verified the integrity of the downloaded artifact to the SHA256 hash provided by the challenge.
```
# sha256sum Samsung\ GSM_SM-G925F\ Galaxy\ S6\ Edge.7z 
ae83b8ec1d4338f6c4e0a312e73d7b410904fab504f7510723362efe6186b757  Samsung GSM_SM-G925F Galaxy S6 Edge.7z
```

## Extract the 7zip file contents for analysis

During the next step we extracted the compressed 7zip file and began looking at its contents.

```
# mkdir samsung_galaxy_s6
# 7z x Samsung\ GSM_SM-G925F\ Galaxy\ S6\ Edge.7z -osamsung_s6/

7-Zip [64] 9.20  Copyright (c) 1999-2010 Igor Pavlov  2010-11-18
p7zip Version 9.20 (locale=en_US.UTF-8,Utf16=on,HugeFiles=on,2 CPUs)

Processing archive: Samsung GSM_SM-G925F Galaxy S6 Edge.7z


Extracting  blk0_sda.bin
Extracting  blk16_sdb.bin
Extracting  blk32_sdc.bin
Extracting  procdata.zip

Everything is Ok

Files: 4
Size:       31999719108
Compressed: 7109827923

```
Then we listed the extracted files.

```
# ls samsung_s6
blk0_sda.bin  blk16_sdb.bin  blk32_sdc.bin  procdata.zip
```

Then we ran file against the contents to attempt to determine the filetypes.

```
# file *
blk0_sda.bin:  DOS/MBR boot sector; partition 1 : ID=0xee, start-CHS (0x0,0,0), end-CHS (0x0,0,0), startsector 1, 7810047 sectors, extended partition table (last)
blk16_sdb.bin: data
blk32_sdc.bin: data
procdata.zip:  Zip archive data, at least v2.0 to extract
```


Then for each of the blk* files we ran the mmls command to display the partition layout of a volume system.  

run mmls against contents
```
$ mmls blk0_sda.bin
GUID Partition Table (EFI)
Offset Sector: 0
Units are in 4096-byte sectors

      Slot      Start        End          Length       Description
000:  Meta      0000000000   0000000000   0000000001   Safety Table
001:  -------   0000000000   0000001023   0000001024   Unallocated
002:  Meta      0000000001   0000000001   0000000001   GPT Header
003:  Meta      0000000002   0000000005   0000000004   Partition Table
004:  000       0000001024   0000002047   0000001024   BOTA0
005:  001       0000002048   0000003071   0000001024   BOTA1
006:  002       0000003072   0000008191   0000005120   EFS
007:  003       0000008192   0000010239   0000002048   PARAM
008:  004       0000010240   0000017407   0000007168   BOOT
009:  005       0000017408   0000026111   0000008704   RECOVERY
010:  006       0000026112   0000028159   0000002048   OTA
011:  007       0000028160   0000038911   0000010752   RADIO
012:  008       0000038912   0000039167   0000000256   TOMBSTONES
013:  009       0000039168   0000039423   0000000256   DNT
014:  010       0000039424   0000039615   0000000192   PERSISTENT
015:  011       0000039616   0000039679   0000000064   STEADY
016:  012       0000039680   0000041983   0000002304   PERSDATA
017:  013       0000041984   0000045823   0000003840   SBFS
018:  014       0000045824   0000993023   0000947200   SYSTEM
019:  015       0000993024   0001044223   0000051200   CACHE
020:  016       0001044224   0001057023   0000012800   HIDDEN
021:  017       0001057024   0007808255   0006751232   USERDATA
022:  -------   0007808256   0007810047   0000001792   Unallocated
```

```
$ mmls blk16_sdb.bin
Cannot determine partition type
```
```
$ mmls blk32_sdc.bin
Cannot determine partition type
```

```
# 7z x Samsung\ GSM_SM-G925F\ Galaxy\ S6\ Edge.7z -osamsung_s6/

7-Zip [64] 9.20  Copyright (c) 1999-2010 Igor Pavlov  2010-11-18
p7zip Version 9.20 (locale=en_US.UTF-8,Utf16=on,HugeFiles=on,2 CPUs)

Processing archive: Samsung GSM_SM-G925F Galaxy S6 Edge.7z


Extracting  blk0_sda.bin
Extracting  blk16_sdb.bin
Extracting  blk32_sdc.bin
Extracting  procdata.zip

Everything is Ok

Files: 4
Size:       31999719108
Compressed: 7109827923
```

```
# unzip procdata.zip -d procdata
Archive:  procdata.zip
 extracting: procdata/partitions
 extracting: procdata/mounts
 extracting: procdata/cpuinfo
 extracting: procdata/diskstats
 extracting: procdata/filesystems
 extracting: procdata/system
 extracting: procdata/radio
 extracting: procdata/events

```
```
# cat cpuinfo
Processor       : AArch64 Processor rev 0 (aarch64)
processor       : 0
processor       : 1
processor       : 2
processor       : 3
processor       : 4
processor       : 5
processor       : 6
processor       : 7
Features        : fp asimd aes pmull sha1 sha2 crc32
CPU implementer : 0x41
CPU architecture: AArch64
CPU variant     : 0x1
CPU part        : 0xd07
CPU revision    : 0

Hardware        : SAMSUNG Exynos7420
```

```
# cat mounts
rootfs / rootfs ro,seclabel 0 0
tmpfs /dev tmpfs rw,seclabel,nosuid,relatime,size=1371712k,nr_inodes=342928,mode=755 0 0
devpts /dev/pts devpts rw,seclabel,relatime,mode=600 0 0
proc /proc proc rw,relatime 0 0
sysfs /sys sysfs rw,seclabel,relatime 0 0
selinuxfs /sys/fs/selinux selinuxfs rw,relatime 0 0
/sys/kernel/debug /sys/kernel/debug debugfs rw,relatime 0 0
none /acct cgroup rw,relatime,cpuacct 0 0
none /sys/fs/cgroup tmpfs rw,seclabel,relatime,size=1371712k,nr_inodes=342928,mode=750,gid=1000 0 0
tmpfs /mnt tmpfs rw,seclabel,relatime,size=1371712k,nr_inodes=342928,mode=755,gid=1000 0 0
none /dev/cpuctl cgroup rw,relatime,cpu 0 0
/dev/block/platform/15570000.ufs/by-name/SYSTEM /system ext4 ro,seclabel,noatime,norecovery 0 0
/dev/block/platform/15570000.ufs/by-name/EFS /efs ext4 rw,seclabel,nosuid,nodev,noatime,discard,journal_checksum,journal_async_commit,noauto_da_alloc,data=ordered 0 0
/dev/block/platform/15570000.ufs/by-name/CACHE /cache ext4 rw,seclabel,nosuid,nodev,noatime,discard,journal_checksum,journal_async_commit,noauto_da_alloc,errors=panic,data=ordered 0 0
/dev/block/platform/15570000.ufs/by-name/USERDATA /data ext4 rw,seclabel,nosuid,nodev,noatime,discard,journal_checksum,journal_async_commit,noauto_da_alloc,data=ordered 0 0
/dev/block/platform/15570000.ufs/by-name/PERSDATA /persdata/absolute ext4 rw,seclabel,nosuid,nodev,relatime,data=ordered 0 0
/dev/block/platform/15570000.ufs/by-name/SBFS /sbfs ext4 rw,seclabel,nosuid,nodev,relatime,data=ordered 0 0
tmpfs /storage tmpfs rw,seclabel,relatime,size=1371712k,nr_inodes=342928,mode=755,gid=1000 0 0
/dev/block/platform/15570000.ufs/by-name/HIDDEN /preload ext4 ro,seclabel,nosuid,nodev,relatime,data=ordered 0 0
/data/knox/tmp_sdcard /mnt/knox sdcardfs rw,seclabel,nosuid,nodev,relatime,mask=0077 0 0
/data/knox/sdcard /mnt/knox/default/knox-emulated sdcardfs rw,seclabel,nosuid,nodev,relatime,low_uid=1000,low_gid=1000,gid=1015,multi_user,mask=0006 0 0
/data/knox/sdcard /mnt/knox/read/knox-emulated sdcardfs rw,seclabel,nosuid,nodev,relatime,low_uid=1000,low_gid=1000,gid=9997,multi_user,mask=0027 0 0
/data/knox/sdcard /mnt/knox/write/knox-emulated sdcardfs rw,seclabel,nosuid,nodev,relatime,low_uid=1000,low_gid=1000,gid=9997,multi_user,mask=0007 0 0
/data/knox/secure_fs/enc_media /mnt/shell/enc_media sdcardfs rw,seclabel,nosuid,nodev,relatime,low_uid=1000,low_gid=1000,gid=9997,multi_user,reserved=20MB 0 0
/data/media /mnt/runtime/default/emulated sdcardfs rw,seclabel,nosuid,nodev,noexec,relatime,low_uid=1023,low_gid=1023,gid=1015,multi_user,mask=0006,reserved=20MB 0 0
/data/media /storage/emulated sdcardfs rw,seclabel,nosuid,nodev,noexec,relatime,low_uid=1023,low_gid=1023,gid=1015,multi_user,mask=0006,reserved=20MB 0 0
/data/media /mnt/runtime/read/emulated sdcardfs rw,seclabel,nosuid,nodev,noexec,relatime,low_uid=1023,low_gid=1023,gid=9997,multi_user,mask=0027,reserved=20MB 0 0
/data/media /mnt/runtime/write/emulated sdcardfs rw,seclabel,nosuid,nodev,noexec,relatime,low_uid=1023,low_gid=1023,gid=9997,multi_user,mask=0007,reserved=20MB 0 0
```

```
$ cat diskstats
   1       0 ram0 0 0 0 0 0 0 0 0 0 0 0
   1       1 ram1 0 0 0 0 0 0 0 0 0 0 0
   1       2 ram2 0 0 0 0 0 0 0 0 0 0 0
   1       3 ram3 0 0 0 0 0 0 0 0 0 0 0
   1       4 ram4 0 0 0 0 0 0 0 0 0 0 0
   1       5 ram5 0 0 0 0 0 0 0 0 0 0 0
   1       6 ram6 0 0 0 0 0 0 0 0 0 0 0
   1       7 ram7 0 0 0 0 0 0 0 0 0 0 0
   1       8 ram8 0 0 0 0 0 0 0 0 0 0 0
   1       9 ram9 0 0 0 0 0 0 0 0 0 0 0
   1      10 ram10 0 0 0 0 0 0 0 0 0 0 0
   1      11 ram11 0 0 0 0 0 0 0 0 0 0 0
   1      12 ram12 0 0 0 0 0 0 0 0 0 0 0
   1      13 ram13 0 0 0 0 0 0 0 0 0 0 0
   1      14 ram14 0 0 0 0 0 0 0 0 0 0 0
   1      15 ram15 0 0 0 0 0 0 0 0 0 0 0
   7       0 loop0 0 0 0 0 0 0 0 0 0 0 0
   7       1 loop1 0 0 0 0 0 0 0 0 0 0 0
   7       2 loop2 0 0 0 0 0 0 0 0 0 0 0
   7       3 loop3 0 0 0 0 0 0 0 0 0 0 0
   7       4 loop4 0 0 0 0 0 0 0 0 0 0 0
   7       5 loop5 0 0 0 0 0 0 0 0 0 0 0
   7       6 loop6 0 0 0 0 0 0 0 0 0 0 0
   7       7 loop7 0 0 0 0 0 0 0 0 0 0 0
   8       0 sda 46956 28888 7962432 32330 5523 10172 197000 7900 1 17960 40120
   8       1 sda1 0 0 0 0 0 0 0 0 0 0 0
   8       2 sda2 0 0 0 0 0 0 0 0 0 0 0
   8       3 sda3 61 193 4016 50 18 29 376 0 0 50 50
   8       4 sda4 1 0 8 0 3 0 24 0 0 0 0
   8       5 sda5 108 6868 55808 160 0 0 0 0 0 120 160
   8       6 sda6 111 7057 57344 20 0 0 0 0 0 10 20
   8       7 sda7 0 0 0 0 0 0 0 0 0 0 0
   8       8 sda8 160 9898 80464 30 0 0 0 0 0 30 30
   8       9 sda9 0 0 0 0 0 0 0 0 0 0 0
   8      10 sda10 0 0 0 0 0 0 0 0 0 0 0
   8      11 sda11 0 0 0 0 0 0 0 0 0 0 0
   8      12 sda12 2 3 40 0 0 0 0 0 0 0 0
   8      13 sda13 12 25 296 20 15 6 168 70 0 60 90
   8      14 sda14 4 25 232 0 6 1 56 0 0 0 0
   8      15 sda15 21534 1206 2841128 14560 0 0 0 0 0 6800 14490
 259       0 sda16 14 10 192 10 7 3 80 0 0 10 10
 259       1 sda17 19 17 288 0 0 0 0 0 0 0 0
 259       2 sda18 24919 3586 4922528 17480 4161 10133 196296 6580 1 11700 24020
   8      16 sdb 1 0 8 0 0 0 0 0 0 0 0
   8      32 sdc 1 0 8 0 0 0 0 0 0 0 0
 253       0 vnswap0 0 0 0 0 0 0 0 0 0 0 0
```

We wrote a script called [mountem.sh](./utils/mountem.sh) to mount the USERDATA partition.  You will need to clone the dfrws2019 repo and then run the command below.
```
./utils/mountem.sh
```

Jessie's phone had the Arlo mobile app installed. The pictures we discovred on the phone that were captured by the arlo camera were found in `userdata/data/com.netgear.android`



  need to look more into wink databaes files /mnt/Samsung/data/com.quirky.android.wink.wink/databases/persistenceDB
  
  "SuperLab Kitchen Nest Protect (LabSmoker)""
  "SuperLab Tabletting Camera"

found a lot in the Chrome sqlite3 db

```
log2timeline.py --parsers sqlite ~/chromehist.plaso /mnt/user
```

```
INSERT INTO "urls" VALUES(1,'https://inbox.google.com/accounts/SetOSID?authuser=0&continue=https%3A%2F%2Finbox.google.com%2F%3Fpli%3D1&osidt=ALWU2cuzXI8vadmxJJkzpn2ArZ6rTOMW63fT9spEisIFAuNHFBl_nGyns5Uv1S2TleaGGJY6HYgfc9VMYN67A5-ms9-eK4xS_KoFhwNzmtMWYjOKFkmebLFs3Ari8tCm7Kbk2adYtJ8u','Inbox – jpinkman2018@gmail.com',1,0,13165668726083260,0);
INSERT INTO "urls" VALUES(2,'https://accounts.google.com/ServiceLogin?passive=1209600&osid=1&continue=https://inbox.google.com/&followup=https://inbox.google.com/&authuser=0','Inbox – jpinkman2018@gmail.com',1,0,13165668726083260,0);
INSERT INTO "urls" VALUES(3,'https://alexa.amazon.com/?openid.assoc_handle=amzn_dp_project_dee&aToken=Atza%7CIwEBIIo1qQmNeh1tckOQMNJw2UWhwTlcdMnCwqsat7buVIO9Z8ovh1hva51ZZSOqcDhEjoqPs7VrqxZDVGZMQBEOG-pJPeYKudyn5fV3_c9_CWEx2E1--jvCaMpLU3_dpcWesP7FWfKjJbaQ6md579RDvG-dQ3lIzWI1kUDH1pppIibn1Q0zCOzDo9eS0CB2KaOyKV3H7hAzIfGsQyfvI74y_VT1XCbiqPTP341EvX98vGpm9wFub22VWinIPquikUVCUbV2rNfejJ1ch_JfAtVN2E5xNK-8R2b388xZxCjueCi_PEdRCyzBjXkFAseb-pWQ9XywTTRpa_yd07x12m5bv5z8E_uAqajLv-eV6yQmlYK1i9uGuKZ8OVI7xoV94A1_qTU68Oek_6XMq6jdnGfFcRYG&openid.claimed_id=https%3A%2F%2Fwww.amazon.com%2Fap%2Fid%2Famzn1.account.AGGMG4DRSURCQ7QT4TCLAINUZT2Q&openid.identity=https%3A%2F%2Fwww.amazon.com%2Fap%2Fid%2Famzn1.account.AGGMG4DRSURCQ7QT4TCLAINUZT2Q&openid.mode=id_res&openid.ns=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0&openid.op_endpoint=https%3A%2F%2Fwww.amazon.com%2Fap%2Fsignin&openid.response_nonce=2018-03-27T08%3A26%3A39Z-6673743547905493514&openid.return_to=https%3A%2F%2Falexa.amazon.com%2F&openid.signed=assoc_handle%2CaToken%2Cclaimed_id%2Cidentity%2Cmode%2Cns%2Cop_endpoint%2Cresponse_nonce%2Creturn_to%2Cns.pape%2Cpape.auth_policies%2Cpape.auth_time%2Csigned&openid.ns.pape=http%3A%2F%2Fspecs.openid.net%2Fextensions%2Fpape%2F1.0&openid.pape.auth_policies=http%3A%2F%2Fschemas.openid.net%2Fpape%2Fpolicies%2F2007%2F06%2Fnone&openid.pape.auth_time=2018-03-27T08%3A26%3A39Z&openid.sig=TMLVwLuyUWnOzHYVRJoxO4s7MD%2Bujs5iMuVYF%2BTDnD0%3D&serial=&','Amazon Alexa',1,0,13166612808855851,0);
INSERT INTO "urls" VALUES(4,'https://alexa.amazon.de/spa/index.html','Amazon Anmelden',1,0,13166613117577335,0);
INSERT INTO "urls" VALUES(5,'https://www.amazon.de/ap/signin?showRmrMe=1&openid.return_to=https%3A%2F%2Falexa.amazon.de%2Fspa%2Findex.html&openid.identity=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select&openid.assoc_handle=amzn_dp_project_dee_de&openid.mode=checkid_setup&openid.claimed_id=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select&openid.ns=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0&','Amazon Anmelden',1,0,13166613117577335,0);
INSERT INTO "urls" VALUES(6,'https://alexa.amazon.com/?openid.assoc_handle=amzn_dp_project_dee&aToken=Atza%7CIwEBIJJBWDVSaes5SCT-ycC3_FCQJA9hGDFDD3Hbsvr8Jq_OQ2q0m7pufLgqrkV3o7rpB_MXBu-zdaTk9uLoEaP7WKc_FRV5sBGjr3O7TqJsZpGn6QsyLVNZlyPM2G--EM4SU67eot5cHUqT3bfOH5yTg6Xf6KsraRmpFVPiyRoM0TFff1itGAiOdBb0UnvvPgRFBKSxrBMwwyYhVTrwzpHH_PkMTzOwO8cLWcayk2PI9uCEBesIJZzY8rHYuHEAuKeacM_VCiTbO0p-gtT2L0sZF98k6ObF802cRkxPPjBrHbSnOpaXUGk0IkHtQPMAMxcAmUSb_6dhlvnHY4TNVIJD8cWYqfqy-kHgHrUCuzd2ejQqRtcadGrCdUOcV0EAHfUGadDTHxypo1X2-6dbEm3GeCVT&openid.claimed_id=https%3A%2F%2Fwww.amazon.com%2Fap%2Fid%2Famzn1.account.AGGMG4DRSURCQ7QT4TCLAINUZT2Q&openid.identity=https%3A%2F%2Fwww.amazon.com%2Fap%2Fid%2Famzn1.account.AGGMG4DRSURCQ7QT4TCLAINUZT2Q&openid.mode=id_res&openid.ns=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0&openid.op_endpoint=https%3A%2F%2Fwww.amazon.com%2Fap%2Fsignin&openid.response_nonce=2018-03-27T08%3A31%3A58Z-8098002837425949003&openid.return_to=https%3A%2F%2Falexa.amazon.com%2F&openid.signed=assoc_handle%2CaToken%2Cclaimed_id%2Cidentity%2Cmode%2Cns%2Cop_endpoint%2Cresponse_nonce%2Creturn_to%2Cns.pape%2Cpape.auth_policies%2Cpape.auth_time%2Csigned&openid.ns.pape=http%3A%2F%2Fspecs.openid.net%2Fextensions%2Fpape%2F1.0&openid.pape.auth_policies=http%3A%2F%2Fschemas.openid.net%2Fpape%2Fpolicies%2F2007%2F06%2Fnone&openid.pape.auth_time=2018-03-27T08%3A31%3A58Z&openid.sig=fIWEFP6ghyaPGIVDrTzvdarFByjvCxXZ4nejmf4o%2BII%3D&serial=&','Amazon Alexa',1,0,13166613119608793,0);
INSERT INTO "urls" VALUES(7,'http://alexa.amazon.com/spa/index.html','Amazon Alexa',3,0,13166613119608793,0);
INSERT INTO "urls" VALUES(8,'https://www.amazon.com/ap/signin?showRmrMe=1&openid.return_to=https%3A%2F%2Falexa.amazon.com%2F&openid.identity=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select&openid.assoc_handle=amzn_dp_project_dee&openid.mode=checkid_setup&openid.claimed_id=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select&openid.ns=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0&','Amazon Alexa',3,2,13166613119608793,0);
INSERT INTO "urls" VALUES(9,'https://www.amazon.com/','Amazon.com: Online Shopping for Electronics, Apparel, Computers, Books, DVDs & more',1,1,13166613130557252,0);
INSERT INTO "urls" VALUES(10,'https://accounts.google.com/ServiceLogin?passive=1209600&osid=1&continue=https://inbox.google.com/?pli%3D1&followup=https://inbox.google.com/?pli%3D1','Accedi - Google Account',1,0,13166613272903285,0);
INSERT INTO "urls" VALUES(11,'https://inbox.google.com/?pli=1','Inbox – jpinkman2018@gmail.com',10,2,13166613287875141,0);
INSERT INTO "urls" VALUES(12,'http://play.spotify.com/','Spotify Web Player',1,1,13166614539055372,0);
INSERT INTO "urls" VALUES(13,'https://open.spotify.com/','Spotify Web Player',1,0,13166614539055372,0);
INSERT INTO "urls" VALUES(14,'https://play.spotify.com/','Spotify Web Player',1,0,13166614539055372,0);
INSERT INTO "urls" VALUES(15,'http://inbox.google.com/','Inbox by Gmail',2,2,13166618616516080,0);
INSERT INTO "urls" VALUES(16,'https://inbox.google.com/u/0/','Inbox by Gmail',1,0,13166618616516080,0);
INSERT INTO "urls" VALUES(17,'http://transmission.Pinkman.ch/','Accedi',1,1,13167773851483300,0);
INSERT INTO "urls" VALUES(18,'https://transmission.Pinkman.ch/','Accedi',1,0,13167773851483300,0);
INSERT INTO "urls" VALUES(19,'https://aai.Pinkman.ch/adfs/ls?version=1.0&action=signin&realm=urn%3AAppProxy%3Acom&appRealm=8ed200d8-b61b-e811-8977-00155d01144d&returnUrl=https%3A%2F%2Ftransmission.Pinkman.ch%2F&client-request-id=21899236-D019-0000-29A5-892119D0D301','kettu',3,0,13167773861186538,0);
INSERT INTO "urls" VALUES(20,'https://www.google.ch/search?q=iptables+interface&oq=sslsplit+interface&aqs=chrome..69i57j69i60.6379j0j7&sourceid=chrome&ie=UTF-8','iptables interface - Cerca con Google',1,1,13168430307774963,0);
INSERT INTO "urls" VALUES(21,'http://172.16.42.1:1471/','WiFi Pineapple',5,3,13168431184051736,0);
INSERT INTO "urls" VALUES(22,'https://store.nest.com/ch/it/account/orders','Page Not Found',2,1,13168440432902206,0);
INSERT INTO "urls" VALUES(23,'https://store.nest.com/ch/fr/account/subscriptions/3a592060-26d1-11e8-83b6-0e2d565eed46','Nest Store',5,1,13168440984198267,0);
INSERT INTO "urls" VALUES(24,'http://regex101.com/','Online regex tester and debugger: PHP, PCRE, Python, Golang and JavaScript',1,1,13168955775809820,0);
INSERT INTO "urls" VALUES(25,'https://regex101.com/','Online regex tester and debugger: PHP, PCRE, Python, Golang and JavaScript',1,0,13168955775809820,0);
INSERT INTO "urls" VALUES(26,'https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html','Install Elasticsearch with Docker | Elasticsearch Reference [6.2] | Elastic',2,1,13169202241936849,0);
INSERT INTO "urls" VALUES(27,'http://moodle.unil.ch/','MoodleUnil: Login al sito',1,1,13169207966892691,0);
INSERT INTO "urls" VALUES(28,'https://moodle.unil.ch/login/index.php','MoodleUnil: Login al sito',1,0,13169207966892691,0);
INSERT INTO "urls" VALUES(29,'http://office.com/','Not available',1,1,13169225636829217,1);
INSERT INTO "urls" VALUES(30,'https://nest.com/it/','Nest | Crea una casa connessa',4,0,13170342562195097,0);
INSERT INTO "urls" VALUES(31,'https://nest.com/','Nest | Crea una casa connessa',4,0,13170342562195097,0);
INSERT INTO "urls" VALUES(32,'http://nest.com/','Nest | Crea una casa connessa',5,5,13170342562195097,0);
INSERT INTO "urls" VALUES(33,'http://nest.com/it/','Nest | Crea una casa connessa',4,0,13170342562195097,0);
INSERT INTO "urls" VALUES(34,'https://arlo.netgear.com/','Arlo Smart Home Security Cameras | Home Monitoring | Arlo by NETGEAR',5,0,13170342822842799,0);
INSERT INTO "urls" VALUES(35,'http://arlo.netgear.com/','Arlo Smart Home Security Cameras | Home Monitoring | Arlo by NETGEAR',3,3,13170342822842799,0);
INSERT INTO "urls" VALUES(36,'http://alexa.amazon.com/','Amazon Alexa',4,4,13170846768702842,0);
INSERT INTO "urls" VALUES(37,'https://mail.google.com/mail/','Inbox – jpinkman2018@gmail.com',5,0,13170846884389653,0);
INSERT INTO "urls" VALUES(38,'http://gmail.com/','Inbox – jpinkman2018@gmail.com',3,3,13170846884389653,0);
INSERT INTO "urls" VALUES(39,'https://inbox.google.com/','Inbox – jpinkman2018@gmail.com',11,0,13170846884389653,0);
INSERT INTO "urls" VALUES(40,'https://www.google.com/gmail/','Inbox – jpinkman2018@gmail.com',3,0,13170846884389653,0);
INSERT INTO "urls" VALUES(41,'https://gmail.com/','Inbox – jpinkman2018@gmail.com',3,0,13170846884389653,0);
INSERT INTO "urls" VALUES(42,'https://alexa.amazon.com/spa/index.html','Amazon Alexa',13,0,13170846948370113,0);
INSERT INTO "urls" VALUES(43,'http://10.20.30.1/','Pi-Pinapple',4,2,13170849361384629,0);
INSERT INTO "urls" VALUES(44,'http://10.20.30.1/accounts/login/?next=/','Pi-Pinapple',4,0,13170849361384629,0);
INSERT INTO "urls" VALUES(45,'https://www.google.ch/search?q=android+apk&oq=android+apk&aqs=chrome..69i57j35i39j0l2.4067j0j4&client=ms-android-samsung&sourceid=chrome-mobile&ie=UTF-8','android apk - Google-Suche',1,0,13170856541446672,0);
INSERT INTO "urls" VALUES(46,'https://m.apkpure.com/app','Download APP APK Android App Online - Free Pure APK Downloader',1,0,13170856548111119,0);
INSERT INTO "urls" VALUES(47,'https://m.apkpure.com/search','Search - APKPure Android App Store',1,0,13170856550052626,0);
INSERT INTO "urls" VALUES(48,'https://m.apkpure.com/search?q=Alexa','Alexa search results | APKPure.com',1,0,13170856555525013,0);
INSERT INTO "urls" VALUES(49,'https://m.apkpure.com/amazon-alexa/com.amazon.dee.app','Amazon Alexa APK Download - Free Music & Audio APP for Android | APKPure.com',1,0,13170856558095383,0);
INSERT INTO "urls" VALUES(50,'https://m.apkpure.com/amazon-alexa/com.amazon.dee.app/download?from=details','Download Amazon Alexa 2.2.208186.0 APK | APKPure.com',1,0,13170856560903504,0);
DELETE FROM sqlite_sequence;
```
  
  
```  
root@siftworkstation -> /m/samsung 
# find . -name *download*
./media/0/Android/data/com.google.android.googlequicksearchbox/files/download_cache
./media/0/Android/data/flipboard.boxer.app/files/image-download-cache
./media/0/Android/data/com.android.providers.downloads
./media/0/Android/data/com.google.android.tts/files/download_cache
./data/com.google.android.configupdater/files/downloads
./data/com.android.providers.downloads
./data/com.android.providers.downloads/cache/downloadfile.bin
./data/com.android.providers.downloads/databases/downloads.db
./data/com.android.providers.downloads/databases/downloads.db-journal
./data/com.google.android.gms/cache/downloadservice
./data/com.google.android.gms/databases/downloads.db
./data/com.google.android.gms/databases/downloads.db-journal
./data/com.google.android.gms/app_download
./data/com.facebook.appmanager/databases/file_downloader
./data/com.facebook.appmanager/databases/file_downloader-journal
./data/com.facebook.appmanager/databases/downloads.db
./data/com.facebook.appmanager/databases/downloads.db-journal
./data/com.instagram.android/app_downloaded_modules
./data/com.facebook.katana/lib-xzs/libdownloadservice-jni.so
./data/com.google.android.gm/files/downloads
./data/com.google.android.apps.maps/app_offline_downloads
```
