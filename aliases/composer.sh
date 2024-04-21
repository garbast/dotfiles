function composer() {
  mkdir -p "${HOME}/.config/composer"
  mkdir -p "${HOME}/.cache/composer"
  docker run -t \
    --user $(id -u):33 \
    --env COMPOSER_HOME=/config \
    --env COMPOSER_CACHE_DIR=/cache \
    --env SSH_AUTH_SOCK=/ssh-agent \
    --network db \
    --volume "$(readlink -f ${SSH_AUTH_SOCK})":/ssh-agent \
    --volume /etc/passwd:/etc/passwd:ro \
    --volume "${HOME}":"${HOME}" \
    --volume "${HOME}/.config/composer":/config \
    --volume "${HOME}/.cache/composer":/cache \
    --volume "${HOME}":/app \
    --volume /home/www/AdditionalConfiguration.php:/AdditionalConfiguration.php \
    evoweb/php:composer $@
}
alias composer=composer