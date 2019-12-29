# Set up the prompt
export TERM="xterm-256color"

autoload -Uz promptinit

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

fpath=($HOME/.dotfile/functions $fpath)

source ~/.antigen.zsh

DEFAULT_USER=sebastian

antigen use oh-my-zsh

antigen bundles <<EOBUNDLES
	command-not-found

	common-aliases

	git
	svn
	composer

	sublime
	ssh-agent
	rsync

	zsh-users/zsh-syntax-highlighting
	zsh-users/zsh-history-substring-search ./zsh-history-substring-search.zsh
EOBUNDLES

antigen theme romkatv/powerlevel10k powerlevel10k

antigen apply

if [ "$TMUX" = "" ]; then
#       SHELL=/usr/bin/zsh tmux;
fi

# Web Stuff
function cdWeb() {
	cd /home/www/$1/$2
}
alias web=cdWeb

alias gitffs='echo "Feature Name:" && read BRANCH_NAME ; git flow feature start ${BRANCH_NAME} && git flow feature publish ${BRANCH_NAME}'
alias gitfff='declare -a LIST=($(i=1; for branch in $(git branch --list | grep -v master | grep -v develop | sed s/\*//); do echo $branch; echo "$(git rev-list -n 1 $branch)";  done)); CHOICE=$(dialog --clear --backtitle "Select your poison" --title "Features to finish" --menu "Choose one of the following options:" 40 100 4 "$LIST[@]" 2>&1 >/dev/tty); test -z $CHOICE || git flow feature finish ${CHOICE/feature\//} && git push --all'
alias gitfrs_patch='TAG="$(git_lasttag | awk -F. '"'"'{print $1"."$2"."$3+1}'"'"')"; git flow release start "${TAG}" && git flow release finish "${TAG}" && git push --all && git push --tags'
alias gitfrs_minor='TAG="$(git_lasttag | awk -F. '"'"'{print $1"."$2+1".0"}'"'"')"; git flow release start "${TAG}" && git flow release finish "${TAG}" && git push --all && git push --tags'
alias gitfrs_major='TAG="$(git_lasttag | awk -F. '"'"'{print $1+1".0.0"}'"'"')"; git flow release start "${TAG}" && git flow release finish "${TAG}" && git push --all && git push --tags'
alias git_flow_release_start_patch='gitfrs_patch'
alias git_flow_release_start_minor='gitfrs_minor'
alias git_flow_release_start_major='gitfrs_major'

alias glog="\git log --color --all --date-order --decorate --dirstat=lines,cumulative --stat | sed 's/\([0-9] file[s]\? .*)$\)/\1\n_______\n-------/g' | \less -R"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

