# Dotfiles

## Setup

1. If machine comes with useful _.bashrc_, etc (work laptop), run `./backup.sh`
2. Run `./stow.sh`
3. Either:
  - Machine was provisioned already with Ansible (i.e. personal machine)
  - This is a Mac: `brew bundle install --file=./Brewfile`
4. Finally `./finish-setup.sh`

## On Macs

- Install [Homebrew](https://brew.sh/) before step 3
- Follow setup instructions for [Amethyst](https://ianyh.com/amethyst/)
