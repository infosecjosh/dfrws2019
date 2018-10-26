## Comparison of ismart_00.img and ismart_80.md

The two files are identical
```bash
$ diff -s ismart_00.img ismart_80.img 
Files ismart_00.img and ismart_80.img are identical
```

## Strings in ismart_00.img

ASCII Strings inspected using `strings ismart_00.img | less`

String Findings:
   * File appears to be a `SPI Flash Image`
   * Contains a U-Boot boot loader, version 1.1.3: `U-Boot 1.1.3 (Apr 28 2013 - 17:57:40)`
   * Contains a block of u-boot environment variables (next section)

## U-Boot environment variables in image:

|Setting | Meaning |
|--------|---------|
|bootcmd=tftp | U-Boot launches tftp to download an image by default |
|bootdelay=5 | U-Boot waits 5 seconds for user shell request before booting |
|baudrate=57600 | RS-232 baud rate |
|ethaddr="00:AA:BB:CC:DD:10"  | Mac address to use while bootloader is running |
|ipaddr=10.10.10.123 | IP Address to use while bootloader is running |
|serverip=10.10.10.3 | TFTP server to access |
|ramargs=setenv bootargs root=/dev/ram rw    | boot arguments to use when booting out of RAM |
|addip=setenv bootargs $(bootargs) ip=$(ipaddr):$(serverip):$(gatewayip):$(netmask):$(hostname):$(netdev):off | adds bootline arguments that set up networking upon linux boot |
|addmisc=setenv bootargs $(bootargs) console=ttyS0,$(baudrate) ethaddr=$(ethaddr) panic=1 | adds bootline arguments that sets up serial and ethernet config |
|flash_self=run ramargs addip addmisc;bootm $(kernel_addr) $(ramdisk_addr) | _Note: ramdisk_addr appears undefined._  Configures the full bootline, boots kernel out of flash, with ramdisk initrd |
|kernel_addr=BFC40000 | starting address of raw kernel address. Should be an offset into flash segment |
|u-boot=u-boot.bin |  The name of the u-boot binary, which was/is flashed onto SPI Flash |
|load=tftp 8A100000 $(u-boot) | Command that loads the u-boot binary into RAM |
|u_b=protect off 1:0-1;era 1:0-1;cp.b 8A100000 BC400000 $(filesize) | disables flash write protection, erases entire flash segment, then copies u-boot.bin from RAM into Flash |
|loadfs=tftp 8A100000 root.cramfs | loads the cramfs filesystem into RAM from a TFTP server |
|u_fs=era bc540000 bc83ffff;cp.b 8A100000 BC540000 $(filesize) | erases flash from bc540000 through bc83ffff, then copies cramfs to b5c40000 |
|test_tftp=tftp 8A100000 root.cramfs;run test_tftp | Loads the cramfs over and over, apparently to test tftp |

## Flash Layout

Based on U-Boot settings above:

| Data Type       | Start CPU address (Hex) | Offset into image file (Hex) | Format |
|-----------------|-------------------------|------------------------|--------|
| U-Boot          | BC400000                | 00000000               | Boot loader                | 
| Initial Ramdisk | BC540000                | 00140000               | Cramfs |
| Linux kernel    | BFC40000                | 03840000               | Raw (vmlinux) memory image |

## Attempted to extract cramfs (plus trailing garbage)
Based on environment variables and inferred flash layout, this was attempted
`$ dd if=ismart_00.img of=root.cramfs bs=1 skip=0x140000`

This results in a zero-length file because `ismart_00.img` is only 8MB (0x800000) in length.
Which implies that the supplied image does not start at `BC400000` or is not long enough to include cramfs