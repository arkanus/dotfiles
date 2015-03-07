

export ZSH_TMUX_AUTOCONNECT=true

export EDITOR=vim

SOCK="/tmp/ssh-agent-$USER-screen"
if test $SSH_AUTH_SOCK && [ $SSH_AUTH_SOCK != $SOCK ]
then
    rm -f /tmp/ssh-agent-$USER-screen
    ln -sf $SSH_AUTH_SOCK $SOCK
    export SSH_AUTH_SOCK=$SOCK
fi


## Aliases  {{{

# Fix key forwarding in stupid screen
alias fixssh="source ~/fixssh"

# List process with pid + command
alias pso="ps -e -opid,cmd"

# Django stuff
alias dj="python manage.py"
alias djr="dj runserver"
alias djrp="dj runserver_plus"
alias djsm="dj schemamigration --auto"
alias djmg="dj migrate"
alias djpyc="dj clean_pyc"
alias epilpsyoff="bind 'set bell-style none'"
alias epilpsyon="bind 'set bell-style visible'"
alias db='`make rinfo | grep "^psql -"`'

alias sake="make -s"

## }}}

if [[ -a $HOME/.zshenv_local ]]
then
	source $HOME/.zshenv_local
fi

# system-wide environment settings for zsh(1)
if [ -x /usr/libexec/path_helper ]; then
	eval `/usr/libexec/path_helper -s`
fi

path=(/opt/local/bin $path /opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin)

export DOCKER_HOST=tcp://boot2docker:2376
export DOCKER_CERT_PATH=/Users/marcos/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1

#required for octave plot commands, otherwise it segfaults
export LIBGL_ALWAYS_INDIRECT=y
