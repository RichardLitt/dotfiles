# When running a new Ubuntu machine

```sh
mkdir ~/src && cd ~/src
git clone https://github.com/RichardLitt/dotfiles.git
cd dotfiles
git remote set-url origin git@github.com:RichardLitt/dotfiles.git
cd ..
sudo apt update
sudo apt install vim atom gnome-shell-pomodoro git-extras
sudo snap install --classic hub
git clone RichardLitt/knowledge
cp dotfiles/git/.gitconfig ~/.gitconfig
```

### Configuration steps

1. Log into GitHub.
2. Add an SSH key into GitHub.

### .bashrc

Add these to your .bashrc file:

```sh
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias -- -="cd -"

### git
alias g="git"
alias git="hub"
alias github="git browse --"
#eval "$(hub alias -s)"
alias gg='git log --oneline --abbrev-commit --all --graph --decorate --color'
alias gg5='gg | head -n5'
alias gk='g k'
alias gits='git status'
alias gitprune='git branch --merged | grep -v "\*" | grep -v master | grep -v dev | xargs -n 1 git branch -d'
function gbi() {
  git browse -- 'issues/'$1
}
```
