function shortcutHelp() {
	echo """
	PIDS AND PROCESSES:
	
	Control pw will use fzf to kill processes, multiple u select with tab

	Control pw will use fzf to kill processes but will start by searchign with the word u started typinh

	GREAT Shortcuts for finding a PID and killing processes
	Control p f will get the pid from a fzf ps -ef

	Control p then s will take the current word and kill -9 all processes with that word
	

	LINE EDITING:

	Control r and w or Contrl i and w will search the $RPISHELL/inserts file replacesments for the current word - useful for replacing sometihng like
		clang with a full file path
		Maybe better than zsh-abbr
	"""
}

alias printShortcutHelp=shortcutHelp



function replacecurrentwordBEB() {
    export CURRENTWORD="${LBUFFER/* /}${RBUFFER/ */}"

    zle kill-word
    zle backward-kill-word

  if [ -z "$CURRENTWORD" ]; then
    export REPLACEMENT="$(cat $RPISHELL/inserts | fzf  )"
  else
    export REPLACEMENT="$(cat $RPISHELL/inserts | fzf  -q $CURRENTWORD)"
  fi

    zle -M "Replacing $CURRENTWORD with $REPLACEMENT"

    zle -U "$REPLACEMENT"
}
zle -N replacecurrentwordBEB
bindkey "^rw" replacecurrentwordBEB
bindkey "^iw" replacecurrentwordBEB






# Control p then s will take the current word and kill -9 all processes with that word
function killmultiplebywordSearchBEB() {
  local REPLY
  autoload -Uz read-from-minibuffer
  read-from-minibuffer 'Process name to search for and kill all of: ' $LBUFFER $RBUFFER
  eval sudo kill -9 $(ps -efc | grep "$REPLY" | awk '{print $2}')
}
zle -N killmultiplebywordSearchBEB
bindkey "^ps" killmultiplebywordSearchBEB

# GREAT Shortcuts for finding a PID and killing processes
# Control p f will get the pid from a fzf ps -ef
function getprocessidBEB() {
export PID=$(ps -ef | fzf -m | awk '{print $2}')
echo "$PID" | pbcopy
zle -U "$PID"
}
zle -N getprocessidBEB
bindkey "^pf" getprocessidBEB

# Control pw will use fzf to kill processes but will start by searchign with the word u started typinh
function killProcFZFCurrentWord() {
  # sudo kill -9 $(echo $(ps -efc | fzf) | awk '{print $2}')
  # Now can use tab to select multiple processes:
  export CURRENTWORD="${LBUFFER/* /}${RBUFFER/ */}"

      zle kill-word
    zle backward-kill-word

  sudo kill -9 $(ps -efc | fzf -m -q $CURRENTWORD | awk '{print $2}')
}
zle -N killProcFZFCurrentWord
bindkey "^pw" killProcFZFCurrentWord

# Control pw will use fzf to kill processes, multiple u select with tab
function killprocessusingfzfBEB() {
  export CURRENTWORD="${LBUFFER/* /}${RBUFFER/ */}"

    zle kill-word
    zle backward-kill-word

  if [ -z "$CURRENTWORD" ]; then
    sudo kill -9 $(ps -efc | fzf -m  | awk '{print $2}')
  else
    sudo kill -9 $(ps -efc | fzf -m -q $CURRENTWORD | awk '{print $2}')
  fi
}
zle -N killprocessusingfzfBEB
bindkey "^pp" killprocessusingfzfBEB
bindkey "^po" killprocessusingfzfBEB
alias kp=killprocessusingfzfBEB
