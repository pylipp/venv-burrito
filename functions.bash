#!/bin/bash

mkvirtualenv() {
    [ $# -ne 1 ] && return 1

    python3 -m venv "$WORKON_HOME/$1"
    workon "$1"
    pip install -U pip
}

workon() {
    source "$WORKON_HOME/$1/bin/activate"
}

lsvirtualenv() {
    find "$WORKON_HOME" -mindepth 1 -maxdepth 1 -type d -exec basename '{}' \; | sort
}

cdvirtualenv() {
    if [ -n "$VIRTUAL_ENV" ]; then
        cd "$VIRTUAL_ENV"
        return 0
    fi
    echo "No venv activated!" >&2
    return 1
}

rmvirtualenv() {
    [ $# -ne 1 ] && return 1

    if [ -n "$VIRTUAL_ENV" ]; then
        if [ $(basename "$VIRTUAL_ENV") = $1 ]; then
            echo "Cannot remove activated venv!" >&2
            return 1
        fi
    else
        rm -r "$WORKON_HOME/$1"
    fi
}
