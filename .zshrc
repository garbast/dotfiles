# Set up the prompt

autoload -Uz promptinit
#promptinit
#prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=20000
HISTFILE=~/.zsh_history

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
SVN_SHOW_BRANCH="true"

antigen use oh-my-zsh

antigen bundles <<EOBUNDLES
	command-not-found

	common-aliases

	git
	svn

	sublime
	ssh-agent
	rsync

	zsh-users/zsh-syntax-highlighting
	zsh-users/zsh-history-substring-search ./zsh-history-substring-search.zsh
EOBUNDLES

# Install powerline font for agnoster icons
# http://askubuntu.com/questions/283908/how-can-i-install-and-use-powerline-plugin
antigen theme garbast/dotfiles themes/gnzh-v2

antigen apply


# MFC Stuff
mountMfc()
{
	mount /media/mfc/$1
	cd /media/mfc/$1
}
alias cdm=mountMfc

cdMfc()
{
	cd /home/www/mfc/$1/htdocs
}
alias mfc=cdMfc

getWeather()
{
	echo "http://wttr.in/$1"
	curl "http://wttr.in/$1"
}
alias wetter=getWeather
alias weather=getWeather

export TODOTXT_SORT_COMMAND='env LC_COLLATE=C sort -k 2,2 -k 1,1n'
export TODOTXT_DEFAULT_ACTION=ls
alias t='todo -d /home/sebastian/Dokumente/Shellscripts/todo.cfg'

alias svn_add='for file in $(svn status | egrep "^\?" | awk '"'"'{print $2}'"'"'); do svn add $file; done'
alias svn_del='for file in $(svn status | egrep "^\!" | awk '"'"'{print $2}'"'"'); do svn del $file; done'
alias svn_lasttag='svn ls ^/tags/ | egrep -v "[a-Z+_\-]" | sort -V | tail -n 1 | sed "s/\///g"'
alias svn_tagpatch='echo "Commit Message:" && read COMMIT_MESSAGE && svn cp ^/trunk ^/tags/"$(svn_lasttag | awk -F. '"'"'{print $1"."$2"."$3+1}'"'"')" -m "${COMMIT_MESSAGE}" && echo "created: $(svn_lasttag)"'
alias svn_tagminor='echo "Commit Message:" && read COMMIT_MESSAGE && svn cp ^/trunk ^/tags/"$(svn_lasttag | awk -F. '"'"'{print $1"."$2+1".0"}'"'"')" -m "${COMMIT_MESSAGE}" && echo "created: $(svn_lasttag)"'
alias svn_tagmajor='echo "Commit Message:" && read COMMIT_MESSAGE && svn cp ^/trunk ^/tags/"$(svn_lasttag | awk -F. '"'"'{print $1+1".0.0"}'"'"')" -m "${COMMIT_MESSAGE}" && echo "created: $(svn_lasttag)"'
alias svn_branch='BRANCH_NAME=""; while [ ! -z "$(svn ls ^/branches/${BRANCH_NAME} 2>/dev/null)" ]; do echo "Branch Name:" && read BRANCH_NAME; done ; echo "Commit Message:" && read COMMIT_MESSAGE && svn cp ^/trunk ^/branches/"${BRANCH_NAME}" -m "${COMMIT_MESSAGE}" && svn switch ^/branches/"${BRANCH_NAME}"'

alias gitffs='echo "Feature Name:" && read BRANCH_NAME ; git flow feature start ${BRANCH_NAME} && git flow feature publish ${BRANCH_NAME}'
alias gitfff='declare -a LIST=($(i=1; for branch in $(git branch --list | grep -v master | grep -v develop | sed s/\*//); do echo $branch; echo "$(git rev-list -n 1 $branch)";  done)); CHOICE=$(dialog --clear --backtitle "Select your poison" --title "Features to finish" --menu "Choose one of the following options:" 40 100 4 "$LIST[@]" 2>&1 >/dev/tty); test -z $CHOICE || git flow feature finish ${CHOICE/feature\//} && git push --all'
alias gitfrs_patch='TAG="$(git_lasttag | awk -F. '"'"'{print $1"."$2"."$3+1}'"'"')"; git flow release start "${TAG}" && git flow release finish "${TAG}" && git push --all && git push --tags'
alias gitfrs_minor='TAG="$(git_lasttag | awk -F. '"'"'{print $1"."$2+1".0"}'"'"')"; git flow release start "${TAG}" && git flow release finish "${TAG}" && git push --all && git push --tags'
alias gitfrs_major='TAG="$(git_lasttag | awk -F. '"'"'{print $1+1".0.0"}'"'"')"; git flow release start "${TAG}" && git flow release finish "${TAG}" && git push --all && git push --tags'
alias git_flow_feature_start='gitffs'
alias git_flow_feature_finish='gitfff'
alias git_flow_release_start_patch='gitfrs_patch'
alias git_flow_release_start_minor='gitfrs_minor'
alias git_flow_release_start_major='gitfrs_major'

alias sf="php ./bin/console"
