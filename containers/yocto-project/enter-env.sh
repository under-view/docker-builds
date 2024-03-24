# enable programmable completion features (you don’t need to enable
# this, if it’s already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

set_bash_prompt() {
	fs_mode=$(mount | sed -n -e "s/^\/dev\/.* on \/ .*(\(r[w|o]\).*/\1/p")
	PS1='\[\e[91;1m\]\u@\h ${fs_mode:+($fs_mode)}\[\033[00m\]: \[\e[33;1m\]\W \[\e[32;1m\]\$ \[\033[0m\]'
}

PROMPT_COMMAND=set_bash_prompt

NORMAL=`echo -e '\x1b[0m'`
RED=`echo -e '\x1B[31;1m'`
LGREEN=`echo -e '\033[1;32m'`
IBLUE=`echo -e '\x1B[30;1m'`
LBLUE=`echo -e '\033[1;34m'`
YELLOW=`echo -e '\x1B[33;1m'`
MAGENTA=`echo -e '\e[37;1m'`
IP_CMD=$(which ifconfig)

colored_ip() {
	${IP_CMD} $@ | sed \
		-e "s/inet [^ ]\+ /${LGREEN}&${NORMAL}/g"\
		-e "s/ether [^ ]\+ /${RED}&${NORMAL}/g"\
		-e "s/netmask [^ ]\+ /${LBLUE}&${NORMAL}/g"\
		-e "s/broadcast [^ ]\+ /${IBLUE}&${NORMAL}/g"\
		-e "s/^default via .*$/${YELLOW}&${NORMAL}/g"\
		-e "s/^\([0-9]\+: \+\)\([^ \t]\+\)/\1${MAGENTA}\2${NORMAL}/g"
}

alias ifconfig='colored_ip'

alias vi='vim'

alias ls='ls --color'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

export DL_DIR="/home/${USER}/downloads"
export SSTATE_DIR="/home/${USER}/sstate"
export BUILD_OUTPUT_DIR="/home/${USER}/build-output"
export BB_ENV_PASSTHROUGH_ADDITIONS="DL_DIR SSTATE_DIR"

source /home/${USER}/poky/oe-init-build-env ${BUILD_OUTPUT_DIR}
