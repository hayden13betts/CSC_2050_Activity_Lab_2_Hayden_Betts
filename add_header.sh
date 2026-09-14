 if [[ $# -ne 1 ]]; then
	 echo "Error: Only one c file."
	 exit 1
 fi 

 file=$1
 if [[ ! -f "$file" ]]; then
	 echo "Error: File does not exist"
	 exit 1
 fi 

 if [[ "$file" != *.c ]]; then
	 echo "Error: File must end in .c"
	 exit 1
 fi

 name=$(basename "$file")
 owner=$(ls -l "$file" | awk '{print $3}')
 date=$(ls -l "$file" | awk '{print $6, $7, $8}')

 temp=$(mktemp)

echo "/**" > "$temp"
echo " * File Name: $name" >> "$temp"
echo " * Owner: $owner" >> "$temp"
echo " * Last Modified On: $date" >> "$temp"
echo " */" >> "$temp"

 cat "$file" >> "$temp"

 mv "$temp" "$file"

 echo "Header added to $file"

