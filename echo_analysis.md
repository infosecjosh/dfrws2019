# Analysis of Jessie Pinkman’s Amazon Echo
  
  Evidence Collection Method: Extraction of cloud data obtained via CIFT
  File/Folder: echo/(2018-07-01_13.17.01)_CIFT_RESULT.zip
  SHA256: 7ee2d77a3297bb7ea4030444be6e0e150a272b3302d4f68453e8cfa11ef3241f
  
## Download and verify the integrity of downloaded artifact

First we downloaded and verified the integrity of the downloaded artifact to the SHA256 hash provided by the challenge.
```
# sha256sum echo/\(2018-07-01_13.17.01)_CIFT_RESULT.zip 
7ee2d77a3297bb7ea4030444be6e0e150a272b3302d4f68453e8cfa11ef3241f echo/\(2018-07-01_13.17.01)_CIFT_RESULT.zip
```

## Extract the zip file contents for analysis

During the next step we extracted the zip file and began reviewing the contents.

```
# mkdir echo
# unzip echo/\(2018-07-01_13.17.01)_CIFT_RESULT.zip -decho/

<paste here what shown on screen>

Extracting  ....


```
Then we listed the extracted files.

```
# ls echo/\(2018-07-01_13.17.01)_CIFT_RESULT
cift_amazon_alexa_ACCOUNT.csv .....

# ls echo/\(2018-07-01_13.17.01)_CIFT_RESULT/Evidence_Library
AmazonAlexaCloud

# ls echo/\(2018-07-01_13.17.01)_CIFT_RESULT/Evidence_Library/AmazonAlexaCloud
....json
....
VOICE

# ls echo/\(2018-07-01_13.17.01)_CIFT_RESULT/Evidence_Library/AmazonAlexaCloud/VOICE
....wav
....


