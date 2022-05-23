#!/usr/bin/env sh

## Dotfiles and templates
command mkdir -p "${HOME-}"'/Dropbox/dotfiles' &&
  export DOTFILES="${DOTFILES:="${HOME-}"/Dropbox/dotfiles}" &&
  command mkdir -p "${TEMPLATE:="${DOTFILES-}"/../Template}" &&
  export TEMPLATE="${TEMPLATE:="${DOTFILES-}"/../Template}" &&
  command mkdir -p "${DEFAULT:="${TEMPLATE-}"/../Default}" &&
  export DEFAULT="${DEFAULT:="${TEMPLATE-}"/../Default}"

## XDG
# https://specifications.freedesktop.org/basedir-spec/0.7/ar01s03.html
export XDG_DATA_HOME="${XDG_DATA_HOME:="${HOME-}"/.local/share}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:="${HOME-}"/.config}"

export XDG_STATE_HOME="${XDG_STATE_HOME:="${HOME-}"/.local/state}"

# `XDG_DATA_DIRS` does have trailing slashes
# https://web.archive.org/web/0id_/lists.freedesktop.org/archives/xdg/2019-June/014157.html
export XDG_DATA_DIRS="${XDG_DATA_DIRS:=/usr/local/share/:/usr/share/}"

export XDG_CONFIG_DIRS="${XDG_CONFIG_DIRS:=/etc/xdg}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:="${HOME-}"/.cache}"

# `XDG_RUNTIME_DIR` has no default and requires `700` permissions
command mkdir -p "${TMPDIR:-/tmp}"'/xdg_runtime_dir-'"${USER-}" &&
  command chmod 700 "${TMPDIR:-/tmp}"'/xdg_runtime_dir-'"${USER-}" &&
  export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:="${TMPDIR:-/tmp}"/xdg_runtime_dir-"${USER-}"}"

## Go
# https://github.com/golang/go/wiki/SettingGOPATH/450fad957455a745f8d97ad4cb79376cd689810a
# command go env -w GOPATH="${HOME-}"'/.go' ||
export GOPATH="${GOPATH:="${HOME-}"/.go}"

## iCloud
test -d "${HOME-}"'/Library/Mobile Documents' &&
  export ICLOUD="${ICLOUD:="${HOME-}"/Library/Mobile Documents}"

## Internal Field Separators
# https://unix.stackexchange.com/a/220658
# https://opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.html#tag_02_05_03
IFS="$(printf ' \t\n|')"
export IFS="${IFS%'|'}"

## Locale
export LC_ALL="${LC_ALL:=en_US.UTF-8}"
export TZ="${TZ:=America/New_York}"

## macOS
# allow `control` + `command` + `click and drag` a window from any location
# https://github.com/mathiasbynens/dotfiles/issues/828#issue-296489157
command defaults write NSGlobalDomain NSWindowShouldDragOnGesture -bool true >/dev/null 2>&1

## PAGER
export PAGER="${PAGER:-"command less --ignore-case"}"
export MANPAGER="${MANPAGER:-"${PAGER-}"}"

## POSIX
# activated when set to any value (even empty)
# https://gnu.org/s/autoconf/manual/autoconf#index-POSIXLY_005fCORRECT
unset -- POSIXLY_CORRECT 2>/dev/null

## Rust
# https://github.com/mkrasnitski/git-power-rs/tree/2fc2906#installing
export CARGO_HOME="${CARGO_HOME:="${HOME-}"/.cargo}"

## private
test -r "${HOME-}"'/.env' &&
  . "${HOME-}"'/.env'
