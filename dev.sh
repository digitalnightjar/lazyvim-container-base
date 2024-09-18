#!/bin/bash
mkdir -p ./dev_volume/local/share/nvim
mkdir -p ./dev_volume/local/state/nvim
mkdir -p ./dev_volume/cache/nvim
docker run --rm -it \
  -v ~/.ssh/:/root/.ssh:ro \
  -v ./dev_volume/local/share/nvim:/local/share/nvim \
  -v ./dev_volume/local/state/nvim:/local/state/nvim \
  -v ./dev_volume/cache/nvim:/root/.cache/nvim \
  -v ~/.gitconfig:/root/.gitconfig \
  digitalnightjar/lazyvim-container-base:latest \
  $1
