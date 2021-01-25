CD Build tools
==============


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

Install process configuration
-----------------------------

- menu.cfg doc:
    - https://wiki.syslinux.org/wiki/index.php?title=Menu
    - https://wiki.archlinux.org/index.php/syslinux#Configuration
- Preseed configuration doc: https://www.debian.org/releases/stable/s390x/apb.en.html


Troubleshooting
---------------

### Debugging errors during the install via the ISO

- Launch the install in a virtualbox
- Actual logs appear in tty 4, you can switch to it by pressing Alt+F4
- You can manually launch commands from another tty (e.g. the 2nd) but the output will appear in tty4...
- To actually enter the real system (chroot ?) you'll need to run `in-target`

### Errors related to mysql-password debconf

Temporaly change rights on /var/cache/debconf/passwords.dat

This file doesn't contain password.

```
sudo chmod o+r /var/cache/debconf/passwords.dat
```
