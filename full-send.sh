#!/usr/bin/bash

#echo "Type in file name:"
#read input_filename
#echo "---------"
echo "File password:"
read -s input_filepass
echo "Confirm File password:"
read -s input_filepass_confirm
if [[ $input_filepass_confirm != $input_filepass ]]; then
		echo "!!!!!!!!!!!!!!!!!!!!!!"
		echo "Passwords do not match"
		echo "!!!!!!!!!!!!!!!!!!!!!!"
		exit 1
fi


#gzip -k -v $input_filename
#gzipped_file="$input_filename.gz"
#7z a -p"$input_filepass" -mhe "$input_filename.7z" "$input_filename"
#rclone --mega-use-https copy "$input_filename.7z" remote:"$input_filename.7z"


# Get list of files in the current directory
files=(*)

# Display the files with [number] format
echo "##### Select a file: #####"
for i in "${!files[@]}"; do
    echo "[$((i+1))] ${files[$i]}"
done

# Prompt user for selection
read -p "Enter the number of the file: " choice

# Adjust index (since arrays are 0-based)
index=$((choice - 1))

# Check if selection is valid
if [[ $index -ge 0 && $index -lt ${#files[@]} ]]; then
    selected_file="${files[$index]}"
    #echo "You selected: $selected_file"
	echo "#######################"
	echo "###### 7zipping: ######"
	echo "#######################"
	7z a -p"$input_filepass" -mhe "$selected_file.7z" "$selected_file"
	echo "##########################"
	echo "###### Rclone push: ######"
	echo "##########################"
	rclone -P --mega-use-https copy "$selected_file.7z" remote:rclone/"$selected_file.7z"
	echo "####################################"
	echo "###### Rclone file sharelink: ######"
	echo "####################################"
	rclone link remote:rclone/
else
    echo "Invalid selection."
    exit 1
fi

echo "####################"
echo "Hit Enter to view file password"
echo "####################"
read ready_view_file_pass
echo "####################"
echo "$input_filepass_confirm"
echo "####################"
