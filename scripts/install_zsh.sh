#!/usr/bin/env bash

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git --branch v3.0.2 --single-branch
cd nerd-fonts
chmod a+x ./install.sh
./install.sh
cd -

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git --branch v1.19.0 --single-branch ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
#echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

