#!/bin/sh

# If a command fails then the deploy stops
set -e

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

rm -rf docs/

# Build the project.
hugo -b https://www.zeroidea.co.jp/ # -b option and root url are needed to avoid intenral link boroken when published

# add CNAME file in docs/
echo "www.zeroidea.co.jp" > docs/CNAME

# Go To Public folder
cd docs

# Add changes to git.
git add .

# Commit changes.
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master