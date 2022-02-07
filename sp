#!/bin/bash

name="$1"
profiles_file=~/.config/sp_profiles
#profile_name	username	hostname

if [ "$name" == "autocomplete" ]
then
	awk '{print $1}' $profiles_file
	exit
fi

if [ "$name" == "print" ]
then
	grep "^$2" $profiles_file | awk '{printf "ssh %s@%s\n",$2,$3}'
	exit
fi


if [ "$name" != "" ] && grep -E "^$name" $profiles_file >/dev/null;
then
	config_line="$(grep -E "^$name" $profiles_file | head -n 1)"
	user=$(echo $config_line | awk '{print $2}')
	hostname=$(echo $config_line | awk '{print $3}')
	port=$(echo $config_line | awk '{print $4}')
	ssh $user@$hostname
else
	echo "sp profile \"$name\" not found."
fi

