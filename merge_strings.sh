#!/bin/bash

# Directory containing string files
directory=$1

# Temporary file for merged contents
temp_file="merged.txt"

# Final output file
output_file=$1".txt"

# Check if directory is provided
if [ -z "$directory" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Merge all json files into one
cat $directory/*.json > $temp_file

# Remove trailing commas from each line
sed -i 's/,$//' $temp_file

# Sort the merged file by the JSON keys (assumes keys are numbers and ignores duplicates)
awk -F '"' '/"[0-9]+"/{print $2 $0}' $temp_file | sort -n | cut -d ' ' -f2- > $output_file

cp $output_file strings.txt

# Clean up temporary file
rm $temp_file

# Output the path to the sorted file
echo "Sorted file created at: $output_file"
