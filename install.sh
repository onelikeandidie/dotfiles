#!/usr/bin/env bash

# install some deps for this installer
sudo pacman -S curl clang-16

# This installer only works with arch-based rn I think.
# First part is to install zsh, cuz it's epic
sudo pacman -S zsh

# omz
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# With rust we can now install the real stuff
# Zellij for some terminal goodness
cargo install zellij
mkdir -p ~/.config/zellij
cp ./zellij/config.kdl ~/.config/zellij/config.kdl

# Install helix
mkdir installers && cd installers || exit 0
git clone https://github.com/helix-editor/helix && cd helix || exit 0
# This is the version I created my config with
git checkout 23.10
cargo install --path helix-term --locked
# Link the runtime dir
mkdir -p ~/.config/helix
ln -Ts "$PWD/runtime" ~/.config/helix/runtime

# Download grammars lol
# This should automatically put it inside the linked runtime dir
hx --grammar fetch && hx --grammar build || exit 0

cd ..
# Copy our configs
cp ./helix/config.toml ~/.config/helix/config.toml
cp ./helix/languages.toml ~/.config/helix/languages.toml

# We could install some lsps now but I guess that's up to you or me
