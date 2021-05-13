#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

reload() {
	. ~/.bash_profile
}

######### Aliases #########
alias ls='ls --color=auto'
alias homegit='GIT_DIR=".homegit" git'
alias vimprofile='vim ~/.bash_profile'

## Tezos Aliases
alias cdt='cd $TEZOS_DIR'
alias cdp='cd $TEZOS_DIR/src/proto_alpha/lib_protocol'
alias turn_off_warnings='export OCAMLPARAM="_,w=-27-26-32-33-20"'

test(){
	watchexec --clear -e ml,mli -w src '(esy dune exec ./src/proto_alpha/lib_protocol/test/main.bc -- test "global table of constants")'
}

#### Setting up shell & env #####
export PATH=$PATH:"~/bin"
PS1='[\u@\h \W]\$ '
eval "$(starship init bash)"
eval "$(direnv hook bash)"
source "$HOME/.cargo/env"
