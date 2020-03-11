# Dotfiles

My dotfiles.

Note: To stop conflicts, I have two .git files in the git/ folder. Install those, too.
I reference a `.env` file where I keep keys. Obviously, that is not added here. 

### Installation

On a new machine, install:
 - [homebrew](https://github.com/Homebrew/brew)
  - Then use brew bundle to install, using the Brewfile in this repo.
 - go
 - node
 - nvm
 - dotfiles here
 - hub
 - [git-extras](https://github.com/tj/git-extras/blob/master/Installation.md)
 - git-aware-prompt
 - ipfs
 - Sublime [package manager](https://packagecontrol.io/installation)
 - Vundle: `git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`

Run:

```
stty -ixon
# https://stackoverflow.com/questions/17760474/reverse-intelligent-search-reverse-i-search-how-to-get-previous-result
```


#### Global node packages

Put these into a file and run: `cat file | xargs -n1 npm i -g`

alex
commitizen
covgen
csvtojson
doctoc
geopkg
gh-description
gh-stars
git-unsaved
github-activity-stats
github-description
github-description-cli
github-email
github-repositories
github-star-repo
gulp
gulp-cli
ignore-github-users
is-github-user-or-org
jabbar
journall
license
licensee
licensor
markdown-pdf
markdown-to-html
marky-markdown
md2html
name-your-contributors
now
npm-check-updates
npm-name-cli
open-github-notifications
orbit-db
orbit-db-cli
osx-learn
readme
semantic-release-cli
ships-log
standard
tap
validate-maintainers
vmd
wallpaper-cli
watch-gh-repos
whodidwhat
write-good
ynab-convert-csv

### Other things to do

- Follow [this StackOverflow](https://stackoverflow.com/questions/127591/using-caps-lock-as-esc-in-mac-os-x) issue to remap <kbd>caps lock</kbd> as <kbd>esc</kbd>.
