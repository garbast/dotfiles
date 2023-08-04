export ZSH="/home/$(whoami)/.oh-my-zsh"

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
alias gpa="git remote prune origin && git push --all"

alias composer2='mkdir -p $HOME/.config/composer && mkdir -p $HOME/.cache/composer  && docker run --user $(id -u):$(id -g) --env COMPOSER_HOME=/config --env COMPOSER_CACHE_DIR=/cache --volume $HOME/.config/composer:/config --volume $HOME/.cache/composer:/cache --volume $PWD:/app composer:latest $@'

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$HOME/.npm-global/bin:$PATH"

NPM_CONFIG_PREFIX=~/.npm-global

# run docker container and source shell commands
alias t3docrun='source <(docker run --rm t3docs/render-documentation show-shell-commands)'

# build docs
alias t3docmake='dockrun_t3rd makehtml'

# open generated docs in browser (uses t3open alias, see above)
# - use xdg-open for Linux
# - use open for Mac instead !!!
alias t3docopen='xdg-open "file:///$(pwd)/Documentation-GENERATED-temp/Result/project/0.0.0/Index.html"'

# remove generated docs
alias t3docclean='rm -rf Documentation-GENERATED-temp/'

# --- combined aliases ---

# run docker, generate documentation and open result in browser
alias t3doc='t3docrun && t3docmake && t3docopen'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

