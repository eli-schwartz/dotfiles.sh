#!/bin/bash

if ! declare -F _git > /dev/null && declare -F _completion_loader > /dev/null; then
  _completion_loader git
fi

_dotfiles() {
    local dotfiles_dir GIT_DIR

    if [[ -f ${XDG_CONFIG_HOME:-$HOME/.config}/dotfiles.conf ]]; then
        source "${XDG_CONFIG_HOME:-$HOME/.config}"/dotfiles.conf
        export GIT_DIR="$dotfiles_dir"
    fi

    __git_wrap__git_main "$@"
}

complete -o bashdefault -o default -o nospace -F _dotfiles dotfiles
