# DFRWS Challenge 2018 - NIWC LANT

This repository is Naval Information Warfare Center, Atlantic's submission to the 2018 DFRWS Challenge.  More details about the challenge can be found on the [DFRWS Challenge GitHub page](https://github.com/dfrws/dfrws2018-challenge).

Submission by: Naval Information Warfare Center, Atlantic (NIWC LANT)

Team: Kelly Hines, Joshua Lewis, Nicholas Phillpott, Randy Sharo

Submission date: 20 MAR 2019

# Report

## Table of Contents
* [Executive Summary](#executive-summary)
* [Objectives](#objectives)
* [Evidence](#evidence)
* [Steps to Reproduce](#steps-to-reproduce)
* [Findings](#findings)
* [Timeline](#timeline)
* [Conclusion](#conclusion)
* [Alternative Conclusions](#alternative-conclusions)
* [Acknowledgements](#acknowledgements)
* [Appendices](#appendices)
    * [Appendix A: Raw Notes](#appendix-a-raw-notes)

## Executive Summary
From October 2018 through the submission deadline the Navy Information Warfare Center (NIWC LANT) performed a digital forensics examination of the following devices. This report will outline the data extraction, alternative conclusions, and the tools developed to answer the questions presented by the challenge.

## Objectives
The attorney general assigned the following objectives:
* Determine the time the illegal drug lab was raided
* Determine which, if any, of Jessie Pinkman's friends were involved in the raid and document the confidence level in that hypothesis
* Determine how the QBee camera was disabled

## Evidence
Evidence items are listed in the order they were presented by the challenge documentation. Notably, to share this challenge among teams, evidence items are not original evidence but copies of the previously collected evidence.

### Jessie Pinkman's Phone
Pinkman's phone is described by the file name to be a Samsung Galaxy S6 Edge.
<table witdh=100%>
<tr><th colspan=2 align=left>Archive of Physical Extraction</th></tr>
<tr><td>Evidence Type</td><td>Archive</td></tr>
<tr><td>Description</td><td>Physical extraction of Jessie Pinkman’s Samsung phone</td></tr>
<tr><td>File</td><td>samsung/Samsung GSM_SM-G925F Galaxy S6 Edge.7z</td></tr>
<tr><td>SHA256</td><td>ae83b8ec1d4338f6c4e0a312e73d7b410904fab504f7510723362efe6186b757</td></tr>
</table>

<table>
<tr><th colspan=2 align=left>Image File from Jessie Pinkman’s Phone Archive</th></tr>
<tr><td>Evidence Type</td><td>Image</td></tr>
<tr><td>Description</td><td>Extracted from samsung/Samsung GSM_SM-G925F Galaxy S6 Edge.7z</td></tr>
<tr><td>File</td><td>blk0_sda.bin</td></tr>
<tr><td>SHA256</td><td>29e3ecfaccda09d8ff2026cf71d282c7026f7d0962c1508cd6f15beb51ec4ac4</td></tr>
</table>

<table>
<tr><th colspan=2 align=left>Image File from Jessie Pinkman’s Phone Archive</th></tr>
<tr><td>Evidence Type</td><td>Image</td></tr>
<tr><td>Description</td><td>Extracted from samsung/Samsung GSM_SM-G925F Galaxy S6 Edge.7z</td></tr>
<tr><td>File</td><td>blk16_sdb.bin</td></tr>
<tr><td>SHA256</td><td>b167346b8eabda6dd8c7148e4aa15cd5f62148393accb7570e60f2505f010b7b</td></tr>
</table>

<table>
<tr><th colspan=2 align=left>Image File from Jessie Pinkman’s Phone Archive</th></tr>
<tr><td>Evidence Type</td><td>Image</td></tr>
<tr><td>Description</td><td>Extracted from samsung/Samsung GSM_SM-G925F Galaxy S6 Edge.7z</td></tr>
<tr><td>File</td><td>blk32_sdc.bin</td></tr>
<tr><td>SHA256</td><td>1301ca17cf7de7da7b52ae178c1dbbfed8fa4bcc97f081c6fb29c981ef43fd0b</td></tr>
</table>

<table>
<tr><th colspan=2 align=left>/proc/ Archive from Jessie Pinkman’s Phone Archive</th></tr>
<tr><td>Evidence Type</td><td>Archive</td></tr>
<tr><td>Description</td><td>Extracted from samsung/Samsung GSM_SM-G925F Galaxy S6 Edge.7z. Contains the following files from Jessie Pinkman's cell phone:<br>/proc/partitions<br>/proc/mounts<br>/proc/cpuinfo<br>/proc/diskstats<br>/proc/filesystems<br>/proc/system<br>/proc/radio<br>/proc/events</td></tr>
<tr><td>File</td><td>procdata.zip</td></tr>
<tr><td>SHA256</td><td>1301ca17cf7de7da7b52ae178c1dbbfed8fa4bcc97f081c6fb29c981ef43fd0b</td></tr>
</table>

### iSmartAlarm
iSmartAlarm is an ecosystem of security hardware and software.
<table>
<tr><th colspan=2 align=left>iSmartAlarm Diagnostic Logs</th></tr>
<tr><td>Evidence Type</td><td>Binary Log</td></tr>
<tr><td>Description</td><td>File contains binary data, HTTP headers, JSON data, and message descriptions just as "CSUDP" and "ISAT".</td></tr>
<tr><td>File</td><td>ismartalarm/diagnostics/2018-05-17T10_54_28/server_stream</td></tr>
<tr><td>SHA256</td><td>8033ba6d37ad7f8ba22587ae560c04dba703962ed16ede8c36a55c9553913736</td></tr>
</table>

<table>
<tr><th colspan=2 align=left>iSmartAlarm Memory Image</th></tr>
<tr><td>Evidence Type</td><td>Image</td></tr>
<tr><td>Description</td><td>0x0000’0000</td></tr>
<tr><td>File</td><td>ismartalarm/dump/ismart_00.img</td></tr>
<tr><td>SHA256</td><td>b175f98ddb8c79e5a1e7db84eeaa691991939065ae17bad84cdbd915f65d9a10</td></tr>
</table>

<table>
<tr><th colspan=2 align=left>iSmartAlarm Memory Image</th></tr>
<tr><td>Evidence Type</td><td>Image</td></tr>
<tr><td>Description</td><td>0x8000’0000</td></tr>
<tr><td>File</td><td>ismartalarm/dump/ismart_80.img</td></tr>
<tr><td>SHA256</td><td>b175f98ddb8c79e5a1e7db84eeaa691991939065ae17bad84cdbd915f65d9a10</td></tr>
</table>

### Arlo
Arlo Technologies is a home automation company. These evidence items are related to one of their cameras.
<table>
<tr><th colspan=2 align=left>Arlo Memory image</th></tr>
<tr><td>Evidence Type</td><td>Image</td></tr>
<tr><td>Description</td><td>Arlo – Memory image</td></tr>
<tr><td>File</td><td>arlo/dfrws_arlo.img</td></tr>
<tr><td>SHA256</td><td>3b957a90a57e5e4485aa78d79c9a04270a2ae93f503165c2a0204de918d7ac70</td></tr>
</table>

<table>
<tr><th colspan=2 align=left>Arlo NVRAM Log</th></tr>
<tr><td>Evidence Type</td><td>Log</td></tr>
<tr><td>Description</td><td>Arlo – NVRAM settings</td></tr>
<tr><td>File</td><td>arlo/nvram.log</td></tr>
<tr><td>SHA256</td><td>f5d680d354a261576dc8601047899b5173dbbad374a868a20b97fbd963dca798</td></tr>
</table>

<table>
<tr><th colspan=2 align=left>Arlo NAND</th></tr>
<tr><td>Evidence Type</td><td>Archive</td></tr>
<tr><td>Description</td><td>Arlo – NAND: TAR archive of the folder /tmp/media/nand</td></tr>
<tr><td>File</td><td>arlo/arlo_nand.tar.gz</td></tr>
<tr><td>SHA256</td><td>857455859086cd6face6115e72cb1c63d2befe11db92beec52d1f70618c5e421</td></tr>
</table>

### WinkHub
The Wink ecosystem of products allows control and configuration of many diverse smarthome devices via a single user interface.
<table>
<tr><td>Evidence Type</td><td>Archive</td></tr>
<tr><td>Description</td><td>Filesystem TAR archive</td></tr>
<tr><td>File</td><td>wink/wink.tar.gz</td></tr>
<tr><td>SHA256</td><td>083e7428dc1d0ca335bbcfc11c6263720ab8145ffc637954a7733afc7b23e8c6</td></tr>
</table>

### Amazon Echo
A smart speaker that responds by various names and can manage other devices or applications via "skills".
<table>
<tr><td>Evidence Type</td><td>Archive</td></tr>
<tr><td>Description</td><td>Archive of cloud data captured with <a href="https://www.dfrws.org/conferences/dfrws-usa-2017/sessions/digital-forensic-approaches-amazon-alexa-ecosystem">CIFT</a></td></tr>
<tr><td>File</td><td>echo/(2018-07-01_13.17.01)_CIFT_RESULT.zip</td></tr>
<tr><td>SHA256</td><td>7ee2d77a3297bb7ea4030444be6e0e150a272b3302d4f68453e8cfa11ef3241f</td></tr>
</table>

### Network Capture
<table>
<tr><td>Evidence Type</td><td>Packet Capture</td></tr>
<tr><td>Description</td><td>Digital forensic specialist gathered this capture after noticing the QBee camera was disabled.</td></tr>
<tr><td>File</td><td>network/dfrws_police.pcap</td></tr>
<tr><td>SHA256</td><td>1837ee390e060079fab1e17cafff88a1837610ef951153ddcb7cd85ad478228e</td></tr>
</table>

### Lab Layout Diagram

![image](https://raw.githubusercontent.com/dfrws/dfrws2018-challenge/master/DFRWS2018-IoT-ForensicChallengeDiagram.png)

## Steps to Reproduce
Steps to reproduce examination here

Due to the time that we had to invest in this challenge we chose to focus our efforts on two areas that were mentioned by the challenge creators.  Those are 
1.	Device Level Analysis: Developing methods and tools to forensically process digital traces generated by IoT devices, including on mobile devices.
4.	Evaluating and Expressing Conclusions: Assigning the probability of the results given two competing propositions (e.g. The prime suspect committed the offense, versus some unknown person did).

## Findings

## Timeline

## Conclusion

## Alternative Conclusions

## Acknowledgements

The authors would like to thank the Digital Forensic Research Workshop and the developers of this years challenge for putting this activity together. Opportunities like this are critical to advancing the technolgies and methodoligies used by digital forensics examiners and researchers. Thank you.

## Appendices

### Appendix A: Raw Notes
Examiner notes for each artifact are linked below.
* [Jessie Pinkman's Samsung phone](https://gitlab.com/lewis.joshua/dfrws2019/blob/master/Samsung%20GSM_SM-G925F%20Galaxy%20S6%20Edge.7z.md)
* [iSmartAlarm – Diagnostic logs]()
* [iSmartAlarm – Memory images]()
* [Arlo – NAND: TAR archive of the folder /tmp/media/nand](https://gitlab.com/lewis.joshua/dfrws2019/blob/master/arlo/nand.md)
* [Network capture](https://gitlab.com/lewis.joshua/dfrws2019/blob/master/dfrws_police.pcap.md)
* [Amazon Echo – Extraction of cloud data obtained via CIFT](https://gitlab.com/lewis.joshua/dfrws2019/blob/master/echo_analysis.md)  