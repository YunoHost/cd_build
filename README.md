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
sudo apt-get install -f simple-cdd genisoimage qemu-kvm
```

Build an image
---------------
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
