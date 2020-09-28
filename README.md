# gentoo-linux-surface
This is a shell script that applies patches for Microsoft Surface devices onto the Gentoo Linux kernel.

## Required Kernel Config Settings
Before running `setup.sh` and going through the installation process, a number of kernel config changes must be made.

```
Power management and ACPI options --->
   [*] ACPI (Advanced Configuration and Power Interface) Support
Device Drivers --->
   Misc Devices --->
      {M} Intel Management Engine Interface
      <M> ME Enabled Intel Chipsets
   Input device support --->
      -*- Generic input layer (needed for keyboard, mouse, ...)
      [*] Keyboards --->
         <*> GPIO Buttons
      [*] Miscellaneous devices --->
         [M] Windows-compatible SoC Button Array
   Character devices --->
      <*> Serial device bus --->
         [*] Serial device TTY port controller
   [*] GPIO Support --->
      [*] /sys/class/gpio/... (sysfs interface)
```

https://cateee.net/lkddb/web-lkddb/INPUT_SOC_BUTTON_ARRAY.html
need CONFIG_INPUT_SOC_BUTTON_ARRAY

## Installation

```
git clone https://github.com/WillPower3309/gentoo-linux-surface.git
cd gentoo-linux-surface
sudo sh setup.sh
```
