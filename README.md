CD Build tools
==============


Requirements
------------

* Debian Jessie 


Installation
------------
```
git clone git://github.com/YunoHost/cd_build.git
cd cd_build
sudo apt-get install -f simple-cdd genisoimage qemu-kvm xorriso syslinux-utils cpio
```

Build an image
---------------
Important: Be sure your system is up to date, if no you will see "missing packages" error during the script.
```
./build-yunohost amd64
```

Or

```
./build-yunohost i386
```


Troubleshooting
---------------

If you got errors for mysql-password debconf, temporaly change rights on /var/cache/debconf/passwords.dat

This file doesn't contain password.

```
sudo chmod o+r /var/cache/debconf/passwords.dat
```
