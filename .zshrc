export ZSH="/home/${whoami}/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(command-not-found common-aliases composer docker git git-extras git-flow-avh npm rsync ssh-agent)

source $ZSH/oh-my-zsh.sh

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

alias composer1='docker run --volume $PWD:/app composer:1 $@'
alias composer2='docker run --volume $PWD:/app composer:2 $@'

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

