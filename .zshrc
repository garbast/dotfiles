export ZSH="/home/$(whoami)/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(command-not-found common-aliases composer docker git git-extras git-flow-avh npm rsync ssh-agent)

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
source /home/.dotfiles/.p10k.zsh

# Web Stuff
function cdWeb() {
	cd /home/www/$1/www
}
alias www=cdWeb

function composer() {
    mkdir -p $HOME/.config/composer
    mkdir -p $HOME/.cache/composer
    docker run -t \
        --user $(id -u):33 \
        --env COMPOSER_HOME=/config \
        --env COMPOSER_CACHE_DIR=/cache \
	--network db \
	--volume /etc/passwd:/etc/passwd:ro \
	--volume $HOME/:$HOME/ \
        --volume $HOME/.config/composer:/config \
        --volume $HOME/.cache/composer:/cache \
        --volume $PWD:/app \
        evoweb/php:composer $@
}
alias composer=composer

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$HOME/.npm-global/bin:$PATH"

NPM_CONFIG_PREFIX=~/.npm-global

source /home/.dotfiles/t3doc.sh
