## Overview

Artifact description from challenge details:
```
iSmartAlarm – Memory images: 0x0000’0000 (ismart_00.img), 0x8000’0000
(ismart_80.img)
  File/Folder, SHA256: 
    dump/ismart_00.img, b175f98ddb8c79e5a1e7db84eeaa691991939065ae17bad84cdbd915f65d9a10
    dump/ismart_80.img, b175f98ddb8c79e5a1e7db84eeaa691991939065ae17bad84cdbd915f65d9a10
```

## Lazy Extraction

I used binwalk to extract what I could. Unsure if it's everything. Be careful if you extract directly with cpio as I accidentally burned a box.

```bash
binwalk -e -M /mnt/hgfs/vmshare/ismartalarm/dump/ismart00_sda.bin
```
