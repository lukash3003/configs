export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="bira"
plugins=(git fzf)

source $ZSH/oh-my-zsh.sh

vi() {
  command nvim "$@"
  echo '\e[5 q'
}

printf '\e[5 q'
alias l='ls -l'
alias ll='ls -la'
alias nvimdiff='nvim -d'
if [ -f /opt/Xilinx/Vivado/2022.2/.settings64-Vivado.sh ]; then
    source /opt/Xilinx/Vivado/2022.2/.settings64-Vivado.sh
fi
export PATH=$PATH:/home/lhoffleit/.local/bin
export JAVA_HOME="/usr/lib/jvm/java-17-openjdk"
export PATH="$PATH:$JAVA_HOME/bin"


eval "$(zoxide init bash --cmd cd)"
LANGUAGE=en_US

eval "$(zoxide init zsh --cmd cd)"
if [[ $TMUX = "" ]];  then
    tmux
fi
