# ~/.bashrc: executed by bash(1) for non-login shells.

############ Swap keys regardless of anything else #########
command -v setxkbmap >/dev/null 2>&1 && setxkbmap -option caps:swapescape
############ Useful defaults inherited from Ubuntu #########

########### Aliases ##############

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias homegit='GIT_DIR=.homegit git'
alias reload='source $HOME/.bashrc'
alias vimprofile='vim ~/.bashrc'
alias watchexec="watchexec --shell='bash --login -O expand_aliases'"
####### Tezos stuff

alias cdp='cd $TEZOS_DIR/src/proto_alpha/lib_protocol'
alias cdt='cd $TEZOS_DIR'
alias cdu='cd $TEZOS_DIR/src/proto_alpha/lib_protocol/test/unit'
alias turn_off_warnings='export OCAMLPARAM="_,w=-27-26-32-33-20-21"'
alias runtest='dune build --terminal-persistence=clear-on-rebuild  @runtest_proto_alpha --watch'
alias test_globals='(cdu && dune build @runtest --force ) && dune exec ./src/proto_alpha/lib_protocol/test/main.exe -- test "global table of constants" -c && tezt global_constant'
alias dbw='dune build --terminal-persistence=clear-on-rebuild --watch'

create_mockup () {
	if [[ ! -d /tmp/mockup ]]; then
		tezos-client \
		  --protocol ProtoALphaALphaALphaALphaALphaALphaALphaALphaDdp3zK \
		  --base-dir /tmp/mockup \
		  --mode mockup \
		  create mockup
	fi
} 

alias destroy_mockup='rm -rf /tmp/mockup'

alias mockup_client='create_mockup && tezos-client --mode mockup --base-dir /tmp/mockup'

alias client='mockup_client'

# alias w='(cdt && watchexec -c -e ml,mli -w src)'
alias w='watchexec -c -e ml,mli -w src'

alias tezt='dune exec tezt/tests/main.exe --'
#################################
shopt -s dotglob

# Source Rust stuff
. "$HOME/.cargo/env"

# Uuse patdiff instead of default Git diffing algorithm
# export GIT_EXTERNAL_DIFF="opam exec patdiff-git-wrapper"

# opam configuration
test -r /home/d4hines/.opam/opam-init/init.sh && . /home/d4hines/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true


eval "$(starship init bash)"
eval "$(direnv hook bash)"


if [ -e /home/d4hines/.nix-profile/etc/profile.d/nix.sh ]; then . /home/d4hines/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
################################################

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

############### Begin Interactive Stufff ###############

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
