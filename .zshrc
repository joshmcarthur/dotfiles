# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="sudojosh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

alias gs="git status -sb"
json() { cat "$*" | python -mjson.tool }
jump() { cd "$HOME/Sites/$*" }

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git rvm github rails3 rails ruby)

source $ZSH/oh-my-zsh.sh
alias gst="git status -sb"

# Customize to your needs...
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin:/usr/X11/bin

[[ -s "/Users/josh/.rvm/scripts/rvm" ]] && source "/Users/josh/.rvm/scripts/rvm"  # This loads RVM into a shell session.

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting


