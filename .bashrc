# ~/.bashrc: executed by bash(1) for non-login shells.

# This file is symlinked to .bash_profile and .profile for
# consistency.

############ Useful defaults inherited from Ubuntu #########

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
##############################################################

############## My Customizations ############################
shopt -s dotglob

# Source Rust stuff
. "$HOME/.cargo/env"

# Uuse patdiff instead of default Git diffing algorithm
# export GIT_EXTERNAL_DIFF="opam exec patdiff-git-wrapper"

# opam configuration
test -r /home/d4hines/.opam/opam-init/init.sh && . /home/d4hines/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

alias homegit='GIT_DIR=.homegit git'
alias reload='source $HOME/.bashrc'
alias vimprofile='vim ~/.bashrc'

eval "$(starship init bash)"
eval "$(direnv hook bash)"

## Tezos stuff
# I define $TEZOS_DIR in a .envrc and load it automatically with direnv
# That's set up in https://github.com/d4hines/dev-tezos
alias cdp='cd $TEZOS_DIR/src/proto_alpha/lib_protocol'
alias cdt='cd $TEZOS_DIR'
alias turn_off_warnings='export OCAMLPARAM="_,w=-27-26-32-33-20"'
alias runtest='dune build --terminal-persistence=clear-on-rebuild  @runtest_proto_alpha --watch'
alias dbw='dune build --terminal-persistence=clear-on-rebuild --watch'

create-mockup () {
	if [[ ! -d /tmp/mockup ]]; then
		tezos-client \
		  --protocol ProtoALphaALphaALphaALphaALphaALphaALphaALphaDdp3zK \
		  --base-dir /tmp/mockup \
		  --mode mockup \
		  create mockup
	fi
} 

alias mockup-client='create-mockup && tezos-client --mode mockup --base-dir /tmp/mockup'

if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then . ~/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
