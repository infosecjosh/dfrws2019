# DFRWS Challenge 2019 
Submission by ORG

Team: Joshua Lewis, Nicholas Phillpott, Randy Sharo, Shawn Zwach

Submission date:

Revision date:

--------------------------

## Introduction

From October 2018 through the submission deadline the SPAWAR Systems Center Atlantic (SSC-LANT) performed a digital forensics examination of the following devices. This report will outline the data extraction, alternative conclusions, and the tools developed to answer the questions presented by the challenge.  


| File Description | Filename | SHA256 Hash |
| ------ | ------ | --------- |
| Jessie Pinkman’s Samsung phone | Samsung GSM_SM-G925F Galaxy S6 Edge.7z | ae83b8ec1d4338f6c4e0a312e73d7b410904fab504f7510723362efe6186b757 |
| iSmartAlarm – Diagnostic logs | ismartalarm/diagnostics/2018-05-17T10_54_28/server_stream | 8033ba6d37ad7f8ba22587ae560c04dba703962ed16ede8c36a55c9553913736 |
| iSmartAlarm – Memory images: 0x0000’0000 (ismart_00.img), 0x8000’0000 |     dump/ismart_00.img, dump/ismart_80.img | b175f98ddb8c79e5a1e7db84eeaa691991939065ae17bad84cdbd915f65d9a10 b175f98ddb8c79e5a1e7db84eeaa691991939065ae17bad84cdbd915f65d9a10  |
| Arlo – Memory image | arlo/dfrws_arlo.img | 3b957a90a57e5e4485aa78d79c9a04270a2ae93f503165c2a0204de918d7ac70 |
| Arlo – NVRAM settings | arlo/nvram.log | f5d680d354a261576dc8601047899b5173dbbad374a868a20b97fbd963dca798 |
| Arlo – NAND: TAR archive of the folder /tmp/media/nand | arlo/arlo_nand.tar.gz | 857455859086cd6face6115e72cb1c63d2befe11db92beec52d1f70618c5e421 |
| WinkHub – Filesystem TAR archive | wink/wink.tar.gz | 083e7428dc1d0ca335bbcfc11c6263720ab8145ffc637954a7733afc7b23e8c6 |
| Amazon Echo – Extraction of cloud data obtained via CIFT | echo/(2018-07-01_13.17.01)_CIFT_RESULT.zip | 7ee2d77a3297bb7ea4030444be6e0e150a272b3302d4f68453e8cfa11ef3241f |
| Network capture | network/dfrws_police.pcap | 1837ee390e060079fab1e17cafff88a1837610ef951153ddcb7cd85ad478228e |

   
 
As part of the challenge "The Attorney General needs answers to the following questions:

 + At what time was the illegal drug lab raided?
 + Could any of the two friends of Jessie Pinkman have been involved in the raid?
   If YES:
          - Which friend?
          - What is the confidence in such hypothesis?
+ How was the QBee camera disabled?

## Data Extraction

### Jessie Pinkman's Samsung phone

Samsung GSM_SM-G925F Galaxy S6 Edge.7z | ae83b8ec1d4338f6c4e0a312e73d7b410904fab504f7510723362efe6186b757 |

### iSmartAlarm – Diagnostic logs 

| ismartalarm/diagnostics/2018-05-17T10_54_28/server_stream | 8033ba6d37ad7f8ba22587ae560c04dba703962ed16ede8c36a55c9553913736 |

### iSmartAlarm – Memory images

dump/ismart_00.img, dump/ismart_80.img | b175f98ddb8c79e5a1e7db84eeaa691991939065ae17bad84cdbd915f65d9a10 b175f98ddb8c79e5a1e7db84eeaa691991939065ae17bad84cdbd915f65d9a10  |

### Arlo – Memory image
arlo/dfrws_arlo.img | 3b957a90a57e5e4485aa78d79c9a04270a2ae93f503165c2a0204de918d7ac70 

### Arlo – NVRAM settings
arlo/nvram.log | f5d680d354a261576dc8601047899b5173dbbad374a868a20b97fbd963dca798
### Arlo – NAND: TAR archive of the folder /tmp/media/nand 
arlo/arlo_nand.tar.gz | 857455859086cd6face6115e72cb1c63d2befe11db92beec52d1f70618c5e421 

### WinkHub – Filesystem TAR archive | wink/wink.tar.gz 
083e7428dc1d0ca335bbcfc11c6263720ab8145ffc637954a7733afc7b23e8c6
### Amazon Echo – Extraction of cloud data obtained via CIFT 
echo/(2018-07-01_13.17.01)_CIFT_RESULT.zip | 7ee2d77a3297bb7ea4030444be6e0e150a272b3302d4f68453e8cfa11ef3241f 

### Network capture 
 network/dfrws_police.pcap | 1837ee390e060079fab1e17cafff88a1837610ef951153ddcb7cd85ad478228e
## Alternative Conclusions

## Tools Developed


