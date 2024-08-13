#!/bin/bash

# Function to normalize a string (remove spaces, punctuation, and convert to lowercase)
normalize() {
    echo "$1" | tr -d '[:space:][:punct:]' | tr '[:upper:]' '[:lower:]'
}

# Function to check if a string is a palindrome
is_palindrome() {
    local str=$1
    local rev_str=$(echo "$str" | rev)
    if [ "$str" == "$rev_str" ]; then
        echo "The string is a palindrome."
    else
        echo "The string is not a palindrome."
    fi
}

# Prompt the user to enter a string
read -p "Enter a string: " input_str

# Normalize the input string
normalized_str=$(normalize "$input_str")

# Check if the normalized string is a palindrome
is_palindrome "$normalized_str"
