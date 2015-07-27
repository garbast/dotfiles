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

source ~/.antigen.zsh

antigen use oh-my-zsh

antigen bundles <<EOBUNDLES
	command-not-found

	git
	svn
	
	sublime
	ssh-agent
EOBUNDLES

DEFAULT_USER=sebastian

# Install powerline font for agnoster icons
# http://askubuntu.com/questions/283908/how-can-i-install-and-use-powerline-plugin
antigen theme gnzh

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

export TODOTXT_SORT_COMMAND='env LC_COLLATE=C sort -k 2,2 -k 1,1n'
export TODOTXT_DEFAULT_ACTION=ls
alias t='todo -d /home/sebastian/Dokumente/Shellscripts/todo.cfg'

alias svn_add='for file in $(svn status | egrep "^\?" | awk '"'"'{print $2}'"'"'); do svn add $file; done'
alias svn_del='for file in $(svn status | egrep "^\!" | awk '"'"'{print $2}'"'"'); do svn del $file; done'
alias svn_lasttag='svn ls ^/tags/ | egrep -v "[a-Z+_\-]" | sort -V | tail -n 1 | sed "s/\///g"'
