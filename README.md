# gentoo-linux-surface
This is a shell script that applies patches for Microsoft Surface devices onto the Gentoo Linux kernel.

## Required Kernel Config Settings
Before running `setup.sh` and going through the installation process, a number of kernel config changes must be made.

```
Device Drivers --->
   Character devices --->
      <*> Serial device bus --->
         [*] Serial device TTY port controller
   [*] GPIO Support --->
      [*] /sys/class/gpio/... (sysfs interface)
```

## Installation

```
git clone https://github.com/WillPower3309/gentoo-linux-surface.git
cd gentoo-linux-surface
sudo sh setup.sh
```
