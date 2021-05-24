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
- see also .. next section

### Debugging errors in a chroot 

The .deb install can crash for stupid reasons during ISO install because it's in fact ran inside a chroot.

To easily reproduce and investigate the issue, it's easier to manually create a chroot (for example inside an ynh-dev LXC):

```bash
apt install cdebootstrap -y
cd /root/
mkdir mychroot
cdebootstrap --arch=amd64 buster ./mychroot/ http://deb.debian.org/debian/
mount -t proc none ./mychroot/proc
mount -o bind /dev ./mychroot/dev
chroot ./mychroot/ bash
```

- Running `systemctl` should display "Running in chroot, ignoring request." (compared to some error about PID1 if you didnt mount proc and dev)
- Then run the install, for example using the install script `curl https://install.yunohost.org | bash` (you'll need to install curl first)
- The install will crash (otherwise you wouldn't be reading this ? ;))
- You can `nano /var/lib/dpkg/info/yunohost.postinst` and edit that script ... for example adding `-x` to the shebang (= very first line) to have the debug detail when the script will run. Possibly you may want to also tweak the init regen conf hook call (for example also adding `-x`  to the bash call there)
- Re-run the install with `apt install yunohost`

### Errors related to mysql-password debconf

Temporaly change rights on /var/cache/debconf/passwords.dat

This file doesn't contain password.

```
sudo chmod o+r /var/cache/debconf/passwords.dat
```
