


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

function gsmGetIMEI() { echo -e “ATI\r\n” > /dev/ttyUSB4  }
function vimzsh() { vim ~/.zshrc }
alias vzsh=vimzsh
function reload() { source ~/.zshrc}
function backupDotFiles() {
	cp $HOME/.zshrc $HOME/rpi-shell/zshrc
	pushd $HOME/rpi-shell
	git add *
	git commit -am "`date`"
	git push origin master
	popd
}
