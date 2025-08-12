#!/bin/bash

isWSL=false
if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
    isWSL=true
    echo "WSL"
fi


# uvによるPython仮想環境セットアップ
if ! command -v uv &> /dev/null; then
    echo "uvが見つかりません。インストールします。"
    # uv公式バイナリをダウンロードしてインストール
    curl -Ls https://astral.sh/uv/install.sh | bash
    export PATH="$HOME/.cargo/bin:$PATH"
fi

# プロジェクト用仮想環境作成例（.venv）
if [ ! -d "$HOME/.venv" ]; then
    uv venv $HOME/.venv
fi

## generate backup directory
mkdir -p ~/.back

if false; then
    cat << 'EOS' > ~/.bashrc
#!/bin/bash

## sudo補完
complete -cf sudo

## env switch
isWSL=false
if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
    isWSL=true
fi

isDocker=false
if [ -f /.dockerenv ]; then
    isDocker=true
fi

## for fcitx-mozc
export GTK_IM_MODULE=fcitx5
export QT_IM_MODULE=fcitx5
export XMODIFIERS=@im=fcitx5
export DefaultIMModule=fcitx5

if [ $isWSL = true ]; then
    if [ $SHLVL = 1 ] ; then
        (fcitx-autostart > /dev/null 2>&1 &)
        xset -r 49  > /dev/null 2>&1
    fi
fi

## default
export LD_LIBRARY_PATH="";
export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH="/usr/lib:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH="${HOME}/tools/libs:$LD_LIBRARY_PATH"

## SystemC
export LD_LIBRARY_PATH="/usr/local/systemc-2.3.3/lib-linux64:$LD_LIBRARY_PATH"
export SYSTEMC_HOME="/usr/local/systemc-2.3.3"
export SYSTEMC_INCLUDE="/usr/local/systemc-2.3.3/include"
export SYSTEMC_LIBDIR="/usr/local/systemc-2.3.3/lib-linux64"

## not make core
#ulimit -c 0
ulimit -s unlimited

## EOF(Ctrl-D)
IGNOREEOF=10

## history size
HISTSIZE=50000
HISTFILESIZE=500000

#history file append
shopt -s histappend

## License Server
export LM_LICENSE_FILE="/opt/license/questa_license_202211.dat"
export ARMLMD_LICENSE_FILE=""
export XILINXD_LICENSE_FILE=""

## modelsim path
export MTI_HOME="/opt/intel/21.3/questa_fse"
export MODEL_TECH="${MTI_HOME}/bin"
export PATH="${MODEL_TECH}:$PATH"

## NC path
export CADENCE_ROOT="XLM2018.09.010"
export CDS_INST_DIR="/opt/cadence/${CADENCE_ROOT}"
export CDS_ROOT="/opt/cadence/${CADENCE_ROOT}"
export CDS_LICENSE_FILE=""
export LD_LIBRARY_PATH="$CDS_INST_DIR/tools/lib:$LD_LIBRARY_PATH"
export PATH="${CDS_INST_DIR}/tools/bin:$PATH"
export CDS_AUTO_64BIT=ALL
export MDV_XLM_HOME=$CDS_ROOT
export PATH="/opt/cadence/VMGR2018.09.004/tools/bin:$PATH"

## VCS path
export VCS_ROOT="/opt/synopsys/vcs/O-2018.09-SP2-9"
export VCS_HOME="/opt/synopsys/vcs/O-2018.09-SP2-9"
export PATH="${VCS_HOME}/bin:$PATH"
export VCS_TARGET_ARCH="linux64"

## Xilinx ISE env
export XIL_PLACE_ALLOW_LOCAL_BUFG_ROUTING=1
export XIL_PAR_ENABLE_LEGALIZER=1

## Quartus env
export QUARTUS_ROOTDIR="/opt/intel/17.1lite/quartus"
export QSYS_ROOTDIR="/opt/intel/17.1/qsys/bin"
export PATH="$QUARTUS_ROOTDIR/bin:$PATH"
export PATH="$QUARTUS_ROOTDIR/../nios2eds/bin:$PATH"
export CURLOPT_NOSIGNAL=1

## Language UTF-8
export LANG=ja_JP.UTF-8
#export LC_ALL=ja_JP.UTF-8

## Some neat aliases
alias d='dirs'
alias h='history'
alias j='jobs'
alias ls='ls --show-control-chars --color=auto -F --block-size=K'
alias l='ls -C'
alias la='ls -a'
alias ll='ls -laF'
alias lt='ls -ltaF'
alias ltr='ls -ltraF'
alias lss='ls -lSa'
alias lsr='ls -lSra'
alias c='clear'
alias cp='cp -ap'
alias vi=vim
alias less='less -isr'

__get_branch() {
	git branch 2> /dev/null | grep \* | sed -e 's/\* //'
}

## Editor
export EDITOR="emacsclient -a emacs"
export GIT_EDITOR="emacsclient -a emacs"

## Personal
export FULLNAME="A.Matsukura"
export MAILADDRESS="matsukura@"
export COMPANY="None"

#### prompt ####
if [ $isDocker = true ]; then
    export PS1="[\u@Docker] \[\e[0;36m\]\w\[\e[00m\] \[\e[0;35m\][\$(__get_branch)]\[\e[00m\] (\#) \n$ "
else
    export PS1="[\u@\h] \[\e[0;31m\]\w\[\e[00m\] \[\e[0;35m\][\$(__get_branch)]\[\e[00m\] (\#) \n$ "
fi

## pyenv
#alias pyinit='\
#eval "$(pyenv init -)"; \
#eval "$(pyenv virtualenv-init -)"'
#export PYENV_ROOT="$HOME/.pyenv"
#export PATH="$PYENV_ROOT/bin:$PATH"

#export PATH="$PYENV_ROOT/shims:$PATH"
#export PYENV_ROOT="$HOME/.pyenv"
#export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init --path)"
#eval "$(pyenv init -)"

## Golang
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin

## caps -> ctrl
if [ $isWSL != true ]; then
    if [ $isDocker != true ]; then
        setxkbmap -option ctrl:nocaps
    fi
fi

## Perl cpan local
export PERL_CPANM_OPT="--local-lib=~/perl5"
export PATH=$HOME/perl5/bin:$PATH;
export PERL5LIB=$HOME/perl5/lib/perl5:$PERL5LIB;

## python uv
export PATH="$HOME/.cargo/bin:$PATH"
# .venvを有効化するためのエイリアス追加
alias activate_venv="source $HOME/.venv/bin/activate"

## my app
export PATH="${HOME}/tools/bin:${HOME}/tools/script:$PATH"

## Mouse set
alias mouse_default="xmodmap -e 'pointer = 1 2 3 4 5 6 7 8 9 10'"

## Virtualbox alias
alias startwin="VBoxManage startvm win10 --type headless"
alias stopwin="VBoxManage controlvm win10 poweroff"

## dispoff
alias dispoff="sleep 1 && xset dpms force off"

## Vimdiff
alias vimdiff="vimdiff -c 'set diffopt+=iwhite'"

setxkbmap -layout jp

EOS
fi


## home directory rename
#LANG=C xdg-user-dirs-update
LANGUAGE=C LC_MESSAGES=C xdg-user-dirs-gtk-update
