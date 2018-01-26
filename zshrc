HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

setopt interactivecomments

bindkey ";5C" forward-word
bindkey ";5D" backward-word
bindkey '\e[H' beginning-of-line
bindkey ";5H" beginning-of-line
bindkey '\e[F' end-of-line
bindkey ";5F" end-of-line
bindkey "\e[3~" delete-char

echo 1/4: Loading zstyle, compinit...

zstyle :compinstall filename '/home/gatgeagent/.zshrc'

autoload -Uz compinit && compinit
#if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]; then
#  compinit
#else
#  compinit -C
#fi

echo 2/4: Initializing dependencies with zplug...

if [[ ! -d ~/.zplug ]];then
    git clone https://github.com/b4b4r07/zplug ~/.zplug
fi

source ~/.zplug/init.zsh

zplug "mafredri/zsh-async", from:github
zplug "lib/completion", from:oh-my-zsh
zplug "themes/agnoster", use:agnoster.zsh, from:oh-my-zsh, as:theme
zplug "zsh-users/zsh-syntax-highlighting", from:github, defer:3
zplug "MichaelAquilina/zsh-you-should-use"
#zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

echo 3/4: Loading zplug dependencies...

zplug load

if ! zplug check --verbose; then
    printf "Install zplug plugins? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

echo 4/4: Setting aliases...

#
# Aliases
#

#
# Files

alias -- -='cd -'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'
alias ..6='cd ../../../../../..'

alias chgrp='chgrp --preserve-root'
alias chmod='chmod --preserve-root'
alias chown='chown --preserve-root'

alias cp='cp -i'
alias df='df -h'

alias trash='sudo fstrim -v /'

alias md='mkdir -p'
alias mkdirs='mkdir -pv'
alias rd='rmdir'

alias tree='find . -print | sed -e '\''s;[^/]*/;|____;g;s;____|; |;g'\'''

# List

alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ll='ls -lh --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ls='ls --color=auto -h'
alias l='ls -ah'

#
# Package management
#

alias fixit='sudo rm -f /var/lib/pacman/db.lck'
alias update='yaourt -Syua'
alias mirrors='sudo pacman-mirrors -g'


#
# Grep
#

alias grep='grep --color=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'


#
# Development
#

#
# Maven

alias mc='mvn validate initialize generate-sources process-sources generate-resources process-resources compile process-classes prepare-package package'
alias mcl='mvn pre-clean clean post-clean'
alias mvnf='mvn validate initialize pre-clean clean post-clean generate-sources process-sources generate-resources process-resources compile process-classes generate-test-sources process-test-sources generate-test-resources process-test-resources test-compile process-test-classes test prepare-package package pre-integration-test integration-test post-integration-test verify install'
alias mvnfull='mvn validate initialize pre-clean clean post-clean generate-sources process-sources generate-resources process-resources compile process-classes generate-test-sources process-test-sources generate-test-resources process-test-resources test-compile process-test-classes test prepare-package package pre-integration-test integration-test post-integration-test verify install pre-site site post-site'
alias mvntest='mvn validate initialize generate-test-sources process-test-sources generate-test-resources process-test-resources test-compile process-test-classes test pre-integration-test integration-test post-integration-test verify'

#
# Interpreters

alias py='python'
alias rb='ruby'
alias ipy='ipython'

#
# Misc
#

alias printer='system-config-printer'
#alias comp='nano $HOME/.config/compton.conf'
alias con='nano $HOME/.config/i3/config'
alias idea='/usr/bin/intellij-idea-ultimate-edition'
alias c='clear'
alias genpw='pwgen -c -n -y 48 1'
alias genpws='pwgen -c -n 48 1'
alias vtop='vtop -t monokai'

alias _='sudo'

alias cls='clear'

alias edit='/usr/bin/nano'

alias free='free -m'

alias h='history'

alias irc='irssi'

alias pager='/usr/bin/most'

alias q='exit'


alias reload='source ~/.zshrc'
alias shit='bash-it'
alias sl='ls'
alias snano='sudo nano'
alias sprinter='sudo system-config-printer'
alias svim='sudo vim'

if [ $UID -ne 0 ]; then
         alias reboot='sudo reboot'
fi

#
# # ex - archive extractor
# # usage: ex <file>
ex () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.jar)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
   fi
}

transfer () {
    # write to output to tmpfile because of progress bar
    tmpfile=$( mktemp -t transferXXX )
    curl --progress-bar --upload-file $1 https://transfer.sh/$(basename $1) >> $tmpfile;
    cat $tmpfile;
    rm -f $tmpfile;
}

#alias transfer=transfer

export EDITOR=/usr/bin/nano
export BROWSER=/usr/bin/firefox
export PAGER=/usr/bin/most
export LANG=de_DE.utf8
export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"
export SCRIPT_DIR=/home/gatgeagent/scripts

echo Initialization completed.
