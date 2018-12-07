## Overview - Arlo NAND

Artifact description from challenge details:
```
Arlo – NAND: TAR archive of the folder /tmp/media/nand
  File/Folder: arlo/arlo_nand.tar.gz
  SHA256: 857455859086cd6face6115e72cb1c63d2befe11db92beec52d1f70618c5e421
```

## Device Details
* From `arlo_nand.tar.gz#/tmp/media/nand/vzdaemon/conf/cameras/59U17B7BB8B46.json`
    * id: 59U17B7BB8B46
    * MAC: 08:02:8E:FD:BD:CD
* From `arlo_nand.tar.gz#/tmp/media/nand/vzdaemon/conf/activemodeov.json`
    * active mode id: mode2
* From `arlo_nand.tar.gz#/tmp/media/nand/vzdaemon/conf/automation/Automation.json`
    * Truncated...
    ```json
    {
            "devices": {
                "59U17B7BB8B46": {
                    "audioStart": {
                        "enabled": true,
                        "pushNotification": {
                            "enabled": true
                        },
                        "recordVideo": {
                            "enabled": true,
                            "fixedTime": {
                                "duration": 10
                            },
                            "stopCondition": "motionStop"
                        },
                        "sensitivity": 3,
                        "sirenAlert": {
                            "duration": 180,
                            "enabled": false,
                            "pattern": "alarm",
                            "sirenState": "off",
                            "volume": 8
                        }
                    },
                    "id": "59U17B7BB8B46",
                    "motionStart": {
                        "enabled": true,
                        "pushNotification": {
                            "enabled": true
                        },
                        "recordVideo": {
                            "enabled": true,
                            "fixedTime": {
                                "duration": 10
                            },
                            "stopCondition": "motionStop"
                        },
                        "sensitivity": 80,
                        "sirenAlert": {
                            "duration": 180,
                            "enabled": false,
                            "pattern": "alarm",
                            "sirenState": "off",
                            "volume": 8
                        }
                    },
                    "name": "**_DEFAULT_RULE_**"
                }
            },
            "id": "mode2",
            "name": "Always",
            "type": "custom"
    }
    ```

