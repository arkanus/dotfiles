export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export ZSH_TMUX_AUTOCONNECT=true

export EDITOR=vim

VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3

SOCK="/tmp/ssh-agent-$USER-screen"
if test $SSH_AUTH_SOCK && [ $SSH_AUTH_SOCK != $SOCK ]
then
    rm -f /tmp/ssh-agent-$USER-screen
    ln -sf $SSH_AUTH_SOCK $SOCK
    export SSH_AUTH_SOCK=$SOCK
fi

path+=(/usr/local/bin)

if [[ -d $HOME/go/bin ]]; then
	path+=($HOME/go/bin)
fi

## Aliases  {{{

# Fix key forwarding in stupid screen
alias fixssh="source ~/fixssh"

# Docker Compose
alias dkr='docker'
alias dcp="docker-compose"
alias dcpup="docker-compose up -d && docker-compose logs"

alias docker-rmi="docker rmi \$(docker images|grep '^<none>'|awk '{print\$3}')"
alias docker-rm="docker rm -v \$( docker ps -q --filter status=exited )"
alias docker-rmall="docker-rm; docker-rmi"

alias gn="git number"
alias sake="make -s"

# Ctags for python
alias ctags-python="ctags -R --fields=+l --languages=python --python-kinds=-iv"

## SSH without adding to known hosts or checks
alias ssh-nohost="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"

alias kcl=kubectl
alias kns=kubens
alias ktx=kubectx

alias watch='watch '
## }}}

if [[ -a $HOME/.zshenv_local ]]
then
	source $HOME/.zshenv_local
fi

# system-wide environment settings for zsh(1)
if [ -x /usr/libexec/path_helper ]; then
	eval `/usr/libexec/path_helper -s`
fi

#required for octave plot commands, otherwise it segfaults
export LIBGL_ALWAYS_INDIRECT=y

#Golang root
export GOPATH=$HOME/go
if [[ -d $GOPATH/bin ]]; then
	path+=($GOPATH/bin)
fi

#NVM stuff
if [ -x /usr/local/opt/nvm/nvm.sh ]; then
	export NVM_DIR="$HOME/.nvm"
	. "/usr/local/opt/nvm/nvm.sh"
fi
