set -gx CC clang-16
set -gx GOPATH $HOME/go
set -gx WORKSPACE $HOME/workspace
set -gx EDITOR nvim
set -gx GIT_EDITOR nvim
set -gx XDG_CONFIG_HOME $HOME/.config

set -gx BUN_INSTALL "$HOME/.bun"

set -gx NODE_PATH /usr/local/lib/node_modules
