HISTFILE=~/.zsh_history
HISTSIZE=30000
SAVEHIST=30000
setopt appendhistory


function InstallZINIT() { sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)" }

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk
#

zinit wait lucid light-mode for \
  atinit"zicompinit; zicdreplay" \
      zdharma/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
      zsh-users/zsh-completions    

export PROMPT='%(?.%F{magenta}△.%F{red}▲)%f ' 

zinit for \
    light-mode zdharma/zui \
    light-mode zdharma/zbrowse \
    light-mode zdharma/history-search-multi-word \
    light-mode pick"async.zsh" src"pure.zsh" \
                sindresorhus/pure


omz_plugins=(
    debian
    git
)
for plugin in ${omz_plugins[@]}; do
    zinit snippet OMZ::plugins/$plugin/$plugin.plugin.zsh
done




setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks # remove superfluous blanks from history items
setopt inc_append_history # save history entries as soon as they are entered
setopt share_history # share history between different instances of the shell
setopt auto_cd # cd by typing directory name if it's not a command
# setopt correct_all # autocorrect commands
setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match
# Zsh match autocomplete even with typo
zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion

# glob
setopt extended_glob
setopt mark_dirs

# history
setopt extended_history
setopt hist_fcntl_lock
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt share_history


# io
unsetopt clobber
setopt correct
setopt correct_all
setopt ignore_eof

# job
setopt auto_resume
setopt long_list_jobs
setopt notify


alias -g A='awk '
alias -g C='cut '
alias -g G='grep '
alias -g H='head '
alias -g L='less '
alias -g S='sort '
alias -g T='tail '
alias -g U='uniq '
alias -g W='wc '
alias -g X='xargs '
alias -g P='ps -ef '



function lw() { ls -al `which "$1"` }
alias lx='exa -a -a -x' 
alias l='exa -a -a -l' 
alias lk='exa -a -l -r -s time' 
alias lt='exa -a -l -r -s time' 



ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"

# autoload -Uz compinit && compinit 








### BIND Ctrl and Alt/Option  (left and right) to move whole words!
## Control Backspace deletes a whole word
bindkey "\e[1;5C" vi-forward-word
bindkey "\e[1;5D" vi-backward-word
# Control m will match bracket
bindkey '^B' vi-match-bracket
# Control n will create a new line below
bindkey '^n' vi-open-line-below










export RPISHELL=$HOME/rpi-shell

# Little functions I created after reading the Bash Bible which I think are very helpful
source $RPISHELL/super-helpful.zsh
source $RPISHELL/other-helpful.zsh
source $RPISHELL/shortcuts-helpful.zsh   # Remeber to checkout what is avaiable with shortcutHelp or printShortcutHelp

function gsmGetIMEI() { sudo bash -c " echo -e 'ATI\r\n' > /dev/ttyUSB4"  }

function vimzsh() { vim ~/.zshrc }
alias vzsh=vimzsh
function codezsh() { code --disable-extensions  ~/.zshrc  }
alias czsh=codezsh

function reload() { source ~/.zshrc}

function backupDotFiles() {
	cp $HOME/.zshrc $RPISHELL/zshrc
	pushd $RPISHELL
	git add *
	git commit -am "`date`"
	git push origin master
	popd
}
function gsmMinicom(){ sudo minicom -D /dev/ttyUSB4 }
