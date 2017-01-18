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
sudo apt-get install -f simple-cdd enisoimage qemu-kvm
```

Build an image
---------------
```
build-simple-cdd --conf ./simple-cdd-amd64.conf
```


Troubleshooting
---------------

If you got errors for mysql-password debconf, temporaly change rights on /var/cache/debconf/passwords.dat

This file doesn't contain password.

```
sudo chmod o+r /var/cache/debconf/passwords.dat
```

Old how to
-----
```
./build-yunohost amd64
```

Or

```
./build-yunohost i386
```
