#!/bin/bash
# Shared helpers for installers. Source it: . "$REPO_ROOT/cmd/lib.bash"

DOTFILES_BACKUP_DIR="${DOTFILES_BACKUP_DIR:-$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)}"

# link <repo file> <target path>
# Symlinks target -> repo file so edits on the machine land in the repo.
# An existing real file at the target is moved into $DOTFILES_BACKUP_DIR first.
link() {
    local src="$1" dst="$2"
    [[ -e "$src" ]] || { echo "link: missing source $src" >&2; return 1; }
    mkdir -p "$(dirname "$dst")"
    if [[ -L "$dst" ]]; then
        rm -f "$dst"
    elif [[ -e "$dst" ]]; then
        mkdir -p "$DOTFILES_BACKUP_DIR"
        mv "$dst" "$DOTFILES_BACKUP_DIR/$(echo "${dst#$HOME/}" | tr '/' '_')"
        echo "backed up $dst -> $DOTFILES_BACKUP_DIR"
    fi
    ln -s "$src" "$dst"
    echo "linked $dst -> $src"
}
