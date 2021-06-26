set PATH $PATH ~/.cargo/bin
set PATH $PATH /snap/bin

set fish_greeting

starship init fish | source
# ghcup-env
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
test -f /home/uhhh/.ghcup/env ; and set -gx PATH $HOME/.cabal/bin /home/uhhh/.ghcup/bin $PATH
