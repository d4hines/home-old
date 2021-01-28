#!/usr/bin/env bash
set -xe

####### Install OPAM deps
sudo apt-get update
export DEBIAN_FRONTEND=noninteractive
sudo apt-get -y install --no-install-recommends \
     rsync m4 build-essential patch unzip \
     wget pkg-config libgmp-dev libev-dev libhidapi-dev \
     libffi-dev opam jq autoconf

###### Install Python
# Install deps
sudo apt-get install -y build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev libffi-dev liblzma-dev python-openssl git 
# Install pyenv
curl https://pyenv.run | bash

export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

echo "export PATH=\"\$HOME/.pyenv/bin:\$PATH\"" >> ~/.bashrc
eval "$(pyenv init -)" >> ~/.bashrc
eval "$(pyenv virtualenv-init -)" >> ~/.bashrc

pyenv install 3.8.5
pyenv global 3.8.5

##Install Poetry
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 -

####### Install Rust
wget https://sh.rustup.rs/rustup-init.sh
chmod +x rustup-init.sh
./rustup-init.sh --profile minimal --default-toolchain 1.39.0 -y
source $HOME/.cargo/env

# Make a symlink e.g. 
# ln -s /mnt/c/Users/d4hin/repos ~/repos

# Set up OPAM
# opam init -y

# Install Tezos deps
# make build-dev-deps

# Build Tezos
# make