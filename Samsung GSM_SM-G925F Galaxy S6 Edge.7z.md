# Analysis of Jessie Pinkman’s Samsung phone
  
  File/Folder: Samsung GSM_SM-G925F Galaxy S6 Edge.7z
  
  SHA256: ae83b8ec1d4338f6c4e0a312e73d7b410904fab504f7510723362efe6186b757

--------------------

Outline

* [Initial Processing and Data Extraction](#Initial-Processing-and-Data-Extraction)
* [Interesting Activity](#Interesting-Activity)


## Initial Processing and Data Extraction
  
### Download and verify the integrity of downloaded artifact

First we downloaded and verified the integrity of the downloaded artifact to the SHA256 hash provided by the challenge.
```
# sha256sum Samsung\ GSM_SM-G925F\ Galaxy\ S6\ Edge.7z 
ae83b8ec1d4338f6c4e0a312e73d7b410904fab504f7510723362efe6186b757  Samsung GSM_SM-G925F Galaxy S6 Edge.7z
```

### Extract the 7zip file contents for analysis

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

We also wrote a script that would generate a timeline using plaso if you have plaso installed on your local machine with the parser plugins and formatters that we wrote for this challenge.

```
./utils/timelinegen.sh
```

We ran the command below to list all files with the .db extension that were not created or modified in 2015.  This was helpful to focus only on files that were modified or created during particular periods while we were doing analysis.  This can also be viewed in Kibana from the log2timeline data.  This led us to look further at /mnt/userdata/data/com.google.android.gm/databases/mailstore.jpinkman2018@gmail.com.db file.  We also noticed that a large number of the files were modified and accessed 05-15-2018.  This is largely due to the way that a lot of the apps on the phone ran in the background and updated regularly.
```
find . -name *.db | xargs stat ./com.android.settings/databases/search_index.db -c "%n "Access:" %x "Modify:" %y "Change:" %z "Size:" %s" | grep -v "Create: 2015*Modify: 2015" | sort -nk 15 > ~/samsung.txt

./com.android.providers.settings/databases/settings.db Access: 2018-05-17 09:32:38.270000115 +0000 Modify: 2018-05-17 09:32:38.270000115 +0000 Change: 2018-05-17 09:32:38.270000115 +0000 Size: 0
./com.microsoft.office.excel/files/aria/offlineKVP.db Access: 2018-05-15 12:23:22.748004476 +0000 Modify: 2018-05-15 12:23:22.758004477 +0000 Change: 2018-05-15 12:23:22.758004477 +0000 Size: 201
./com.microsoft.office.powerpoint/files/aria/offlineKVP.db Access: 2018-05-15 12:01:41.578003856 +0000 Modify: 2018-05-15 12:01:41.588003856 +0000 Change: 2018-05-15 12:01:41.588003856 +0000 Size: 201
./com.microsoft.office.word/files/aria/offlineKVP.db Access: 2018-05-15 12:14:14.868004215 +0000 Modify: 2018-05-15 12:14:14.888004215 +0000 Change: 2018-05-15 12:14:14.888004215 +0000 Size: 201
./com.android.providers.contacts/databases/contacts2.db Access: 2015-12-31 23:06:54.710000184 +0000 Modify: 2015-12-31 23:06:54.720000184 +0000 Change: 2018-05-17 17:58:06.160000006 +0000 Size: 4096
./com.android.providers.contacts/databases/profile.db Access: 2015-12-31 23:06:55.030000184 +0000 Modify: 2015-12-31 23:06:55.040000184 +0000 Change: 2018-05-17 17:58:06.270000007 +0000 Size: 4096
./com.android.providers.telephony/databases/mmssms.db Access: 2015-12-31 23:07:17.570000195 +0000 Modify: 2015-12-31 23:07:17.590000195 +0000 Change: 2018-05-17 17:58:06.490000007 +0000 Size: 4096
./com.android.settings/databases/mysettings.db Access: 2015-12-31 23:07:47.250000209 +0000 Modify: 2015-12-31 23:07:47.270000209 +0000 Change: 2018-05-17 17:59:45.690000054 +0000 Size: 4096
./com.google.android.gm/databases/metadata.-958634096.db Access: 2018-05-16 00:38:01.541387204 +0000 Modify: 2018-05-16 00:38:01.561387204 +0000 Change: 2018-05-16 00:38:01.591387204 +0000 Size: 4096
./com.google.android.gms/databases/icing_mmssms.db Access: 2018-05-15 11:01:55.128002146 +0000 Modify: 2018-05-15 11:01:55.138002146 +0000 Change: 2018-05-17 17:58:35.510000020 +0000 Size: 4096
./com.google.android.gms/databases/ipa_mmssms.db Access: 2018-05-15 11:01:53.318002145 +0000 Modify: 2018-05-15 11:01:53.338002145 +0000 Change: 2018-05-15 11:01:53.368002145 +0000 Size: 4096
./com.google.android.gms/files/nearby-discovery/nearby_discovery_item_cache.db Access: 2018-05-15 11:01:55.528002146 +0000 Modify: 2018-05-17 17:58:36.700000021 +0000 Change: 2018-05-17 17:58:36.700000021 +0000 Size: 4096
./com.google.android.gms/files/nearby-discovery/nearby_discovery_scan_result_cache.db Access: 2018-05-15 11:01:55.578002146 +0000 Modify: 2018-05-17 17:58:39.730000022 +0000 Change: 2018-05-17 17:58:39.730000022 +0000 Size: 4096
./com.google.android.gsf/databases/googlesettings.db Access: 2015-12-31 23:07:01.600000187 +0000 Modify: 2015-12-31 23:07:01.610000187 +0000 Change: 2018-05-17 17:58:07.050000007 +0000 Size: 4096
./com.google.android.syncadapters.calendar/databases/timelydata.db Access: 2018-05-15 10:52:43.738001883 +0000 Modify: 2018-05-15 10:52:43.758001883 +0000 Change: 2018-05-17 17:29:44.009006730 +0000 Size: 4096
./com.microsoft.skydrive/files/QTMetadata.db Access: 2018-05-15 12:33:50.708004776 +0000 Modify: 2018-05-15 12:33:50.728004776 +0000 Change: 2018-05-15 12:33:50.728004776 +0000 Size: 4096
./com.samsung.android.fmm/databases/profile.db Access: 2015-12-31 23:07:56.220000213 +0000 Modify: 2015-12-31 23:07:56.220000213 +0000 Change: 2018-05-17 17:58:26.960000016 +0000 Size: 4096
./com.samsung.svoice.sync/databases/svoicelocal.db Access: 2015-12-31 23:07:57.420000214 +0000 Modify: 2015-12-31 23:07:57.430000214 +0000 Change: 2018-05-17 17:58:45.240000025 +0000 Size: 4096
./com.sec.imsservice/databases/profile.db Access: 2015-12-31 23:07:01.740000187 +0000 Modify: 2015-12-31 23:07:01.760000187 +0000 Change: 2018-05-17 17:58:06.830000007 +0000 Size: 4096
./com.sec.imsservice/databases/rcs_settings.db Access: 2015-12-31 23:07:03.750000188 +0000 Modify: 2015-12-31 23:07:03.760000188 +0000 Change: 2018-05-17 17:58:07.360000007 +0000 Size: 4096
./com.whatsapp/databases/location.db Access: 2018-05-15 22:00:51.711350791 +0000 Modify: 2018-05-15 22:00:51.721350791 +0000 Change: 2018-05-15 22:00:51.751350791 +0000 Size: 4096
./com.whatsapp/databases/wa.db Access: 2018-05-15 22:00:50.811350791 +0000 Modify: 2018-05-15 22:00:50.831350791 +0000 Change: 2018-05-15 22:00:50.861350791 +0000 Size: 4096
./com.amazon.dee.app/app_webview/databases/Databases.db Access: 2018-05-15 11:38:46.168003200 +0000 Modify: 2018-05-15 11:38:46.178003200 +0000 Change: 2018-05-15 11:38:46.178003200 +0000 Size: 8192
./com.android.chrome/app_chrome/Default/databases/Databases.db Access: 2018-05-15 11:15:49.638002544 +0000 Modify: 2018-05-15 11:15:49.648002544 +0000 Change: 2018-05-15 11:15:49.648002544 +0000 Size: 8192
./com.sec.android.app.sbrowser/app_sbrowser/Default/databases/Databases.db Access: 2018-05-16 13:23:21.940000039 +0000 Modify: 2018-05-16 13:23:21.950000039 +0000 Change: 2018-05-16 13:23:21.950000039 +0000 Size: 8192
./com.android.providers.partnerbookmarks/databases/partnerBookmarks.db Access: 2015-12-31 23:07:43.120000207 +0000 Modify: 2018-05-15 11:15:22.268002531 +0000 Change: 2018-05-15 11:15:22.278002531 +0000 Size: 16384
./com.android.providers.telephony/opname.db Access: 2018-05-16 13:22:01.640000001 +0000 Modify: 2018-05-16 13:22:01.650000001 +0000 Change: 2018-05-16 13:22:01.650000001 +0000 Size: 16384
./com.android.providers.userdictionary/databases/user_dict.db Access: 2015-12-31 23:08:00.300000215 +0000 Modify: 2018-05-16 13:22:41.240000020 +0000 Change: 2018-05-17 17:58:43.400000024 +0000 Size: 16384
./com.dropbox.android/databases/evernote_jobs.db Access: 2018-05-15 12:05:41.838003971 +0000 Modify: 2018-05-15 12:05:41.878003971 +0000 Change: 2018-05-17 17:58:28.620000017 +0000 Size: 16384
./com.google.android.gms/databases/dgp.db Access: 2018-05-15 11:01:50.638002144 +0000 Modify: 2018-05-17 13:35:13.299000020 +0000 Change: 2018-05-17 17:58:33.810000020 +0000 Size: 16384
./com.google.android.gms/databases/icing-proxy-calendar.db Access: 2018-05-15 11:14:55.008002518 +0000 Modify: 2018-05-15 11:14:55.058002518 +0000 Change: 2018-05-17 17:59:45.780000054 +0000 Size: 16384
./com.google.android.gms/databases/NetworkUsage.db Access: 2018-05-16 14:28:26.951353051 +0000 Modify: 2018-05-17 16:20:35.449004751 +0000 Change: 2018-05-17 16:20:35.449004751 +0000 Size: 16384
./com.osp.app.signin/databases/samsungaccount.db Access: 2015-12-31 23:07:56.830000213 +0000 Modify: 2018-05-15 10:52:05.438001865 +0000 Change: 2018-05-17 17:58:29.420000018 +0000 Size: 16384
./com.policydm/databases/policy.db Access: 2018-05-15 11:00:29.728002105 +0000 Modify: 2018-05-15 11:00:30.548002106 +0000 Change: 2018-05-15 11:00:30.548002106 +0000 Size: 16384
./com.quirky.android.wink.wink/databases/google_app_measurement_local.db Access: 2018-05-15 11:36:28.158003134 +0000 Modify: 2018-05-17 17:35:05.199006883 +0000 Change: 2018-05-17 17:59:35.120000049 +0000 Size: 16384
./com.samsung.android.app.taskedge/databases/taskedge.db Access: 2015-12-31 23:08:07.710000218 +0000 Modify: 2015-12-31 23:39:11.820001107 +0000 Change: 2018-05-17 17:59:36.460000050 +0000 Size: 16384
./com.samsung.android.intelligenceservice2/databases/Place.db Access: 2015-12-31 23:07:53.230000212 +0000 Modify: 2015-12-31 23:07:53.270000212 +0000 Change: 2015-12-31 23:07:53.270000212 +0000 Size: 16384
./com.samsung.android.intelligenceservice/databases/Place.db Access: 2015-12-31 23:07:52.010000211 +0000 Modify: 2015-12-31 23:07:52.890000211 +0000 Change: 2015-12-31 23:07:52.890000211 +0000 Size: 16384
./com.samsung.android.video/databases/video_remote_file.db Access: 2015-12-31 23:07:13.280000193 +0000 Modify: 2018-05-15 10:52:11.598001868 +0000 Change: 2018-05-17 17:58:13.440000010 +0000 Size: 16384
./com.sec.android.app.samsungapps/databases/evernote_jobs.db Access: 2018-05-15 09:46:07.758000044 +0000 Modify: 2018-05-15 09:46:07.798000044 +0000 Change: 2018-05-17 17:58:31.980000019 +0000 Size: 16384
./com.sec.android.app.samsungapps/databases/info2.db Access: 2018-05-15 09:45:11.728000017 +0000 Modify: 2018-05-15 09:45:12.778000018 +0000 Change: 2018-05-17 17:58:28.180000017 +0000 Size: 16384
./com.sec.android.app.sbrowser/app_sbrowser/Default/previews_opt_out.db Access: 2018-05-15 13:11:14.408005846 +0000 Modify: 2018-05-15 13:11:14.418005846 +0000 Change: 2018-05-15 13:11:14.418005846 +0000 Size: 16384
./com.sec.android.soagent/databases/soagent.db Access: 2015-12-31 23:07:55.820000213 +0000 Modify: 2018-05-15 09:45:07.528000015 +0000 Change: 2018-05-17 17:58:33.950000020 +0000 Size: 16384
./com.vestiacom.qbeecamera/databases/google_app_measurement_local.db Access: 2018-05-15 11:36:35.878003138 +0000 Modify: 2018-05-17 17:36:03.089006910 +0000 Change: 2018-05-17 17:36:03.089006910 +0000 Size: 16384
./com.wssyncmldm/databases/fota.db Access: 2018-05-15 11:00:29.998002105 +0000 Modify: 2018-05-15 11:00:30.328002105 +0000 Change: 2018-05-17 08:39:28.971349258 +0000 Size: 16384
./tv.peel.app/databases/google_app_measurement_local.db Access: 2018-05-15 12:43:04.948005040 +0000 Modify: 2018-05-15 12:49:02.528005211 +0000 Change: 2018-05-17 17:58:27.600000017 +0000 Size: 16384
./com.android.bluetooth/databases/bthfp.db Access: 2018-05-15 11:35:28.838003106 +0000 Modify: 2018-05-17 17:32:44.389006816 +0000 Change: 2018-05-17 17:32:44.389006816 +0000 Size: 20480
./com.android.bluetooth/databases/btopp.db Access: 2015-12-31 23:07:56.840000213 +0000 Modify: 2018-05-16 13:22:16.890000008 +0000 Change: 2018-05-17 17:31:38.959006784 +0000 Size: 20480
./com.android.chrome/app_chrome/Default/previews_opt_out.db Access: 2018-05-16 13:24:17.780000066 +0000 Modify: 2018-05-16 13:24:17.870000066 +0000 Change: 2018-05-16 13:24:17.870000066 +0000 Size: 20480
./com.android.incallui/databases/quickreply.db Access: 2015-12-31 23:08:36.420000232 +0000 Modify: 2018-05-15 10:52:45.908001884 +0000 Change: 2018-05-17 17:59:11.600000038 +0000 Size: 20480
./com.android.keychain/databases/grants.db Access: 2018-05-15 09:44:54.438000009 +0000 Modify: 2018-05-15 09:44:54.468000009 +0000 Change: 2018-05-17 17:29:54.019006734 +0000 Size: 20480
./com.android.phone/databases/autoreject.db Access: 2015-12-31 23:07:54.740000212 +0000 Modify: 2018-05-16 13:22:28.330000014 +0000 Change: 2018-05-17 17:58:25.150000016 +0000 Size: 20480
./com.android.settings/databases/personalvibration.db Access: 2015-12-31 23:07:47.100000209 +0000 Modify: 2018-05-15 09:44:52.948000008 +0000 Change: 2018-05-17 17:59:45.620000054 +0000 Size: 20480
./com.android.vending/databases/suggestions.db Access: 2018-05-15 11:08:20.148002329 +0000 Modify: 2018-05-15 11:11:10.818002411 +0000 Change: 2018-05-15 11:11:10.818002411 +0000 Size: 20480
./com.google.android.apps.maps/databases/ugc_photos_location_data.db Access: 2018-05-15 12:03:16.978003902 +0000 Modify: 2018-05-15 12:03:17.008003902 +0000 Change: 2018-05-15 12:03:17.008003902 +0000 Size: 20480
./com.google.android.gm/databases/internal.jpinkman2018@gmail.com.db Access: 2018-05-15 09:45:36.478000029 +0000 Modify: 2018-05-17 07:36:29.949000027 +0000 Change: 2018-05-17 17:29:39.249006727 +0000 Size: 20480
./com.google.android.gms/databases/gms.notifications.db Access: 2018-05-15 11:01:55.858002146 +0000 Modify: 2018-05-15 11:01:55.878002146 +0000 Change: 2018-05-17 17:58:37.830000022 +0000 Size: 20480
./com.google.android.gms/databases/upload_queue.db Access: 2018-05-16 13:22:37.380000018 +0000 Modify: 2018-05-16 13:22:37.410000018 +0000 Change: 2018-05-17 17:58:38.430000022 +0000 Size: 20480
./com.google.android.music/databases/WearableDataSync.db Access: 2018-05-16 00:59:42.321386013 +0000 Modify: 2018-05-16 00:59:42.371386013 +0000 Change: 2018-05-16 13:33:06.889000013 +0000 Size: 20480
./com.google.android.youtube/databases/google_conversion_tracking.db Access: 2015-12-31 23:07:20.440000196 +0000 Modify: 2018-05-17 17:58:37.430000021 +0000 Change: 2018-05-17 17:58:37.430000021 +0000 Size: 20480
./com.quirky.android.wink.wink/databases/google_conversion_tracking.db Access: 2018-05-15 11:36:27.108003134 +0000 Modify: 2018-05-17 17:33:39.079006842 +0000 Change: 2018-05-17 17:33:39.079006842 +0000 Size: 20480
./com.samsung.android.app.withtv/databases/alarmTable.db Access: 2015-12-31 23:08:04.060000217 +0000 Modify: 2015-12-31 23:39:21.980001112 +0000 Change: 2018-05-15 10:52:41.168001882 +0000 Size: 20480
./com.samsung.android.email.provider/databases/EmailCache.db Access: 2018-05-15 09:45:46.928000034 +0000 Modify: 2018-05-17 17:29:40.919006728 +0000 Change: 2018-05-17 17:29:40.919006728 +0000 Size: 20480
./com.samsung.android.providers.context/databases/PrivacyLog.db Access: 2015-12-31 23:07:05.280000189 +0000 Modify: 2018-05-16 13:22:15.280000008 +0000 Change: 2018-05-17 17:58:09.610000008 +0000 Size: 20480
./com.samsung.android.slinkcloud/databases/asp_cache.db Access: 2018-05-15 09:45:39.448000030 +0000 Modify: 2018-05-15 09:45:39.508000031 +0000 Change: 2018-05-17 17:29:39.939006728 +0000 Size: 20480
./com.samsung.ipservice/databases/ipservice.db Access: 2015-12-31 23:38:27.020001086 +0000 Modify: 2015-12-31 23:40:10.390001135 +0000 Change: 2015-12-31 23:40:10.390001135 +0000 Size: 20480
./com.samsung.voiceserviceplatform/databases/SVoiceLogsDatabase.db Access: 2015-12-31 23:08:15.350000222 +0000 Modify: 2018-05-15 09:44:56.068000010 +0000 Change: 2018-05-17 17:29:57.999006736 +0000 Size: 20480
./com.sec.android.app.clockpackage/databases/alarm.db Access: 2015-12-31 23:07:41.960000206 +0000 Modify: 2015-12-31 23:39:11.690001107 +0000 Change: 2018-05-17 17:58:27.040000016 +0000 Size: 20480
./com.sec.android.app.clockpackage/databases/worldclock.db Access: 2015-12-31 23:07:41.870000206 +0000 Modify: 2015-12-31 23:39:11.670001107 +0000 Change: 2018-05-17 17:58:26.930000016 +0000 Size: 20480
./com.sec.android.app.music/databases/setting.db Access: 2018-05-15 12:04:09.598003927 +0000 Modify: 2018-05-15 12:04:09.638003927 +0000 Change: 2018-05-17 17:58:53.900000029 +0000 Size: 20480
./com.sec.android.app.sbrowser/databases/webpushnoti_database.db Access: 2015-12-31 23:07:34.740000203 +0000 Modify: 2018-05-15 09:44:55.268000009 +0000 Change: 2018-05-15 12:10:45.918004116 +0000 Size: 20480
./com.sec.android.app.shealth/databases/WearableDeviceStatus.db Access: 2018-05-15 12:21:03.888004410 +0000 Modify: 2018-05-15 12:21:03.928004410 +0000 Change: 2018-05-17 17:29:59.849006737 +0000 Size: 20480
./com.sec.android.app.sysscope/databases/SysScope.db Access: 2018-05-17 17:58:27.620000017 +0000 Modify: 2018-05-17 17:58:27.700000017 +0000 Change: 2018-05-17 17:58:27.700000017 +0000 Size: 20480
./com.sec.android.app.voicenote/databases/label.db Access: 2018-05-15 11:56:17.898003702 +0000 Modify: 2018-05-15 11:56:17.928003702 +0000 Change: 2018-05-15 11:56:17.928003702 +0000 Size: 20480
./com.sec.imsservice/databases/blockContact.db Access: 2015-12-31 23:07:01.670000187 +0000 Modify: 2018-05-16 13:22:12.690000006 +0000 Change: 2018-05-17 17:58:06.820000007 +0000 Size: 20480
./com.sec.knox.foldercontainer/databases/KnoxFolderContainer.db Access: 2015-12-31 23:07:56.390000213 +0000 Modify: 2018-05-16 13:22:34.950000017 +0000 Change: 2018-05-17 17:58:36.970000021 +0000 Size: 20480
./com.sec.spp.push/databases/checker.db Access: 2018-05-16 13:22:31.790000015 +0000 Modify: 2018-05-17 17:58:29.900000018 +0000 Change: 2018-05-17 17:58:29.900000018 +0000 Size: 20480
./tv.peel.app/databases/reminder.db Access: 2015-12-31 23:07:58.650000214 +0000 Modify: 2018-05-15 12:06:53.618004005 +0000 Change: 2018-05-17 17:58:26.790000016 +0000 Size: 20480
./com.amazon.dee.app/databases/arn:aws:remote-config:us-west-2:412793207129:appConfig:ayuw5hfh_ConfigurationCache.db Access: 2018-05-15 11:38:32.188003194 +0000 Modify: 2018-05-17 17:30:05.269006740 +0000 Change: 2018-05-17 17:58:48.340000027 +0000 Size: 24576
./com.android.providers.downloads/databases/downloads.db Access: 2015-12-31 23:07:02.540000187 +0000 Modify: 2018-05-17 17:29:49.039006732 +0000 Change: 2018-05-17 17:58:12.730000010 +0000 Size: 24576
./com.android.vending/databases/frosting.db Access: 2018-05-16 00:39:01.201387232 +0000 Modify: 2018-05-17 17:59:38.490000051 +0000 Change: 2018-05-17 17:59:38.490000051 +0000 Size: 24576
./com.android.vending/databases/xternal_referrer_status.db Access: 2018-05-15 11:16:56.588002576 +0000 Modify: 2018-05-15 11:16:56.608002576 +0000 Change: 2018-05-15 11:16:56.608002576 +0000 Size: 24576
./com.facebook.appmanager/databases/downloads.db Access: 2018-05-15 10:05:50.928000542 +0000 Modify: 2018-05-15 10:05:50.988000542 +0000 Change: 2018-05-17 17:58:46.350000026 +0000 Size: 24576
./com.google.android.apps.maps/databases/ue3.db Access: 2015-12-31 23:07:10.400000191 +0000 Modify: 2018-05-15 09:45:49.948000035 +0000 Change: 2018-05-17 13:35:17.729000022 +0000 Size: 24576
./com.google.android.gms/databases/auto_complete_suggestions.db Access: 2018-05-15 09:44:53.458000009 +0000 Modify: 2018-05-15 09:44:53.468000009 +0000 Change: 2018-05-17 17:29:54.679006735 +0000 Size: 24576
./com.google.android.gms/databases/device_connections.db Access: 2015-12-31 23:07:25.000000198 +0000 Modify: 2018-05-15 11:01:50.688002144 +0000 Change: 2018-05-17 17:59:27.070000045 +0000 Size: 24576
./com.google.android.gms/databases/downloads.db Access: 2015-12-31 23:07:17.970000195 +0000 Modify: 2018-05-16 13:52:42.909000574 +0000 Change: 2018-05-17 13:37:25.909000083 +0000 Size: 24576
./com.google.android.gms/databases/icing-indexapi-errors.db Access: 2018-05-15 11:55:08.808003669 +0000 Modify: 2018-05-15 11:55:08.888003669 +0000 Change: 2018-05-17 11:18:02.240000096 +0000 Size: 24576
./com.google.android.gms/databases/keys.db Access: 2018-05-15 09:45:47.388000034 +0000 Modify: 2018-05-15 09:45:48.678000035 +0000 Change: 2018-05-15 11:06:06.108002266 +0000 Size: 24576
./com.google.android.gms/databases/rmq.db Access: 2015-12-31 23:07:29.580000200 +0000 Modify: 2018-05-17 17:29:33.309006725 +0000 Change: 2018-05-17 17:58:16.710000012 +0000 Size: 24576
./com.google.android.gms/databases/snet_safe_browsing.db Access: 2018-05-15 11:15:41.368002540 +0000 Modify: 2018-05-17 17:29:46.639006731 +0000 Change: 2018-05-17 17:59:28.710000046 +0000 Size: 24576
./com.mobeam.barcodeService/databases/mobeam.db Access: 2015-12-31 23:09:56.480000270 +0000 Modify: 2018-05-15 09:44:34.918000000 +0000 Change: 2018-05-15 09:44:34.928000000 +0000 Size: 24576
./com.osp.app.signin/databases/openData.db Access: 2015-12-31 23:07:56.860000213 +0000 Modify: 2018-05-15 17:19:13.741352861 +0000 Change: 2018-05-17 17:58:29.460000018 +0000 Size: 24576
./com.samsung.android.app.FileShareServer/databases/inbound_transfer.db Access: 2015-12-31 23:07:56.550000213 +0000 Modify: 2018-05-17 17:58:33.890000020 +0000 Change: 2018-05-17 17:58:33.890000020 +0000 Size: 24576
./com.samsung.android.email.provider/databases/EmailProviderBody.db Access: 2015-12-31 23:06:57.450000185 +0000 Modify: 2015-12-31 23:39:15.100001109 +0000 Change: 2018-05-17 17:59:00.530000032 +0000 Size: 24576
./com.samsung.android.fmm/databases/value.db Access: 2015-12-31 23:07:50.070000210 +0000 Modify: 2018-05-15 10:52:16.938001870 +0000 Change: 2018-05-17 18:28:30.920000877 +0000 Size: 24576
./com.samsung.android.intelligenceservice2/databases/predictor.db Access: 2015-12-31 23:07:07.030000190 +0000 Modify: 2018-05-15 09:44:53.338000008 +0000 Change: 2018-05-17 17:58:33.440000019 +0000 Size: 24576
./com.samsung.crane/databases/callcomposer.db Access: 2015-12-31 23:07:49.010000210 +0000 Modify: 2018-05-16 13:22:29.380000014 +0000 Change: 2018-05-17 17:58:25.900000016 +0000 Size: 24576
./com.sec.android.app.sbrowser/databases/pintab.db Access: 2018-05-16 13:23:21.790000039 +0000 Modify: 2018-05-16 13:23:21.810000039 +0000 Change: 2018-05-16 13:23:21.810000039 +0000 Size: 24576
./com.sec.android.app.sns3/databases/snsDB.db Access: 2015-12-31 23:07:55.190000212 +0000 Modify: 2018-05-17 17:59:24.630000044 +0000 Change: 2018-05-17 17:59:24.630000044 +0000 Size: 24576
./com.sec.android.provider.badge/databases/badge.db Access: 2015-12-31 23:06:57.680000185 +0000 Modify: 2018-05-17 17:59:48.630000055 +0000 Change: 2018-05-17 17:59:48.630000055 +0000 Size: 24576
./com.whatsapp/databases/hsmpacks.db Access: 2018-05-15 22:00:52.621350792 +0000 Modify: 2018-05-15 22:00:52.671350792 +0000 Change: 2018-05-15 22:00:52.671350792 +0000 Size: 24576
./com.wssnps/databases/wssnpsdb.db Access: 2015-12-31 23:07:53.620000212 +0000 Modify: 2018-05-16 13:22:27.520000013 +0000 Change: 2018-05-17 17:58:23.900000015 +0000 Size: 24576
./com.amazon.dee.app/databases/DataStore.db Access: 2018-05-15 11:25:23.118002817 +0000 Modify: 2018-05-17 17:37:36.789006955 +0000 Change: 2018-05-17 17:58:48.130000027 +0000 Size: 28672
./com.android.mms/databases/message_glance.db Access: 2015-12-31 23:07:42.440000206 +0000 Modify: 2018-05-15 10:52:44.508001883 +0000 Change: 2018-05-17 17:58:14.990000011 +0000 Size: 28672
./com.android.vending/databases/fetch_suggestions.db Access: 2018-05-15 10:54:28.518001933 +0000 Modify: 2018-05-17 18:47:18.330001414 +0000 Change: 2018-05-17 18:47:18.330001414 +0000 Size: 28672
./com.android.vending/databases/scheduler_logging_store.db Access: 2018-05-15 11:19:37.808002653 +0000 Modify: 2018-05-17 18:47:19.150001415 +0000 Change: 2018-05-17 18:47:19.150001415 +0000 Size: 28672
./com.google.android.apps.books/databases/google_analytics_v4.db Access: 2018-05-15 12:16:39.258004284 +0000 Modify: 2018-05-15 12:33:49.858004776 +0000 Change: 2018-05-17 17:29:39.509006727 +0000 Size: 28672
./com.google.android.apps.docs/databases/google_analytics_v4.db Access: 2015-12-31 23:08:17.160000223 +0000 Modify: 2018-05-15 09:44:53.738000009 +0000 Change: 2018-05-17 17:30:06.159006740 +0000 Size: 28672
./com.google.android.apps.magazines/databases/google_analytics_v4.db Access: 2015-12-31 23:08:00.700000215 +0000 Modify: 2015-12-31 23:39:20.270001111 +0000 Change: 2018-05-17 17:58:34.890000020 +0000 Size: 28672
./com.google.android.gms/databases/app_state.db Access: 2018-05-15 10:53:08.448001895 +0000 Modify: 2018-05-15 10:53:08.498001895 +0000 Change: 2018-05-17 13:35:04.659000016 +0000 Size: 28672
./com.google.android.gms/databases/cryptauthkeys.db Access: 2018-05-15 11:01:46.398002142 +0000 Modify: 2018-05-15 11:06:08.028002266 +0000 Change: 2018-05-15 11:06:08.028002266 +0000 Size: 28672
./com.google.android.gms/databases/gcm_registrar.db Access: 2015-12-31 23:07:27.850000199 +0000 Modify: 2018-05-15 12:24:59.498004523 +0000 Change: 2018-05-17 17:58:16.430000011 +0000 Size: 28672
./com.google.android.gms/databases/google_account_history.db Access: 2018-05-15 09:45:36.038000029 +0000 Modify: 2018-05-15 09:45:36.098000029 +0000 Change: 2018-05-17 13:34:43.269000006 +0000 Size: 28672
./com.google.android.gms/databases/google_analytics2_v4.db Access: 2015-12-31 23:07:26.670000199 +0000 Modify: 2015-12-31 23:07:56.230000213 +0000 Change: 2015-12-31 23:07:56.230000213 +0000 Size: 28672
./com.google.android.gms/databases/google_analytics_v4.db Access: 2015-12-31 23:07:05.520000189 +0000 Modify: 2018-05-17 17:33:46.669006845 +0000 Change: 2018-05-17 17:58:42.430000024 +0000 Size: 28672
./com.google.android.gms/databases/peoplelog.db Access: 2015-12-31 23:07:26.780000199 +0000 Modify: 2018-05-17 17:29:39.739006728 +0000 Change: 2018-05-17 17:29:39.739006728 +0000 Size: 28672
./com.google.android.googlequicksearchbox/databases/icing-mdh.db Access: 2018-05-17 09:32:43.260000118 +0000 Modify: 2018-05-17 09:32:43.290000118 +0000 Change: 2018-05-17 09:32:43.290000118 +0000 Size: 28672
./com.google.android.talk/databases/concurrent_service_task_store.db Access: 2018-05-15 12:10:05.918004097 +0000 Modify: 2018-05-17 17:58:29.260000018 +0000 Change: 2018-05-17 17:58:29.260000018 +0000 Size: 28672
./com.google.android.youtube/databases/identity.db Access: 2018-05-15 09:45:45.848000034 +0000 Modify: 2018-05-15 12:33:47.988004775 +0000 Change: 2018-05-17 17:29:38.589006727 +0000 Size: 28672
./com.microsoft.office.onenote/databases/AriaStorage.db Access: 2018-05-15 12:00:14.318003814 +0000 Modify: 2018-05-15 12:00:16.688003816 +0000 Change: 2018-05-17 17:58:38.050000022 +0000 Size: 28672
./com.nest.android/databases/google_analytics_v4.db Access: 2018-05-15 11:16:56.968002576 +0000 Modify: 2018-05-17 17:32:42.339006815 +0000 Change: 2018-05-17 17:58:46.960000026 +0000 Size: 28672
./com.netgear.android/databases/google_analytics_v4.db Access: 2018-05-15 11:35:51.638003117 +0000 Modify: 2018-05-17 17:33:31.399006838 +0000 Change: 2018-05-17 17:33:31.399006838 +0000 Size: 28672
./com.netgear.android/databases/swrve.db Access: 2018-05-15 11:35:51.328003117 +0000 Modify: 2018-05-17 17:33:36.379006840 +0000 Change: 2018-05-17 17:33:36.379006840 +0000 Size: 28672
./com.osp.app.signin/databases/osp.db Access: 2015-12-31 23:07:57.120000213 +0000 Modify: 2018-05-17 13:34:32.619000001 +0000 Change: 2018-05-17 17:58:30.000000018 +0000 Size: 28672
./com.samsung.android.app.watchmanager/databases/uhm.db Access: 2015-12-31 23:08:38.070000233 +0000 Modify: 2018-05-15 17:20:00.721352883 +0000 Change: 2018-05-17 17:58:21.560000014 +0000 Size: 28672
./com.samsung.android.intelligenceservice2/databases/dump.db Access: 2015-12-31 23:07:07.160000190 +0000 Modify: 2018-05-17 17:58:33.520000020 +0000 Change: 2018-05-17 17:58:33.520000020 +0000 Size: 28672
./com.samsung.klmsagent/databases/klms.db Access: 2015-12-31 23:07:53.590000212 +0000 Modify: 2018-05-15 09:44:36.298000000 +0000 Change: 2018-05-17 17:59:03.200000034 +0000 Size: 28672
./com.sec.android.app.music/databases/DiskCacheJournal.db Access: 2018-05-15 12:04:09.888003927 +0000 Modify: 2018-05-15 12:04:09.928003927 +0000 Change: 2018-05-17 17:58:54.180000029 +0000 Size: 28672
./com.sec.android.app.music/databases/DiskCacheRemoteAlbumsJournal.db Access: 2018-05-15 12:04:09.798003927 +0000 Modify: 2018-05-15 12:04:09.868003927 +0000 Change: 2018-05-15 12:04:09.868003927 +0000 Size: 28672
./com.sec.android.app.shealth/databases/Permission.db Access: 2015-12-31 23:07:54.860000212 +0000 Modify: 2015-12-31 23:07:54.880000212 +0000 Change: 2015-12-31 23:07:54.880000212 +0000 Size: 28672
./com.sec.android.app.shealth/databases/tile.db Access: 2015-12-31 23:07:48.910000210 +0000 Modify: 2018-05-15 12:20:24.908004392 +0000 Change: 2018-05-17 17:59:07.210000036 +0000 Size: 28672
./com.sec.spp.push/databases/logcollector.db Access: 2018-05-15 09:47:11.488000008 +0000 Modify: 2018-05-16 13:38:31.379000167 +0000 Change: 2018-05-17 17:34:59.769006880 +0000 Size: 28672
./com.skype.raider/databases/aria.db Access: 2018-05-15 12:13:10.558004185 +0000 Modify: 2018-05-16 13:22:33.140000016 +0000 Change: 2018-05-16 13:22:33.140000016 +0000 Size: 28672
./com.skype.raider/databases/AriaStorage.db Access: 2018-05-16 13:22:31.360000015 +0000 Modify: 2018-05-16 13:22:31.470000015 +0000 Change: 2018-05-16 13:22:31.470000015 +0000 Size: 28672
./flipboard.boxer.app/databases/users-v6.db Access: 2018-05-16 13:22:28.240000014 +0000 Modify: 2018-05-16 13:22:28.300000014 +0000 Change: 2018-05-17 17:58:25.010000015 +0000 Size: 28672
./com.android.providers.telephony/databases/nwk_info.db Access: 2015-12-31 23:07:39.710000205 +0000 Modify: 2018-05-16 13:22:20.210000010 +0000 Change: 2018-05-17 17:58:14.930000011 +0000 Size: 32768
./com.dropbox.android/databases/prefs.db Access: 2015-12-31 23:07:47.240000209 +0000 Modify: 2018-05-17 17:58:30.700000018 +0000 Change: 2018-05-17 17:58:30.700000018 +0000 Size: 32768
./com.dropbox.android/databases/prefs-shared.db Access: 2015-12-31 23:07:48.590000209 +0000 Modify: 2018-05-15 12:05:42.038003971 +0000 Change: 2018-05-17 17:58:25.580000016 +0000 Size: 32768
./com.google.android.gm/databases/EmailProviderBody.db Access: 2015-12-31 23:06:57.100000185 +0000 Modify: 2018-05-15 12:16:01.378004266 +0000 Change: 2018-05-17 17:59:28.470000046 +0000 Size: 32768
./com.google.android.gms/databases/constellation.db Access: 2018-05-15 11:01:44.668002141 +0000 Modify: 2018-05-15 11:01:44.698002141 +0000 Change: 2018-05-15 11:01:50.498002144 +0000 Size: 32768
./com.google.android.gms/databases/datalayer.db Access: 2018-05-15 11:02:50.018002172 +0000 Modify: 2018-05-17 09:29:24.600000023 +0000 Change: 2018-05-17 18:00:29.040000075 +0000 Size: 32768
./com.google.android.gms/databases/plus.db Access: 2015-12-31 23:07:01.950000187 +0000 Modify: 2018-05-15 11:01:57.908002147 +0000 Change: 2018-05-17 13:34:57.859000013 +0000 Size: 32768
./com.samsung.android.app.appsedge/databases/appsedge.db Access: 2015-12-31 23:08:07.420000218 +0000 Modify: 2015-12-31 23:39:11.940001107 +0000 Change: 2018-05-17 17:58:20.480000013 +0000 Size: 32768
./com.samsung.android.app.simplesharing/databases/easysignup.db Access: 2018-05-15 12:06:03.358003981 +0000 Modify: 2018-05-15 12:06:03.418003981 +0000 Change: 2018-05-17 17:59:12.980000038 +0000 Size: 32768
./com.samsung.android.service.peoplestripe/databases/easysignup.db Access: 2015-12-31 23:07:37.860000204 +0000 Modify: 2018-05-15 17:19:49.011352878 +0000 Change: 2018-05-17 17:58:20.230000013 +0000 Size: 32768
./com.sec.android.app.sbrowser/databases/ContentClip.db Access: 2018-05-16 13:23:21.830000039 +0000 Modify: 2018-05-16 13:23:21.840000039 +0000 Change: 2018-05-16 13:23:21.840000039 +0000 Size: 32768
./com.sec.android.app.shealth/databases/easysignup.db Access: 2018-05-15 12:20:25.018004392 +0000 Modify: 2018-05-15 12:20:25.028004392 +0000 Change: 2018-05-17 17:59:07.290000036 +0000 Size: 32768
./com.google.android.gsf/databases/subscribedfeeds.db Access: 2015-12-31 23:06:57.220000185 +0000 Modify: 2018-05-16 00:38:01.111387203 +0000 Change: 2018-05-17 17:58:06.100000006 +0000 Size: 36864
./com.google.android.partnersetup/databases/rlz_data.db Access: 2015-12-31 23:07:50.960000210 +0000 Modify: 2018-05-16 13:22:30.290000015 +0000 Change: 2018-05-17 17:58:28.920000017 +0000 Size: 36864
./com.microsoft.skydrive/databases/AriaStorage.db Access: 2018-05-15 12:33:50.148004776 +0000 Modify: 2018-05-17 17:58:22.350000014 +0000 Change: 2018-05-17 17:58:22.350000014 +0000 Size: 36864
./com.samsung.android.asksmanager/databases/asks_manager.db Access: 2015-12-31 23:07:55.120000212 +0000 Modify: 2018-05-16 13:22:28.460000014 +0000 Change: 2018-05-17 17:58:25.430000016 +0000 Size: 36864
./com.samsung.android.coreapps/databases/easysignup.db Access: 2015-12-31 23:07:18.350000195 +0000 Modify: 2018-05-15 09:47:07.958000006 +0000 Change: 2018-05-17 17:59:13.320000039 +0000 Size: 36864
./com.samsung.android.provider.filterprovider/databases/filter.db Access: 2015-12-31 23:07:58.750000214 +0000 Modify: 2015-12-31 23:39:18.360001110 +0000 Change: 2015-12-31 23:39:18.360001110 +0000 Size: 36864
./com.samsung.android.provider.shootingmodeprovider/databases/shootingmodemanager.db Access: 2015-12-31 23:07:49.740000210 +0000 Modify: 2015-12-31 23:39:15.820001109 +0000 Change: 2018-05-17 17:58:26.010000016 +0000 Size: 36864
./com.samsung.android.service.peoplestripe/databases/contactagent.db Access: 2018-05-15 17:19:48.881352877 +0000 Modify: 2018-05-15 17:19:48.931352878 +0000 Change: 2018-05-17 17:59:03.250000034 +0000 Size: 36864
./com.sec.android.app.myfiles/databases/myfiles.db Access: 2015-12-31 23:07:14.230000193 +0000 Modify: 2018-05-17 17:58:13.730000010 +0000 Change: 2018-05-17 17:58:13.730000010 +0000 Size: 36864
./com.android.vending/databases/library.db Access: 2018-05-15 09:45:35.008000028 +0000 Modify: 2018-05-15 12:33:48.118004775 +0000 Change: 2018-05-17 17:59:08.960000036 +0000 Size: 40960
./com.google.android.gms/databases/gass.db Access: 2015-12-31 23:08:16.330000223 +0000 Modify: 2018-05-17 17:29:59.199006737 +0000 Change: 2018-05-17 17:58:35.780000021 +0000 Size: 40960
./com.samsung.android.providers.context/databases/status_monitor_v1.db Access: 2015-12-31 23:07:06.610000189 +0000 Modify: 2018-05-17 17:58:10.700000009 +0000 Change: 2018-05-17 17:58:10.700000009 +0000 Size: 40960
./com.samsung.android.service.peoplestripe/databases/circle.db Access: 2015-12-31 23:07:40.030000205 +0000 Modify: 2018-05-15 17:19:50.811352878 +0000 Change: 2018-05-17 17:58:20.290000013 +0000 Size: 40960
./com.sec.android.app.sbrowser/databases/extension.db Access: 2018-05-15 12:12:00.508004151 +0000 Modify: 2018-05-15 12:12:00.538004151 +0000 Change: 2018-05-17 17:29:55.239006735 +0000 Size: 40960
./com.sec.android.provider.emergencymode/databases/emergency.db Access: 2015-12-31 23:06:58.870000186 +0000 Modify: 2018-05-16 13:22:11.770000006 +0000 Change: 2018-05-17 17:58:05.870000006 +0000 Size: 40960
./com.sec.android.providers.mapcon/databases/mapcon.db Access: 2015-12-31 23:06:59.360000186 +0000 Modify: 2018-05-16 13:22:11.810000006 +0000 Change: 2018-05-17 17:58:05.820000006 +0000 Size: 40960
./com.facebook.katana/databases/savedvideos.db Access: 2018-05-15 12:43:21.428005048 +0000 Modify: 2018-05-17 13:38:10.959000105 +0000 Change: 2018-05-17 17:38:32.999006982 +0000 Size: 45056
./com.google.android.apps.maps/databases/gmm_sync.db Access: 2018-05-15 12:03:16.948003902 +0000 Modify: 2018-05-15 12:03:16.998003902 +0000 Change: 2018-05-17 17:59:10.060000037 +0000 Size: 45056
./com.google.android.googlequicksearchbox/app_si/accl_conv_client_content_store/content_store.db Access: 2018-05-16 13:23:20.190000038 +0000 Modify: 2018-05-17 11:15:25.070000021 +0000 Change: 2018-05-17 11:15:25.070000021 +0000 Size: 45056
./com.google.android.googlequicksearchbox/app_si/homescreen_shortcut_content_store/content_store.db Access: 2018-05-16 13:23:20.200000038 +0000 Modify: 2018-05-17 11:15:25.080000021 +0000 Change: 2018-05-17 11:15:25.080000021 +0000 Size: 45056
./com.google.android.googlequicksearchbox/app_si/now_content_store/content_store.db Access: 2018-05-15 12:09:10.978004070 +0000 Modify: 2018-05-17 13:34:31.669000000 +0000 Change: 2018-05-17 13:34:31.669000000 +0000 Size: 45056
./com.google.android.googlequicksearchbox/app_si/opa_content_store/content_store.db Access: 2018-05-16 13:23:20.190000038 +0000 Modify: 2018-05-17 11:15:25.070000021 +0000 Change: 2018-05-17 11:15:25.070000021 +0000 Size: 45056
./com.google.android.googlequicksearchbox/app_si/proactive_key_value_content_store/content_store.db Access: 2018-05-16 13:23:20.190000038 +0000 Modify: 2018-05-17 11:15:25.060000021 +0000 Change: 2018-05-17 11:15:25.060000021 +0000 Size: 45056
./com.google.android.googlequicksearchbox/app_si/shortcuts_content_store/content_store.db Access: 2018-05-16 13:23:20.200000038 +0000 Modify: 2018-05-17 11:15:25.070000021 +0000 Change: 2018-05-17 11:15:25.070000021 +0000 Size: 45056
./com.google.android.googlequicksearchbox/app_si/srp_content_store/content_store.db Access: 2018-05-16 13:23:20.190000038 +0000 Modify: 2018-05-17 11:15:25.070000021 +0000 Change: 2018-05-17 11:15:25.070000021 +0000 Size: 45056
./com.google.android.googlequicksearchbox/app_si/state_dump_event_content_store/content_store.db Access: 2018-05-15 12:21:54.008004434 +0000 Modify: 2018-05-17 11:15:25.040000021 +0000 Change: 2018-05-17 11:15:25.040000021 +0000 Size: 45056
./com.google.android.googlequicksearchbox/files/velour/feature_data/ipa/ipa_content_store/content_store.db Access: 2018-05-17 09:32:41.490000117 +0000 Modify: 2018-05-17 17:58:55.850000030 +0000 Change: 2018-05-17 17:58:55.850000030 +0000 Size: 45056
./com.samsung.android.app.simplesharing/databases/simplesharing.db Access: 2018-05-16 13:22:28.320000014 +0000 Modify: 2018-05-16 13:22:28.590000014 +0000 Change: 2018-05-17 17:58:26.230000016 +0000 Size: 45056
./com.samsung.android.email.provider/databases/Notification.db Access: 2015-12-31 23:07:48.350000209 +0000 Modify: 2015-12-31 23:39:14.940001109 +0000 Change: 2018-05-17 17:58:39.750000023 +0000 Size: 45056
./com.sec.android.app.sbrowser/databases/SBrowser.db Access: 2015-12-31 23:07:34.840000203 +0000 Modify: 2018-05-15 10:52:12.928001868 +0000 Change: 2018-05-15 10:52:12.928001868 +0000 Size: 45056
./com.samsung.android.bbc.bbcagent/databases/BBCAgent.db Access: 2015-12-31 23:07:56.900000213 +0000 Modify: 2018-05-17 17:58:34.520000020 +0000 Change: 2018-05-17 17:58:34.520000020 +0000 Size: 49152
./com.google.android.gms/databases/context_jpinkman2018_gmail.com.db Access: 2018-05-15 09:47:10.808000008 +0000 Modify: 2018-05-17 09:15:37.170000014 +0000 Change: 2018-05-17 17:58:17.330000012 +0000 Size: 53248
./com.google.android.music/databases/config.db Access: 2015-12-31 23:07:15.210000193 +0000 Modify: 2018-05-17 17:29:44.399006730 +0000 Change: 2018-05-17 17:29:44.399006730 +0000 Size: 53248
./com.android.providers.telephony/databases/HbpcdLookup.db Access: 2015-12-31 23:06:59.710000186 +0000 Modify: 2018-05-16 13:22:12.080000006 +0000 Change: 2018-05-17 17:58:06.130000006 +0000 Size: 57344
./com.google.android.gms/databases/context_feature_default.db Access: 2018-05-15 09:44:44.518000004 +0000 Modify: 2018-05-17 18:00:28.580000074 +0000 Change: 2018-05-17 18:00:28.580000074 +0000 Size: 57344
./com.sec.android.app.sns3/databases/snsGooglePlusDB.db Access: 2018-05-15 09:44:40.388000002 +0000 Modify: 2018-05-15 09:44:40.408000002 +0000 Change: 2018-05-16 00:38:10.261387208 +0000 Size: 57344
./com.sec.android.diagmonagent/databases/diagmondm.db Access: 2015-12-31 23:07:44.310000207 +0000 Modify: 2015-12-31 23:39:12.500001108 +0000 Change: 2018-05-17 17:59:17.600000041 +0000 Size: 57344
./com.google.android.gms/databases/cast.db Access: 2018-05-15 11:01:40.968002139 +0000 Modify: 2018-05-17 17:59:34.260000048 +0000 Change: 2018-05-17 17:59:34.260000048 +0000 Size: 61440
./com.samsung.android.coreapps/databases/rshare.db Access: 2015-12-31 23:07:19.030000195 +0000 Modify: 2018-05-17 07:35:32.370000006 +0000 Change: 2018-05-17 17:59:13.450000039 +0000 Size: 61440
./com.sec.android.app.sns3/databases/snsTwitterDB.db Access: 2018-05-15 09:44:40.418000002 +0000 Modify: 2018-05-15 09:44:40.438000002 +0000 Change: 2018-05-16 00:38:10.281387208 +0000 Size: 61440
./com.samsung.android.sm.policy/databases/scpm.db Access: 2015-12-31 23:07:06.790000189 +0000 Modify: 2018-05-15 09:44:38.858000002 +0000 Change: 2018-05-17 17:58:35.340000020 +0000 Size: 65536
./com.sec.android.app.samsungapps/databases/ppmt.db Access: 2018-05-15 09:46:04.718000043 +0000 Modify: 2018-05-15 09:46:04.758000043 +0000 Change: 2018-05-17 17:58:28.720000017 +0000 Size: 65536
./com.sec.android.widgetapp.locationwidget/databases/LBHWidget.db Access: 2015-12-31 23:07:53.090000211 +0000 Modify: 2018-05-15 10:52:42.488001882 +0000 Change: 2018-05-17 17:55:42.240000017 +0000 Size: 65536
./com.amazon.dee.app/databases/map_data_storage_v2.db Access: 2018-05-15 11:25:22.958002817 +0000 Modify: 2018-05-17 17:36:05.939006912 +0000 Change: 2018-05-17 17:58:48.000000026 +0000 Size: 69632
./com.google.android.gms/databases/config.db Access: 2018-05-15 09:44:36.078000000 +0000 Modify: 2018-05-17 17:29:37.969006727 +0000 Change: 2018-05-17 17:59:28.340000046 +0000 Size: 69632
./com.wssyncmldm/databases/wssdmdatabase.db Access: 2015-12-31 23:07:54.210000212 +0000 Modify: 2018-05-15 11:00:32.828002107 +0000 Change: 2018-05-17 17:59:18.900000041 +0000 Size: 69632
./com.google.android.gms/databases/icing-indexapi.db Access: 2018-05-15 11:01:55.038002146 +0000 Modify: 2018-05-17 17:58:44.930000025 +0000 Change: 2018-05-17 17:58:44.930000025 +0000 Size: 73728
./com.policydm/databases/policydmdb.db Access: 2015-12-31 23:07:45.460000208 +0000 Modify: 2018-05-15 11:00:32.908002107 +0000 Change: 2018-05-17 17:59:18.420000041 +0000 Size: 73728
./com.android.vending/databases/package_verification.db Access: 2018-05-15 09:44:43.688000004 +0000 Modify: 2018-05-17 13:35:38.589000032 +0000 Change: 2018-05-17 13:35:38.589000032 +0000 Size: 77824
./com.google.android.apps.plus/databases/iu.upload.db Access: 2018-05-15 09:45:18.468000020 +0000 Modify: 2018-05-15 09:45:18.538000021 +0000 Change: 2018-05-17 17:29:55.459006735 +0000 Size: 77824
./com.samsung.android.app.simplesharing/databases/rshare.db Access: 2018-05-15 12:06:03.458003981 +0000 Modify: 2018-05-17 07:35:48.159000007 +0000 Change: 2018-05-17 17:59:13.020000038 +0000 Size: 77824
./com.samsung.android.fmm/databases/fmmdm.db Access: 2018-05-15 10:52:16.878001870 +0000 Modify: 2018-05-17 17:29:44.739006730 +0000 Change: 2018-05-17 18:28:31.310000877 +0000 Size: 77824
./com.samsung.android.sm.devicesecurity/databases/device_security.db Access: 2015-12-31 23:07:50.720000210 +0000 Modify: 2018-05-17 17:58:23.620000015 +0000 Change: 2018-05-17 17:58:23.620000015 +0000 Size: 77824
./com.sec.android.app.shealth/databases/rshare.db Access: 2018-05-15 12:20:25.048004392 +0000 Modify: 2018-05-15 12:20:25.088004392 +0000 Change: 2018-05-17 17:59:07.350000036 +0000 Size: 77824
./com.sec.android.app.sns3/databases/snsFourSquareDB.db Access: 2018-05-15 09:44:40.438000002 +0000 Modify: 2018-05-15 09:44:40.468000002 +0000 Change: 2018-05-16 00:38:10.281387208 +0000 Size: 81920
./com.sec.android.app.sns3/databases/snsInstagramDB.db Access: 2018-05-15 09:44:40.478000002 +0000 Modify: 2018-05-15 09:44:40.488000002 +0000 Change: 2018-05-16 00:38:10.291387208 +0000 Size: 81920
./com.google.android.gms/databases/icing_contacts.db Access: 2015-12-31 23:07:25.600000198 +0000 Modify: 2018-05-17 17:59:33.030000048 +0000 Change: 2018-05-17 17:59:33.030000048 +0000 Size: 86016
./com.google.android.gms/databases/ns.db Access: 2015-12-31 23:07:27.730000199 +0000 Modify: 2018-05-17 18:00:28.580000074 +0000 Change: 2018-05-17 18:00:28.580000074 +0000 Size: 86016
./com.samsung.android.service.peoplestripe/databases/rshare.db Access: 2015-12-31 23:07:38.110000204 +0000 Modify: 2018-05-17 17:58:19.970000013 +0000 Change: 2018-05-17 17:58:19.970000013 +0000 Size: 86016
./com.samsung.android.MtpApplication/databases/mtpMedia.db Access: 2018-05-16 13:22:26.350000013 +0000 Modify: 2018-05-17 17:58:45.940000025 +0000 Change: 2018-05-17 17:58:45.940000025 +0000 Size: 90112
./com.quirky.android.wink.wink/databases/google_app_measurement.db Access: 2018-05-15 11:36:28.058003134 +0000 Modify: 2018-05-15 11:36:28.148003134 +0000 Change: 2018-05-15 11:36:28.148003134 +0000 Size: 94208
./com.samsung.android.app.galaxyfinder/databases/Application.db Access: 2015-12-31 23:07:51.730000211 +0000 Modify: 2015-12-31 23:39:17.860001110 +0000 Change: 2015-12-31 23:39:17.860001110 +0000 Size: 98304
./com.samsung.android.sm.provider/databases/sm.db Access: 2015-12-31 23:07:05.400000189 +0000 Modify: 2018-05-17 17:58:25.820000016 +0000 Change: 2018-05-17 17:58:25.820000016 +0000 Size: 98304
./com.google.android.apps.plus/files/accounts/0/StreamDatabase0.db Access: 2018-05-15 12:20:59.688004408 +0000 Modify: 2018-05-17 12:01:37.090000101 +0000 Change: 2018-05-17 12:01:37.090000101 +0000 Size: 102400
./com.google.android.gms/databases/reminders.db Access: 2015-12-31 23:07:01.860000187 +0000 Modify: 2018-05-17 17:29:39.879006728 +0000 Change: 2018-05-17 17:58:37.850000022 +0000 Size: 102400
./com.sec.android.gallery3d/databases/local.db Access: 2015-12-31 23:07:17.630000195 +0000 Modify: 2015-12-31 23:07:17.670000195 +0000 Change: 2015-12-31 23:07:17.670000195 +0000 Size: 102400
./com.google.android.gms/databases/google_app_measurement.db Access: 2018-05-15 11:01:55.118002146 +0000 Modify: 2018-05-17 17:36:03.139006910 +0000 Change: 2018-05-17 17:58:15.890000011 +0000 Size: 110592
./com.samsung.hs20provider/databases/hotspot.db Access: 2015-12-31 23:07:45.700000208 +0000 Modify: 2018-05-15 12:43:36.278005055 +0000 Change: 2018-05-17 17:29:27.619006722 +0000 Size: 110592
./com.android.vending/databases/localappstate.db Access: 2015-12-31 23:07:00.790000187 +0000 Modify: 2018-05-17 17:29:58.899006737 +0000 Change: 2018-05-17 17:59:09.010000036 +0000 Size: 122880
./com.whatsapp/databases/axolotl.db Access: 2018-05-15 22:00:52.631350792 +0000 Modify: 2018-05-15 22:00:54.641350793 +0000 Change: 2018-05-15 22:00:54.641350793 +0000 Size: 126976
./com.google.android.gms/databases/iu.upload.db Access: 2015-12-31 23:08:07.330000218 +0000 Modify: 2018-05-17 09:31:56.410000095 +0000 Change: 2018-05-17 13:22:05.480000452 +0000 Size: 135168
./com.samsung.android.app.memo/databases/memo.db Access: 2015-12-31 23:07:40.900000206 +0000 Modify: 2018-05-15 10:52:12.468001868 +0000 Change: 2018-05-15 10:52:12.468001868 +0000 Size: 135168
./com.samsung.android.providers.context/databases/SurveyLog.db Access: 2015-12-31 23:07:06.580000189 +0000 Modify: 2018-05-17 18:36:46.400001113 +0000 Change: 2018-05-17 18:36:46.400001113 +0000 Size: 139264
./com.sec.android.app.sns3/databases/snsLinkedInDB.db Access: 2018-05-15 09:44:40.308000002 +0000 Modify: 2018-05-15 09:44:40.338000002 +0000 Change: 2018-05-16 00:38:10.231387208 +0000 Size: 159744
./com.google.android.gms/databases/matchstickv9.db Access: 2018-05-15 11:01:54.268002145 +0000 Modify: 2018-05-15 11:01:54.318002146 +0000 Change: 2018-05-17 17:58:37.190000021 +0000 Size: 167936
./com.google.android.videos/databases/purchase_store.db Access: 2015-12-31 23:08:01.520000216 +0000 Modify: 2018-05-15 09:45:45.428000033 +0000 Change: 2018-05-17 17:58:32.270000019 +0000 Size: 184320
./com.android.providers.calendar/databases/calendar.db Access: 2015-12-31 23:07:56.960000213 +0000 Modify: 2018-05-17 17:59:45.760000054 +0000 Change: 2018-05-17 17:59:45.760000054 +0000 Size: 188416
./com.google.android.gms/databases/dg.db Access: 2018-05-15 09:44:37.978000001 +0000 Modify: 2018-05-17 13:35:23.339000025 +0000 Change: 2018-05-17 17:58:40.900000023 +0000 Size: 192512
./com.samsung.android.slinkcloud/databases/asp.db Access: 2018-05-15 09:45:34.218000028 +0000 Modify: 2018-05-15 09:45:34.638000028 +0000 Change: 2018-05-17 17:29:35.229006725 +0000 Size: 192512
./com.android.vending/databases/phenotype.db Access: 2018-05-15 10:54:31.648001934 +0000 Modify: 2018-05-17 17:59:18.910000041 +0000 Change: 2018-05-17 17:59:18.910000041 +0000 Size: 204800
./com.google.android.apps.books/databases/books.db Access: 2018-05-15 09:45:41.058000031 +0000 Modify: 2018-05-15 12:33:49.928004776 +0000 Change: 2018-05-17 17:29:39.639006728 +0000 Size: 208896
./com.samsung.android.providers.context/databases/SecureContextLog.db Access: 2015-12-31 23:07:06.490000189 +0000 Modify: 2018-05-17 17:38:21.679006976 +0000 Change: 2018-05-17 17:38:21.679006976 +0000 Size: 208896
./com.google.android.gms/databases/pluscontacts.db Access: 2015-12-31 23:07:27.210000199 +0000 Modify: 2018-05-17 17:29:36.669006726 +0000 Change: 2018-05-17 17:29:36.669006726 +0000 Size: 217088
./com.google.android.gms/databases/playlog.db Access: 2015-12-31 23:07:27.440000199 +0000 Modify: 2018-05-17 18:12:43.240000425 +0000 Change: 2018-05-17 18:12:43.240000425 +0000 Size: 225280
./com.android.providers.media/databases/internal.db Access: 2015-12-31 23:07:38.790000205 +0000 Modify: 2015-12-31 23:39:21.490001112 +0000 Change: 2018-05-17 17:58:20.510000013 +0000 Size: 229376
./com.sec.android.app.music/databases/smusic.db Access: 2018-05-15 12:04:09.428003927 +0000 Modify: 2018-05-15 12:04:10.248003927 +0000 Change: 2018-05-17 17:58:53.790000029 +0000 Size: 229376
./com.google.android.gsf/databases/gservices.db Access: 2015-12-31 23:06:57.130000185 +0000 Modify: 2018-05-17 13:35:24.329000025 +0000 Change: 2018-05-17 17:58:05.940000006 +0000 Size: 258048
./com.google.android.talk/databases/apn.db Access: 2015-12-31 23:07:55.740000213 +0000 Modify: 2015-12-31 23:39:19.740001111 +0000 Change: 2018-05-17 17:58:28.860000017 +0000 Size: 274432
./com.samsung.android.email.provider/databases/EmailProvider.db Access: 2015-12-31 23:06:57.340000185 +0000 Modify: 2015-12-31 23:39:15.080001109 +0000 Change: 2018-05-17 17:59:00.520000032 +0000 Size: 274432
./com.sec.android.app.sns3/databases/snsFacebookDB.db Access: 2018-05-15 09:44:40.348000002 +0000 Modify: 2018-05-15 09:44:40.378000002 +0000 Change: 2018-05-16 00:38:10.261387208 +0000 Size: 274432
./com.android.vending/databases/verify_apps.db Access: 2018-05-15 10:54:38.708001938 +0000 Modify: 2018-05-17 13:35:38.609000032 +0000 Change: 2018-05-17 17:59:19.270000041 +0000 Size: 290816
./com.google.android.gms/databases/games_c6dc6790.db Access: 2018-05-15 09:45:38.778000030 +0000 Modify: 2018-05-15 12:18:43.698004343 +0000 Change: 2018-05-17 17:58:31.360000019 +0000 Size: 290816
./com.samsung.android.providers.context/databases/SurveyUploaderDB.db Access: 2018-05-16 13:23:18.670000038 +0000 Modify: 2018-05-17 10:03:27.450000124 +0000 Change: 2018-05-17 10:03:27.450000124 +0000 Size: 290816
./com.google.android.gm/databases/EmailProvider.db Access: 2015-12-31 23:06:56.990000185 +0000 Modify: 2018-05-15 12:16:01.338004266 +0000 Change: 2018-05-17 17:59:28.460000046 +0000 Size: 307200
./com.android.settings/databases/search_index.db Access: 2015-12-31 23:07:48.010000209 +0000 Modify: 2018-05-17 17:58:46.100000026 +0000 Change: 2018-05-17 17:58:46.100000026 +0000 Size: 319488
./com.android.settings/databases/search_index.db Access: 2015-12-31 23:07:48.010000209 +0000 Modify: 2018-05-17 17:58:46.100000026 +0000 Change: 2018-05-17 17:58:46.100000026 +0000 Size: 319488
./com.google.android.talk/databases/babel1.db Access: 2018-05-15 09:45:44.668000033 +0000 Modify: 2018-05-15 12:10:17.248004102 +0000 Change: 2018-05-17 17:58:29.310000018 +0000 Size: 372736
./com.google.android.gms/databases/DocList.db Access: 2018-05-15 09:45:38.398000030 +0000 Modify: 2018-05-17 13:34:32.949000001 +0000 Change: 2018-05-17 13:34:32.949000001 +0000 Size: 376832
./com.android.providers.media/databases/external.db Access: 2015-12-31 23:07:01.580000187 +0000 Modify: 2018-05-15 12:09:28.428004079 +0000 Change: 2018-05-17 17:58:12.580000010 +0000 Size: 380928
./com.google.android.music/databases/music.db Access: 2018-05-15 09:45:40.348000031 +0000 Modify: 2018-05-17 17:30:15.089006744 +0000 Change: 2018-05-17 17:30:15.089006744 +0000 Size: 442368
./com.sec.imsservice/databases/ims_config_data.db Access: 2015-12-31 23:06:59.380000186 +0000 Modify: 2018-05-17 17:58:12.190000009 +0000 Change: 2018-05-17 17:58:12.190000009 +0000 Size: 479232
./com.google.android.apps.docs/databases/DocList.db Access: 2015-12-31 23:08:17.190000223 +0000 Modify: 2018-05-17 17:30:06.229006740 +0000 Change: 2018-05-17 17:30:06.229006740 +0000 Size: 483328
./com.samsung.cmh/databases/cmh.db Access: 2015-12-31 23:07:07.680000190 +0000 Modify: 2018-05-17 17:58:52.900000029 +0000 Change: 2018-05-17 17:58:52.900000029 +0000 Size: 499712
./com.sec.android.app.launcher/databases/launcher.db Access: 2018-05-15 10:52:40.468001881 +0000 Modify: 2018-05-17 17:58:25.710000016 +0000 Change: 2018-05-17 17:58:25.710000016 +0000 Size: 524288
./com.google.android.apps.plus/databases/es0.db Access: 2018-05-15 11:55:08.288003669 +0000 Modify: 2018-05-17 17:29:38.219006727 +0000 Change: 2018-05-17 17:29:38.219006727 +0000 Size: 716800
./com.android.providers.telephony/databases/telephony.db Access: 2015-12-31 23:06:59.920000186 +0000 Modify: 2018-05-17 17:58:11.630000009 +0000 Change: 2018-05-17 17:58:11.630000009 +0000 Size: 724992
./com.google.android.gm/databases/mailstore.jpinkman2018@gmail.com.db Access: 2018-05-15 09:45:36.568000029 +0000 Modify: 2018-05-15 12:32:44.828004745 +0000 Change: 2018-05-17 17:29:39.259006727 +0000 Size: 761856
./com.sec.android.app.shealth/databases/HealthFramework.db Access: 2018-05-15 12:20:26.568004392 +0000 Modify: 2018-05-15 12:20:33.138004396 +0000 Change: 2018-05-15 12:20:33.138004396 +0000 Size: 925696
./com.sec.android.app.shealth/databases/SecureHealthData.db Access: 2015-12-31 23:07:53.610000212 +0000 Modify: 2018-05-15 12:20:33.128004396 +0000 Change: 2018-05-15 12:20:33.128004396 +0000 Size: 1376256
./com.google.android.gms/databases/phenotype.db Access: 2015-12-31 23:07:33.150000202 +0000 Modify: 2018-05-17 17:58:06.730000007 +0000 Change: 2018-05-17 17:58:06.730000007 +0000 Size: 2818048
```

## Interesting Activity

### Chrome History

### I-Smart Alarm

### Whatsapps

### Pictures

## 

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

Jessie's phone had the Arlo mobile app installed. The pictures we discovered on the phone that were captured by the arlo camera were found in `userdata/data/com.netgear.android`


  need to look more into wink databaes files /mnt/Samsung/data/com.quirky.android.wink.wink/databases/persistenceDB
  
  "SuperLab Kitchen Nest Protect (LabSmoker)""
  "SuperLab Tabletting Camera"


