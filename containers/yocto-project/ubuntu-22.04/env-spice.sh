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

export DL_DIR="${HOME}/downloads"
export SSTATE_DIR="${HOME}/sstate-cache"

# User space memory allocation is allowed to over-commit memory (more than
# available physical memory) which can lead to out of memory errors
# The out of memory (OOM) killer kicks in and selects a process to kill to retrieve some memory.
# Thus why we see the bellow error at random points of the build
#	x86_64-underview-linux-g++: fatal error: Killed signal terminated program cc1plus
# Lowering BBTHREADS and MTHREADS ensures the system doesn't run out of memory when building
core_count=$(nproc)
export PARALLEL_MAKE="-j $((core_count / 2))"
export BB_NUMBER_THREADS=$((core_count / 2))

export BB_ENV_PASSTHROUGH_ADDITIONS="DL_DIR SSTATE_DIR UNDERVIEW_IMAGE_TYPE"
