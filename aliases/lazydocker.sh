function lazydocker() {
  mkdir -p $HOME/.config/lazydocker
  docker run --rm -it \
    --volume /var/run/docker.sock:/var/run/docker.sock \
    --volume $HOME/.config/lazydocker:/.config/jesseduffield/lazydocker \
    lazyteam/lazydocker
}
alias lazydocker=lazydocker
