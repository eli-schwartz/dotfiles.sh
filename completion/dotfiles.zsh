#compdef dotfiles

_dotfiles () {
    local dotfiles_dir GIT_DIR

    if [[ -f ${XDG_CONFIG_HOME:-$HOME/.config}/dotfiles.conf ]]; then
        source "${XDG_CONFIG_HOME:-$HOME/.config}"/dotfiles.conf
        export GIT_DIR="$dotfiles_dir"
    fi

    service=git
    declare -f _git >& /dev/null && _git
}

_dotfiles
