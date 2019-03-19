# Overview

This repository is our team's work towards the 2018 DFRWS Challenge.  More details about the DFRWS Challenge can be found on the [DFRWS Challenge GitHub page](https://github.com/dfrws/dfrws2018-challenge).

-------------------------

# DFRWS Challenge 2018 

Submission by NIWC-LANT

Team: Joshua Lewis, Nicholas Phillpott, Randy Sharo, Shawn Zwach, Kelly Hines

Submission date: 20 MAR 2019

--------------------------

## Acknowledgements

We would like to think the DFRWS challenge developers for putting together these challenges and working to advance the community of digital forensics practicioners and researchers.

## Introduction

From October 2018 through the submission deadline the Navy Information Warfare Center (NIWC LANT) performed a digital forensics examination of the following devices. This report will outline the data extraction, alternative conclusions, and the tools developed to answer the questions presented by the challenge.  

* Below is a listing of the artifacts that were provided by the challenge.  This includes a description of the file, filename, and sha256 hash of the file.

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

## Scenario Background

The section contains details that were provided by the challenge organizers about the scnario.


![drug lab floorplan](https://raw.githubusercontent.com/dfrws/dfrws2018-challenge/master/DFRWS2018-IoT-ForensicChallengeDiagram.png)

```
On 17 May 2018 at 10:40, the police were alerted that an illegal drug lab was invaded and unsuccessfully set on fire. The police respond promptly, and a forensic team is on scene at 10:45, including a digital forensic specialist.

The owner the illegal drug lab, Jessie Pinkman, is nowhere to be found. Police interrogate two of Jessie Pinkman’s known associates: D. Pandana and S. Varga. Pandana and Verga admit having access to the drug lab’s WiFi network but deny any involvement in the raid. They also say that Jessie Pinkman’s had the IoT security systems installed because he feared attacks from a rival gang and that Jessie kept the alarm engaged in “Home” mode whenever he was inside the drug lab.

Within the drug lab (** see diagram) the digital forensic specialist observes some IoT devices, including an alarm system (iSmartAlarm), three cameras (QBee Camera, Nest Camera and Arlo Pro) as well as a smoke detector (Nest Protect). An Amazon Echo and a WinkHub are also present.

** Diagram of the Illegal Drug Laboratory: https://github.com/dfrws/dfrws2018-challenge/blob/master/DFRWS2018-IoT-ForensicChallengeDiagram.png

The digital forensic specialist preserves the diagnostic logs from the iSmartAlarm base station, and acquires a copy of the filesystem of the WinkHub. He also collects the iSmartAlarm and Arlo base stations to perform an in-depth analysis at the forensic laboratory.

The digital forensic specialist also notices that the a QBee Camera seems to be disabled, so he collects a sample of the network traffic.

Back at the forensic laboratory, the digital forensic specialist uses the bootloader to collect a memory image of the two base stations as well as an archive of some folder of interest of the Arlo base station.

Jessie Pinkman's Samsung Galaxy Edge S6 is found at the scene, likely dropped during the raid. The digital forensic specialist acquires a physical image of this Samsung device.
```

   
## Executive Summary  
As part of the challenge the Attorney General needs answers to the following questions:

 + At what time was the illegal drug lab raided?
 
 + Could any of the two friends of Jessie Pinkman have been involved in the raid?
   If YES:
          - Which friend?
          - What is the confidence in such hypothesis?
          
+ How was the QBee camera disabled?

## Evidence Analysis

You may view the analysis of each artifact by clicking the heading of the File Description.
### [Jessie Pinkman's Samsung phone](https://gitlab.com/lewis.joshua/dfrws2019/blob/master/Samsung%20GSM_SM-G925F%20Galaxy%20S6%20Edge.7z.md)

### [iSmartAlarm – Diagnostic logs]()

### [iSmartAlarm – Memory images]()

Two files were provided, however we observed that these files have the same hash and verified that they are a bit for bit duplicate, so we analyzed only one of the files.

### Arlo – Memory image
arlo/dfrws_arlo.img | 3b957a90a57e5e4485aa78d79c9a04270a2ae93f503165c2a0204de918d7ac70 

### Arlo – NVRAM settings
arlo/nvram.log | f5d680d354a261576dc8601047899b5173dbbad374a868a20b97fbd963dca798
### [Arlo – NAND: TAR archive of the folder /tmp/media/nand](https://gitlab.com/lewis.joshua/dfrws2019/blob/master/arlo/nand.md)

### WinkHub – Filesystem TAR archive | wink/wink.tar.gz 
083e7428dc1d0ca335bbcfc11c6263720ab8145ffc637954a7733afc7b23e8c6

### [Amazon Echo – Extraction of cloud data obtained via CIFT](https://gitlab.com/lewis.joshua/dfrws2019/blob/master/echo_analysis.md)  

### [Network capture](https://gitlab.com/lewis.joshua/dfrws2019/blob/master/dfrws_police.pcap.md)

 
## Alternative Conclusions

## Tools Developed
Due to the time that we had to invest in this challenge we chose to focus our efforts on two areas that were mentioned by the challenge creators.  Those are 
1.	Device Level Analysis: Developing methods and tools to forensically process digital traces generated by IoT devices, including on mobile devices.
4.	Evaluating and Expressing Conclusions: Assigning the probability of the results given two competing propositions (e.g. The prime suspect committed the offense, versus some unknown person did).

## URLs
   * [Challenge annoncement page](https://www.dfrws.org/dfrws-forensic-challenge)
   * [challenge github repo](https://github.com/dfrws/dfrws2018-challenge/)
   * [challenge artifacts on github](https://drive.google.com/drive/folders/17szABuOp3wEI9FAWsx5Q4ThAtjPecm4Q?usp=sharing)

## [Challenge Rules](https://gitlab.com/lewis.joshua/dfrws2019/blob/master/challenge_rules.md)



