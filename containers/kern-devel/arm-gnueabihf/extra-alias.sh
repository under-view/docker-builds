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
