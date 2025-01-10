#!/bin/zsh

# Prompt for a new repo name
echo "Enter the new repository name:"
read repo_name

# Check if the target directory exists and is not empty
parent_dir=$(dirname "$(pwd)")
new_repo_dir="$parent_dir/$repo_name"

if [ -d "$new_repo_dir" ]; then
    if [ "$(ls -A "$new_repo_dir" 2>/dev/null)" ]; then
        echo "Error: Directory $new_repo_dir exists and is not empty."
        exit 1
    fi
fi

# Copy this repo to a sibling dir with the new name
echo "Copying repository to $new_repo_dir..."
if ! cp -r "$(pwd)" "$new_repo_dir"; then
    echo "Error: Failed to copy repository"
    exit 1
fi

cd "$new_repo_dir" || exit 1

# Initialize new git repo
echo "Initializing new git repository..."
git init --initial-branch=main

# Update the README.md to be a single h1 with the name of the repo
echo "# $repo_name" > README.md

echo "Repository cloned and initialized successfully in $new_repo_dir"

