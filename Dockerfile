FROM ubuntu:latest
LABEL maintainer="Karl Eyre <digitalnightjar@outlook.com>"
# Base packages
RUN apt update && apt install -y sudo curl git-core gnupg zsh wget locales software-properties-common openssh-client
RUN locale-get en_GB.UTF-8
# Install base environment tools
RUN add-apt-repository ppa:neovim-ppa/stable -y
RUN apt update
RUN apt install -y tmux neovim fonts-powerline build-essential ripgrep fd-find
# Install Lazygit
WORKDIR /tmp
RUN LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*') && curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
RUN tar xf lazygit.tar.gz lazygit
RUN install lazygit /usr/local/bin
# Copy the lazyvim configuration into the container
RUN mkdir -p /root/.config/nvim
COPY --chown=root:root ./lazyvim /root/.config/nvim
ENV TERM xterm
# Create working directory
WORKDIR /root/workspace
COPY --chown=root:root --chmod=0755 entrypoint.sh /root/entrypoint.sh
ENTRYPOINT ["/root/entrypoint.sh"]
CMD ["nvim"]
