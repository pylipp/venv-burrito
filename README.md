[![Build Status](https://travis-ci.org/pylipp/venv-burrito.svg?branch=master)](https://travis-ci.org/pylipp/venv-burrito)

## `venv-burrito`

Minimalistic set of convenience functions for managing Python virtual environments using the `venv` module. Inspired by `virtualenvwrapper`

### Usage

Download the `functions.bash` script and source it in your shell.

The following functions are now available:

- `mkvirtualenv VENV-NAME`
- `workon VENV-NAME`
- `lsvirtualenv`
- `cdvirtualenv`
- `rmvirtualenv VENV-NAME`

Their behavior is almost equivalent to the behavior of the eponymous `virtualenvwrapper` functions.

### Testing

Running the tests requires [`bats`](https://github.com/bats-core/bats-core#load-share-common-code) to be installed.

From the repository root, execute

    bats test/functions.bats

### Why not `virtualenvwrapper`?

It's an excellent collection of scripts. However it wraps `virtualenv` which - when creating virtual environments - copies the system Python binary to the virtual environment, leading to drawbacks discussed [here](https://stackoverflow.com/a/47559925). Using the built-in `venv` module is more robust.

Additionally, I'm only using five of the many functions provided by `virtualenvwrapper`.
