# lazyvim-container-base
Repo to build a base Lazyvim container with a couple extra scripts to reduce the typing needed to jump into a repo and get coding.

# Running this Image

## Scripted
Download `dev.sh` from this repo as an example bash script you can run (chmod it with +x).
Example usage: `./dev.sh git@github.com:digitalnightjar/lazyvim-container-base.git`

### Notes
Ensure you already have your host machines ssh key configured with your git host.
If you want more persistence make sure you create a folder named `dev_volume` in the same directory as `dev.sh`

## Manual
You can pull this image manually with docker or podman: `docker pull digitalnightjar/lazyvim-container-base:latest`
You will want to run the container as an interactive session, preferably with the `--rm` flag to prevent dangling containers, 
as well as mount your `.ssh` directory and .gitconfig (look at dev.sh for an example of how to set these up)
`docker run --rm --it digitalnightjar/lazyvim-container-base:latest git@github.com:digitalnightjar/lazyvim-container-base.git`
