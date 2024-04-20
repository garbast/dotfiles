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