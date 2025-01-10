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
    git-prompt
    git-extras
    git-flow-avh
    npm
    rsync
    ssh-agent
)

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[ -f ~/.p10k.zsh ] && source ~/.p10k.zsh

unset NPM_CONFIG_PREFIX
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.local/bin:$HOME/.npm-global/bin:$PATH"

# import aliases
[ -d /home/dotfiles/aliases ] && for script in /home/dotfiles/aliases/*.sh; do source $script; done

# To customize prompt, run `p10k configure` or edit /home/dotfiles/zsh/.p10k.zsh.
[ -f /home/dotfiles/zsh/.p10k.zsh ] && source /home/dotfiles/zsh/.p10k.zsh
