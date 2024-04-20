if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
        command-not-found
        common-aliases
        composer
        docker
        git
        git-extras
        git-flow-avh
        npm
        rsync
        ssh-agent
)

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

unset NPM_CONFIG_PREFIX
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$HOME/.npm-global/bin:$PATH"

function cdWeb() {
	cd /home/www/$1/www
}
alias www=cdWeb

function git_cleanup_local_branches() {
    git fetch -p
    for branch in $(git for-each-ref --format '%(refname) %(upstream:track)' refs/heads | awk '$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}');
    do
        git branch -D $branch;
    done
}
alias git_clb=git_cleanup_local_branches

function composer() {
    mkdir -p $HOME/.config/composer
    mkdir -p $HOME/.cache/composer
    docker run -t \
        --user $(id -u):33 \
        --env COMPOSER_HOME=/config \
        --env COMPOSER_CACHE_DIR=/cache \
	--env SSH_AUTH_SOCK=/ssh-agent \
	--network db \
	--volume $(readlink -f $SSH_AUTH_SOCK):/ssh-agent \
	--volume /etc/passwd:/etc/passwd:ro \
	--volume $HOME/:$HOME/ \
        --volume $HOME/.config/composer:/config \
        --volume $HOME/.cache/composer:/cache \
        --volume $PWD:/app \
	--volume /home/www/AdditionalConfiguration.php:/AdditionalConfiguration.php \
        evoweb/php:composer $@
}
alias composer=composer

function lazydocker() {
    mkdir -p $HOME/.config/lazydocker
    docker run --rm -it \
        --volume /var/run/docker.sock:/var/run/docker.sock \
        --volume $HOME/.config/lazydocker:/.config/jesseduffield/lazydocker \
        lazyteam/lazydocker
}
alias lazydocker=lazydocker
