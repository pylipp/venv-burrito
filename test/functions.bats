load ../functions

setup() {
    export WORKON_HOME=~/.virtualenvs
}

teardown() {
    rm -rf "$WORKON_HOME"
}

@test "mkvirtualenv command without argument fails" {
    run mkvirtualenv
    [ $status -eq 1 ]
}

@test "mkvirtualenv command with more than one argument fails" {
    run mkvirtualenv a b
    [ $status -eq 1 ]
}

@test "mkvirtualenv command with single argument creates venv and installs pip" {
    run mkvirtualenv test-venv
    [ $status -eq 0 ]

    run "$WORKON_HOME"/test-venv/bin/pip --version
    [ $status -eq 0 ]
}

@test "lsvirtualenv lists all installed venvs in alphabetical order" {
    run lsvirtualenv
    [ $status -eq 0 ]

    mkvirtualenv test-a
    mkvirtualenv test-b

    run lsvirtualenv
    [ $status -eq 0 ]
    [ "${lines[0]}" = "test-a" ]
    [ "${lines[1]}" = "test-b" ]
}

@test "cdvirtualenv without activated venv prints an error message" {
    run cdvirtualenv
    [ $status -eq 1 ]
    [ "${lines[0]}" = "No venv activated!" ]
}

@test "cdvirtualenv in activated venv changes to venv directory" {
    mkvirtualenv test-venv
    source "$WORKON_HOME"/test-venv/bin/activate

    run cdvirtualenv
    [ $status -eq 0 ]
}

@test "rmvirtualenv without argument fails" {
    run rmvirtualenv
    [ $status -eq 1 ]
}

@test "rmvirtualenv command with more than one argument fails" {
    run rmvirtualenv a b
    [ $status -eq 1 ]
}

@test "rmvirtualenv command with single argument removes venv if deactivated" {
    mkvirtualenv test-venv
    deactivate

    run rmvirtualenv test-venv
    [ $status -eq 0 ]

    [ ! -d "$WORKON_HOME"/test-venv ]
}

@test "rmvirtualenv command in activated venv fails" {
    mkvirtualenv test-venv

    run rmvirtualenv test-venv
    [ $status -eq 1 ]
    [ "${lines[0]}" = "Cannot remove activated venv!" ]

    [ -d "$WORKON_HOME"/test-venv ]
}

@test "workon command without argument lists available venvs and has non-zero exit code" {
    run workon
    [ "${lines[0]}" = "Specify exactly one venv to work on. Choose from:" ]
    [ $status -eq 1 ]
}
