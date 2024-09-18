#!/bin/bash
# Check we were passed the expected arguments
if [ -z "$1"]; then
  echo "Please pass the git repository you wish to work in as the first argument!"
  echo "Example:"
  echo "docker run --it -v ~/.ssh/:root/.ssh:ro -v ~/.gitconfig:/root/.gitconfig:ro lazyvim-container-base:latest git@githost.com:user/repo.git"
  exit 1
else
 # Get the repo url from the first argument
 URL="$1"
fi
# Ensure .ssh Directory Exists and has correct permissions
mkdir -p /root/.ssh 
chmod 700 /root/.ssh 
# Extract the domain name so we can scan for it on the hosts ssh keys
domain=$(echo "$url" | cut -d'@' -f2 | cut -d':' -f1)
# Scan the SSH key for the git server and add it to known_hosts (prevent known hosts [yes|no] prompts)
ssh-keyscan -H "$domain" >> "/root/.ssh/known_hosts"
# Ensure that the ssh command uses the known_hosts file
export GIT_SSH_COMMAND="ssh -o UserKKnownHostsFile=/root/.ssh/known_hosts -i /root/.ssh/id_ed25519"
# Clone the repositoy  into the 'repo' directory
git clone "$URL" repo
if [ ! -d "repo" ]; then
  echo "Error: failed to clone repository."
  exit 1
fi
# Change to the cloned repository (quitting if it does not exist)
cd repo || exit 1
# Launch Neovim in the local repository directory
exec nvim
