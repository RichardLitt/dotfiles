export CLICOLOR=""
export VISUAL=vim
export EDITOR="$VISUAL"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export NVM_DIR="/Users/richard/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
export TERM=xterm-256color

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# added by travis gem
[ -f /Users/richard/.travis/travis.sh ] && source /Users/richard/.travis/travis.sh

## bash and zsh only!
# functions to cd to the next or previous sibling directory, in glob order

# prev () {
#     # default to current directory if no previous
#     local prevdir="./"
#     local cwd=${PWD##*/}
#     if [[ -z $cwd ]]; then
#         # $PWD must be /
#         echo 'No previous directory.' >&2
#         return 1
#     fi
#     for x in ../*/; do
#         if [[ ${x#../} == ${cwd}/ ]]; then
#             # found cwd
#             if [[ $prevdir == ./ ]]; then
#                 echo 'No previous directory.' >&2
#                 return 1
#             fi
#             cd "$prevdir"
#             return
#         fi
#         if [[ -d $x ]]; then
#             prevdir=$x
#         fi
#     done
#     # Should never get here.
#     echo 'Directory not changed.' >&2
#     return 1
# }

# next () {
#     local foundcwd=
#     local cwd=${PWD##*/}
#     if [[ -z $cwd ]]; then
#         # $PWD must be /
#         echo 'No next directory.' >&2
#         return 1
#     fi
#     for x in ../*/; do
#         if [[ -n $foundcwd ]]; then
#             if [[ -d $x ]]; then
#                 cd "$x"
#                 return
#             fi
#         elif [[ ${x#../} == ${cwd}/ ]]; then
#             foundcwd=1
#         fi
#     done
#     echo 'No next directory.' >&2
#     return 1
# }