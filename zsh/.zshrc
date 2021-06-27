# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# plugins start
#if test -f /usr/share/powerlevel9k/powerlevel9k.zsh-theme
#then	
#	source /usr/share/powerlevel9k/powerlevel9k.zsh-theme
#fi
#
if test -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh 
then
	source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
	ZSH_AUTOSUGGEST_STRATEGY=(history completion)
fi

if test -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
then
	source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if test -f /usr/share/zsh-history-substring-search/zsh-history-substring-search.zsh
then
	source /usr/share/zsh-history-substring-search/zsh-history-substring-search.zsh
fi
# plugins end

# completion start
autoload -U compinit && compinit -u
# dir history config
setopt AUTO_PUSHD                  # pushes the old directory onto the stack
setopt PUSHD_MINUS                 # exchange the meanings of '+' and '-'
setopt CDABLE_VARS                 # expand the expression (allows 'cd -2/tmp')
zstyle ':completion:*:directory-stack' list-colors '=(#b) #([0-9]#)*( *)==95=38;5;12'
zstyle ':completion:*' menu select
# Auto complete with case insenstivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# completion end

# bindkey start
bindkey -v
if [[ -n "$IS_WSL" || -n "$WSL_DISTRO_NAME" ]]; then
	bindkey '^[OA' history-substring-search-up
	bindkey '^[OB' history-substring-search-down
else
	bindkey '^[[A' history-substring-search-up
	bindkey '^[[B' history-substring-search-down
fi
# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'left' vi-backward-char
bindkey -M menuselect 'down' vi-down-line-or-history
bindkey -M menuselect 'up' vi-up-line-or-history
bindkey -M menuselect 'right' vi-forward-char
bindkey \^K kill-line
# bindkey end

# source configs start
for f in ~/.config/shellconfig/*; do source "$f"; done
# source configs end

# spaceship prompt config start
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_PROMPT_SEPARATE_LINE=false
SPACESHIP_CHAR_SYMBOL=❯
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_HG_SHOW=false
SPACESHIP_PACKAGE_SHOW=false
SPACESHIP_NODE_SHOW=false
SPACESHIP_RUBY_SHOW=false
SPACESHIP_ELM_SHOW=false
SPACESHIP_ELIXIR_SHOW=false
SPACESHIP_XCODE_SHOW_LOCAL=false
SPACESHIP_SWIFT_SHOW_LOCAL=false
SPACESHIP_GOLANG_SHOW=false
SPACESHIP_PHP_SHOW=false
SPACESHIP_RUST_SHOW=false
SPACESHIP_JULIA_SHOW=false
SPACESHIP_DOCKER_SHOW=false
SPACESHIP_DOCKER_CONTEXT_SHOW=false
SPACESHIP_AWS_SHOW=false
SPACESHIP_CONDA_SHOW=false
SPACESHIP_VENV_SHOW=false
SPACESHIP_PYENV_SHOW=false
SPACESHIP_DOTNET_SHOW=false
SPACESHIP_EMBER_SHOW=false
SPACESHIP_KUBECONTEXT_SHOW=false
SPACESHIP_TERRAFORM_SHOW=false
SPACESHIP_TERRAFORM_SHOW=false
SPACESHIP_VI_MODE_SHOW=false
SPACESHIP_JOBS_SHOW=false

autoload -U promptinit; promptinit
prompt spaceship
# spaceship prompt config end 

# vpn config start	
if [[ -n "$IS_WSL" || -n "$WSL_DISTRO_NAME" ]]; then
	export windows_host=`cat /etc/resolv.conf|grep nameserver|awk '{print $2}'`
	export ALL_PROXY=socks5://$windows_host:1080
	export HTTP_PROXY=$ALL_PROXY
	export http_proxy=$ALL_PROXY
	export HTTPS_PROXY=$ALL_PROXY
	export https_proxy=$ALL_PROXY

	if [ "`git config --global --get proxy.https`" != "socks5://$windows_host:10808" ]; then
		    git config --global proxy.https socks5://$windows_host:10808
	fi
fi
# vpn config end
