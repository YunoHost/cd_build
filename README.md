CD Build tools
==============


Requirements
------------

* Debian Wheezy
* A sudoer


Installation
------------
```
wget http://build.yunohost.org/simple-cdd_0.3.14_all.deb
sudo dpkg -i simple-cdd_0.3.14_all.deb
sudo apt-get install -f genisoimage qemu-kvm
git clone git://github.com/YunoHost/cd_build.git
```

Some problems can occur at `dpkg -i` but keep going !


Usage
-----
```
cd cd_build
./build-yunohost amd64
```

Or

```
./build-yunohost i386
```


Troubleshooting
---------------

If you got errors for mysql-password debconf, temporaly change rights on /var/cache/debconf/passwords.dat
```
sudo chmod 666 /var/cache/debconf/passwords.dat
```
