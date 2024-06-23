# Dotfiles

## Setup

1. If machine comes with useful _.bashrc_, etc (work laptop), run `./backup.sh`
2. Run `./stow.sh`
3. Either:
  - Machine was provisioned already with Ansible (i.e. personal machine)
  - This is a Mac: `brew bundle install --file=./Brewfile`
4. Finally `./finish-setup.sh`

## On Macs

Depending on if you need to update XCode, this could take minutes, or eons...

- Install [Homebrew](https://brew.sh/) before step 3
- A few apps require the latest XCode (App Store does not auto-update it) and then run `xcode-select --install` to run a GUI installer for idk what. Those apps are:
  - jira-cli
  - openssh
  - pipx
- Follow setup instructions for [Amethyst](https://ianyh.com/amethyst/)
