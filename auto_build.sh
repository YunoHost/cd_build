#!/bin/bash

# Get the script directory
script_dir="$(dirname $(realpath $0))"

repo_url="http://forge.yunohost.org/debian/"

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
	(cd "$script_dir";
	./build-yunohost $arch $dist $deb_dist 2>&1 | tee -a "/var/log/build_yunohost/ynh_build.log"
	)

	# And put at its place the new iso
	local image_name="yunohost-$deb_dist-$new_version-$arch-$dist"
	mv "$script_dir/images/$image_name.iso" "$iso_directory"

	# Update the images.json (will also sign it, and move the old image in release_archives)
	if [[ $dist == "stable" ]];
	then
		if [[ $arch == "i386" ]];
		then
		   sudo /var/www/build/update-images.py regularcomputer32 $new_version $image_name.iso
		   sudo /var/www/build/update-images.py virtualbox32      $new_version $image_name.iso
		else
		   sudo /var/www/build/update-images.py regularcomputer64 $new_version $image_name.iso
		   sudo /var/www/build/update-images.py virtualbox64      $new_version $image_name.iso
		fi
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

deb_dist=bullseye
dist=stable
compare_version "$(get_ynh_release)"

# Disabling for now as it's causing some issues (not reverting the changes in .preseed)
# Not sure we really need those anyway :s
#dist=testing
#compare_version "$(get_ynh_release)"
