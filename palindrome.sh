#!/bin/bash

echo "Enter a String"
read str

rvstr=""

# Loop to reverse the string
for (( i=${#str}-1; i>=0; i-- ))
do
  rvstr="${rvstr}${str:$i:1}"
done

echo "Input String was: $str"
echo "Reverse String is: $rvstr"

# Check if the original string is equal to the reversed string
if [ "$str" = "$rvstr" ]; then
    echo "The entered string is a palindrome"
else
    echo "The entered string is not a palindrome"
fi
