CD Build tools
==============


Requirements
------------

* Debian Wheezy
* genisoimage


Installation
------------
```
wget http://build.yunohost.org/simple-cdd_0.3.14_all.deb
dpkg -i simple-cdd_0.3.14_all.deb
apt-get install -f
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
