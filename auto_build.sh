#!/bin/bash

# Get the script directory
script_dir="$(dirname $(realpath $0))"

repo_url="http://repo.yunohost.org/debian/"

build_yunohost_org_dir="/var/www/build"

iso_directory="/var/www/build"
old_iso_directory="$iso_directory/releases_archive"
mkdir -p "$old_iso_directory"

# Find the release version of YunoHost
get_ynh_release () {
	wget --quiet ${repo_url}dists/${deb_dist}/${dist}/binary-i386/Packages.gz -O "$script_dir/Packages.gz"
	gunzip "$script_dir/Packages.gz"
	grep "^Package: yunohost$" --after-context=1 "$script_dir/Packages" | grep "Version" | awk '{print $2;}'
	rm "$script_dir/Packages"
}

build_new_version () {
	local arch="$1"
	echo -e "\n$(date)" >> "/var/log/build_yunohost/ynh_build.log"
	echo ">>> Build a new iso for YunoHost $dist on $deb_dist $arch" | tee -a "/var/log/build_yunohost/ynh_build.log"
	(cd "$script_dir"
	./build-yunohost $arch $dist $deb_dist 2>&1 | tee -a "/var/log/build_yunohost/ynh_build.log"
	)

	# Move the old iso in another directory
	mv "$script_dir/images/yunohost-$deb_dist-$old_version-$arch-$dist".{iso,iso.sig,iso.sum} "$old_iso_directory"
	# And put at its place the new iso
	local image_name="yunohost-$deb_dist-$new_version-$arch-$dist"
	mv "$script_dir/images/$image_name".{iso,iso.sig,iso.sum} "$iso_directory"

	# Modify the links on build.yunohost.org
	if [ "$dist" = "stable" ]
	then	# Stable
		sed --in-place "s@\(<a href=\".*\)yunohost-.*iso\(\">Stable $arch</a> | <a href=\"\).*sig\(\">pgp</a> - <a href=\"\).*sum\(\">sha512</a><br>\)@ \
		\1$image_name.iso\2$image_name.iso.sig\3$image_name.iso.sum\4@" \
		"$build_yunohost_org_dir/index.html"
	else	# Testing
		sed --in-place "s@\(<a href=\".*\)yunohost-.*iso\(\">Testing $arch</a> | <a href=\"\).*sig\(\">pgp</a> - <a href=\"\).*sum\(\">sha512</a><br>\)@ \
		\1$image_name.iso\2$image_name.iso.sig\3$image_name.iso.sum\4@" \
		"$build_yunohost_org_dir/index.html"
	fi
}

# Compare the last available release with the previous one
compare_version () {
	local new_version="$1"
	local version_file="$script_dir/ynh_${deb_dist}_${dist}"
	local old_version=$(cat "$version_file" 2> /dev/null)
	if [ "$new_version" != "$old_version" ]
	then
		echo "$new_version" > "$version_file"
		build_new_version i386
		build_new_version amd64
	fi
}

deb_dist=jessie
dist=stable
compare_version "$(get_ynh_release)"

dist=testing
compare_version "$(get_ynh_release)"
