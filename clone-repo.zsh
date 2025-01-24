#!/bin/zsh

# Does this script also delete the git repo and reinitialise it after copying to the new dir? AI?

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

# Copy this repo to a sibling dir with the new name, excluding .git directory
echo "Copying repository to $new_repo_dir (excluding .git)..."
if ! rsync -a --exclude='.git' "$(pwd)/" "$new_repo_dir"; then
    echo "Error: Failed to copy repository"
    exit 1
fi

cd "$new_repo_dir" || exit 1

# Initialize new git repo
echo "Initializing new git repository..."
git init --initial-branch=main

# Update the README.md to be a single h1 with the name of the repo
echo "# $repo_name" > README.md

# Delete this clone script from the new repo
rm clone-repo.zsh

# Add all files and create initial commit
git add .
git commit -m "First"

echo "Repository cloned and initialized successfully in $new_repo_dir"

# Change into the new directory
cd "$new_repo_dir" || exit 1

