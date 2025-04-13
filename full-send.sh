#!/usr/bin/bash

# Check requirements


# Flags 
while getopts p:f: flag; do
  case "${flag}" in
    p) pass=${OPTARG};;
    f) file=${OPTARG};;
    *) echo "Usage: $0 -p <pass> -f <filename>"; exit 1;;
  esac
done


# Flag validations:
if [[ -z "$pass" ]]; then
  echo "Error: Password (-p) is required."
  exit 1
fi

if [[ ! -f "$file" ]]; then
  echo "Error: File (-f) is required."
  exit 1
fi


# Compress and password encrypt
7z a -p"$pass" -mhe "$file.7z" "$file";


# Send to mega.nz rclone folder
rclone -P --mega-use-https copy "$file.7z" remote:rclone/"$file.7z"


# After send, option to remove zipped and original file 

# After encryption save password to 1Password

# Use private key

# Pull File from cloud

# Uncompress/Encrypt using password

# Uncompress/Encrypt using private key

# After encryption save password to 1Password
