## Colors
source ~/.bashrc

## Env vars
source ~/.env

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

convert_to_text() {
  pbpaste | textutil -convert txt -stdin -stdout -encoding 30 | pbcopy
}

empty-mail() {
  > /var/mail/richard # Pipe nothing into the mailbox
  rm -f ~/mbox # Delete only if it exists
  echo "Mail emptied."
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
function newtab() {
  pwd | xargs ttab -d
}


# Shortcuts
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias src="cd ~/src"
alias knowledge="cd ~/docs/knowledge/"
alias k=knowledge
alias docs="cd ~/docs"
alias d=docs
alias h="history"
alias py="python"
alias thesis="cd ~/src/thesis/"


## Stupid stuff
alias ifps=ipfs
alias fuck='echo \"There can be only one. Highlander.\"'
alias lotr="choose-a-deck"

# function lotr() {
#   node ~/src/sandbox/lotrtcg/dice.js "$1"
# }

## Timestamper
# No longer used. Set $LOG if you need to track timestamps.
#alias timestamp=rl-timestamp
#function work-status () {
#  timestamp "-f" "$LOG" "$1"
#}

# Refresh Atom
# Occasionally, atom randomly stops working.
function refresh_atom() {
  rm /usr/local/bin/atom
  ln -s /Applications/Atom.app/Contents/Resources/app/atom.sh /usr/local/bin/atom
}

## Document todo lists
export BASEDIR=/Users/richard/docs/todo/
export IDE=atom
alias journal='journall'
alias next='atom '$BASEDIR'nextActions.md'
alias someday='atom '$BASEDIR'someday.md'
alias waiting='atom '$BASEDIR'waiting.md'
alias projects='atom '$BASEDIR
alias today='ship -p '$BASEDIR'log --tasksfile '$BASEDIR'todo.md -r '$BASEDIR'daily_routines.md'
alias t=today
alias tomorrow='ship -m -p '$BASEDIR'log --tasksfile '$BASEDIR'todo.md -r '$BASEDIR'daily_routines.md'
alias yesterday='ship -y -p '$BASEDIR'log'
alias y=yesterday
alias todo=$IDE' '$BASEDIR'todo.md'
alias incoming=todo
alias producteev='open https://www.producteev.com/workspace/n/576ad37f2adaeac059000004/u/576ad2edb0fa09883c000008'

## Trello
# function trello() {
#   trello-helpers "$1" "$2" "$3"
# }
# alias tt='trello-helpers today'
# alias next="trello -l 'Today' | head -n 1"

# Programs
## For using normal npm
function npmv () {
  geopkg version "$1"
}

function mit-package.json () {
  json -I -f package.json -e 'this.license="MIT"'
}

## For using np
alias np='geoip update && np'
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
function notif () {
  open-github-notifications "$1" "$2" "$3"
}
alias ogn="notif"

function nr () {
  if [[ $2 ]]; then
    ghi label $1 "needs review" -- $2
  else
    ghi label $1 "needs review"
  fi
}

### git
alias g="git"
alias git="hub"
#eval "$(hub alias -s)"
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

## yarn
export PATH="$PATH:$HOME/.yarn/bin"
export GOPATH=$HOME/gocode
export PATH=$PATH:$GOPATH/bin

# Setting PATH for Python 3.5
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
export PATH

# Keychain; installed to use with cronjob with git and ssh
/usr/local/bin/keychain $HOME/.ssh/id_rsa --quiet
source $HOME/.keychain/${HOSTNAME}-sh
