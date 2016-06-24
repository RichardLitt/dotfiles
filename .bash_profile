## Colors
source ~/.bashrc

## Prompt
#export PS1="\A \w $ "

## https://spin.atomicobject.com/2016/05/28/log-bash-history/
export PROMPT_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log; fi'

# From https://github.com/jimeh/git-aware-prompt
source "/Users/richard/.bash/git-aware-prompt/colors.sh"

find_git_branch() {
  # Based on: http://stackoverflow.com/a/13003854/170413
  local branch
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      branch='detached*'
    fi
    git_branch="($branch) "
  else
    git_branch=""
  fi
}

find_git_dirty() {
  local status=$(git status --porcelain 2> /dev/null)
  if [[ "$status" != "" ]]; then
    git_dirty='* '
  else
    git_dirty=''
  fi
}

# parse_git_stash() {
#     [[ $(git stash list 2> /dev/null | tail -n1) != "" ]] && echo ' \[\e[0;31m\]☣'
# }
 
# set_bash_prompt(){
#     PS1="\A \w$(parse_git_stash) \[\e[0m\]🐕  "
# }
 
# PROMPT_COMMAND=set_bash_prompt

PROMPT_COMMAND="find_git_branch; find_git_dirty; $PROMPT_COMMAND"

# Default Git enabled prompt with dirty state
export PS1="\A \w \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]🐕  "

## Aliases

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias -- -="cd -"
function lsf() {
  for f in *; do [[ -d "$f" ]] || ls -- "$f"; done
}

# Shortcuts
alias d="cd ~/Documents"
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias src="cd ~/src"
alias beagle="cd ~/src/beagle"
alias h="history"

## Stupid stuff
alias ifps=ipfs
alias twitch="subl ~/src/closed-door/life_list.md"

function contribute {
  printf "## Contribute\n\
\n\
Feel free to join in. All welcome. Open an [issue](https://github.com/ipfs/${PWD##*/}/issues)!\n\
\n\
This repository falls under the IPFS [Code of Conduct](https://github.com/ipfs/community/blob/master/code-of-conduct.md).\n\
\n\
[![](https://cdn.rawgit.com/jbenet/contribute-ipfs-gif/master/img/contribute.gif)](https://github.com/ipfs/community/blob/master/contributing.md)\n"
}

function badges {
  printf "[![](https://img.shields.io/badge/made\%20by-Protocol\%20Labs-blue.svg?style=flat-square)](http://ipn.io)\n\
[![](https://img.shields.io/badge/project-IPFS-blue.svg?style=flat-square)](http://ipfs.io/)\n\
[![](https://img.shields.io/badge/freenode-%23ipfs-blue.svg?style=flat-square)](http://webchat.freenode.net/?channels=%23ipfs)\n\
[![standard-readme compliant](https://img.shields.io/badge/standard--readme-OK-green.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme)\n"
}

function discussion {
  printf "[![](https://img.shields.io/badge/discussion_repo-go_to_issues-brightgreen.svg?style=flat-square)](https://github.com/ipfs/${PWD##*/}/issues)\n\
\n\
This is a **discussion repo**. That means that all of the work gets done in the [issues](https://github.com/ipfs/${PWD##*/}/issues).\n"
}

# Productivity helpers
alias timestamp=rl-timestamp
export IPFS='/Users/richard/src/closed-door/IPFS.md'
alias tasks="subl $IPFS"
alias pb="pbcopy"
function ipfs-status () {
  timestamp "-f" "$IPFS" "$1"
}
alias notes="subl ~/src/docs/notes.md"
alias todo="subl ~/src/closed-door/todo.md"
function trello() {
  trello-helpers "$1" "$2" "$3"
}
alias tt='trello-helpers today'
alias next="trello -l 'Today' | head -n 1"
function notif () {
  open-github-notifications "$1" "$2" "$3"
}
function npmv () {
  geopkg version "$1"
}

# Programs
alias sublime='open -a "Sublime Text"'
alias subl=sublime
alias ia='open -a "ia Writer"'
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --disable-extensions-http-throttling'
function gmp() {
  FILE=$PWD'/'$1'.html'
  touch $FILE
  open -a 'Google Chrome' 'file://'$FILE
  github-markdown-preview $1
}
alias ogn="notif"

### git
alias g="git"
alias git="hub"
eval "$(hub alias -s)"
alias gg='git log --oneline --abbrev-commit --all --graph --decorate --color'
alias gg5='gg | head -n5'
alias gk='g k'
alias gits='git status'
alias gitprune='git branch --merged | grep -v "\*" | grep -v master | grep -v dev | xargs -n 1 git branch -d'
function gitcf() {
  git clone $1
  IFS='/' read -a array <<< "$1"
  cd "${array[1]}"
  git fork
  git rr
}
function gbi() {
  git browse -- 'issues/'$1
}

PATH="~/src/dotfiles/git/:$PATH"

# Stopwatch
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

# Get OS X Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
alias update='sudo softwareupdate -i -a; brew update; brew upgrade --all; brew cleanup; npm install npm -g; npm update -g; sudo gem update --system; sudo gem update'

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Flush Directory Service cache
alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"

# View HTTP traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# Kill all the tabs in Chrome to free up memory
# [C] explained: http://www.commandlinefu.com/commands/view/402/exclude-grep-from-your-grepped-output-of-ps-alias-included-in-description
alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"

# Lock the screen (when going AFK)
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

#### Autocomplete
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

## Ruby
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

## PATH 
### For Geektool
PATH=$PATH

export GOPATH=$HOME/gocode
export PATH=$PATH:$GOPATH/bin

## Env vars
# source ~/.env
# export POETRY=/Users/richard/src/closed-door/poetry/
