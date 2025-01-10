function composer() {
  mkdir -p "${HOME}/.config/composer"
  mkdir -p "${HOME}/.cache/composer"
  docker run -t \
    --user $(id -u):33 \
    --env COMPOSER_CACHE_DIR=/cache \
    --env SSH_AUTH_SOCK=/ssh-agent \
    --env CI_HOST \
    --env CI_PROJECT_DIR \
    --env ENVIRONMENT_NAME \
    --env INSTANCE_ID \
    --env ADDITIONAL_CONFIG_FILE \
    --env TYPO3_CONTEXT \
    --env STAGE \
    --network db \
    --volume "$(readlink -f ${SSH_AUTH_SOCK})":/ssh-agent \
    --volume /etc/passwd:/etc/passwd:ro \
    --volume "${HOME}":"${HOME}" \
    --volume "${HOME}/.config/composer":/tmp \
    --volume "${HOME}/.cache/composer":/cache \
    --volume "${CI_PROJECT_DIR}":"${CI_PROJECT_DIR}" \
    --volume "${PWD%}":/app \
    evoweb/php:composer $@
}
alias composer=composer