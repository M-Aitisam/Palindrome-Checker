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

# GitHub repository details
read -p "Enter your GitHub username: " github_username
read -p "Enter your GitHub Developer Token: " github_token
read -p "Enter the name for the new GitHub repository: " repo_name

# Script file name
script_name="palindrome_check.sh"

# Check if the script file exists, if not, create it
if [ ! -f "$script_name" ]; then
    # Save this script to a file
    cat << 'EOF' > "$script_name"
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
EOF
    chmod +x "$script_name"
fi

# Create a new GitHub repository using the GitHub API
response=$(curl -s -H "Authorization: token $github_token" \
  -d "{\"name\":\"$repo_name\"}" \
  https://api.github.com/user/repos)

# Check if the repository was created successfully
if echo "$response" | grep -q '"full_name":'; then
    echo "GitHub repository '$repo_name' created successfully."
else
    echo "Failed to create GitHub repository. Response from GitHub:"
    echo "$response"
    exit 1
fi

# Extract the repository URL
repo_url="https://$github_username:$github_token@github.com/$github_username/$repo_name.git"

# Initialize a new Git repository
git init

# Add the script to the repository
git add .

# Commit the script
git commit -m "Add palindrome check script"

# Add the remote repository URL
git remote set-url origin "$repo_url"

# Push the code to GitHub

git push -u origin main

echo "Script has been pushed to the repository: $repo_url"

