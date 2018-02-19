#!/bin/bash

# Get the script directory
script_dir="$(dirname $(realpath $0))"

repo_url="http://repo.yunohost.org/debian/"

# Find the release version of YunoHost
get_ynh_release () {
	wget --quiet ${repo_url}dists/${deb_dist}/${dist}/binary-i386/Packages.gz -O "$script_dir/Packages.gz"
	gunzip "$script_dir/Packages.gz"
	grep "^Package: yunohost$" --after-context=1 "$script_dir/Packages" | grep "Version" | awk '{print $2;}'
	rm "$script_dir/Packages"
}

# Compare the last available release with the previous one
compare_version () {
	new_version="$1"
	version_file="$script_dir/ynh_${deb_dist}_${dist}"
	old_version=$(cat "$version_file" 2> /dev/null)
	if [ "$new_version" != "$old_version" ]
	then
		echo "$new_version" > "$version_file"
		echo ">>> Build a new iso for YunoHost $dist on $deb_dist i386" | tee -a "$script_dir/ynh_build.log"
		"$script_dir/build-yunohost" i386 $dist $deb_dist 2>&1 | tee -a "$script_dir/ynh_build.log"

		echo ">>> Build a new iso for YunoHost $dist on $deb_dist amd64" | tee -a "$script_dir/ynh_build.log"
		"$script_dir/build-yunohost" amd64 $dist $deb_dist 2>&1 | tee -a "$script_dir/ynh_build.log"
	fi
}

deb_dist=jessie
dist=stable
compare_version "$(get_ynh_release)"

dist=testing
compare_version "$(get_ynh_release)"
