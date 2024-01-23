#!/bin/fish

# Sourcing my infosec stuff configs
source /home/flame/.config/fish/cyber.fish

# Environment
set fish_greeting
#pokemon-colorscripts -r --no-title
set -x PATH /home/flame/Android/Sdk/platform-tools/ /home/flame/.local/share/gem/ruby/3.0.0/bin /home/flame/.cargo/bin/ /home/flame/.local/bin/ /home/flame/go/bin /home/flame/scripts $PATH

# ──────── 《 Abbreviations 》 ────────
abbr ifc ifconfig
abbr cl clear
abbr nv nvim

# ─────────── 《 Aliases 》 ───────────
# General
alias rl='readlink -f'
alias r='ranger'
alias nv='nvim'
alias eq='nvim .'
alias cls='clear ; cd'
alias logoff='killall -u $USER'
alias dog='/usr/bin/cat'
alias rf='rm -rf'
alias surfd='/usr/bin/surf duckduckgo.com'
alias surfg='/usr/bin/surf google.com'
alias xcc='xclip -selection clipboard -o'
alias clip='xsel -i -b'
alias b64='base64'
alias bd='base64 -d'
alias pping='/usr/bin/ping'
alias md='mkdir'
alias chx='chmod +x'
alias hosts='sudo $EDITOR /etc/hosts'
alias tx='tmuxinator'
alias t='tmux'
alias bbs='feh --bg-fill ~/Pictures/wallpapers/dark/anime05.jpg --bg-fill ~/Pictures/wallpapers/justblack.jpg'
alias wttr='curl wttr.in'
alias hextod='printf "%d\n"'
alias rmexif='exiftool -all='
alias cfg='cd ~/.config/'
alias diff='difft'

# Git
alias gist='gh gist create'
alias gistp='gh gist create --public'
alias lg='lazygit'
alias gcl='git clone'

# Better output
alias du='dust'
alias ip='ip -color=auto'
alias dmesg='dmesg --color=always'
alias ping='prettyping'
alias cat='bat --plain --decorations never --paging never'
alias catp='bat --paging always'
alias df='duf -hide-fs squashfs'
alias free='free -h'

# Shells
alias b='bash'
alias f='fish'

# Virtual box 
alias vm='VBoxManage'
alias vmlv='VBoxManage list vms'
alias vmlrv='VBoxManage list runningvms'
alias vmoff='VBoxManage controlvm $1 acpipowerbutton'
alias vmforceoff='VBoxManage controlvm $1 poweroff'
alias vmstart='VBoxManage startvm $1 --type separate'
alias vmstarth='VBoxManage startvm $1 --type headless'

# Changing keyboard layout
alias setbr='setxkbmap -layout br'
alias setus='setxkbmap -layout us'

# Fast edit/read configs
alias fconf='catp ~/.config/fish/config.fish ~/.config/fish/cyber.fish'
alias efconf='nvim ~/.config/fish/config.fish'

# Grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias gp='grep'
alias hg='history | grep $1'

# Networking tools
alias ifme='curl ifconfig.me'
alias ssp='ss -tupan | grep $1'
alias nethogs='sudo nethogs'
alias iftop='sudo iftop'
alias mm='mitmproxy'

# Visual configs
alias panes='/opt/shell-color-scripts/colorscripts/panes'
alias fehbgr='feh --bg-fill $(shuf -n 1 -e ~/Pictures/wallpapers/dark/*) --bg-fill ~/Pictures/wallpapers/justblack.jpg'
alias frenzch='~/frenzch.sh/frenzch.sh'
alias clock='tty-clock -c -C4'

# "ls" to "eza"
alias sl='ls'
alias ls='eza --icons --color=always --group-directories-first' 
alias l='eza --icons --color=always --group-directories-first' 
alias la='eza --icons -laF --octal-permissions --color=always --group-directories-first'
alias ll='eza --icons -lF --octal-permissions --color=always --group-directories-first'
alias lsize='/usr/bin/du -hs * | sort -hr | less'

# Package managers
alias pacs='sudo pacman -S'
alias pacr='sudo pacman -R'
alias pacss='pacman -Ss'
alias pacsyu='sudo pacman -Syu'
alias pacsyyu='sudo pacman -Syyu'
alias ys='yay -S'
alias y='yay'
alias yr='yay -R'
alias yaysua='yay -Sua --noconfirm'
alias yaysyu='yay -Syu --noconfirm'
alias parsua='paru -Sua --noconfirm'
alias parsyu='paru -Syu --noconfirm'
alias pt='pactree'
alias ptc='pactree -c'
alias ptr='pactree -rc'
alias ptu='pactree -u'

# Processes
alias psa='ps auxf'
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'

# Systemd
alias std='sudo systemctl start'
alias rrd='sudo systemctl restart'
alias stopd='sudo systemctl stop'
alias stts='systemctl status'
alias isfd='systemctl is-failed'

# Logging
alias lastjctl='journalctl -p 3 -xb'

# ────────── 《 Functions 》 ──────────
function fehbg
  set chs $argv[1]
  feh --bg-fill $chs --bg-fill ~/Pictures/wallpapers/justblack.jpg
end

function echovar --no-scope-shadowing # Print variable (case-insensitive)
    if set -q -- $argv
        set varname $argv
    else
        set varname (echo $argv | string upper)
    end
    eval 'echo $'$varname
end

function aliasf # Search for aliases in fish config
  alias | grep "alias $argv[1]"
end

function mvl # Move last downloaded file to current directory
    set destination $argv[1]
    mv ~/Downloads/(/bin/ls -t -A ~/Downloads/ | head -1) $destination
end

function svl # Show last file downloaded
    /bin/ls -t -A ~/Downloads | head -n1
end

function row --argument index # Print n line
    sed -n "$index p"
end

function skip-lines --argument n # Skip n lines in file
    tail +(math 1 + $n)
end

function bak --argument filename # Backup a file
  cp $filename $filename.bak
end

function jctl # Application logs
    journalctl -qb /usr/bin/$1
end

function cpr # Copy with progress
  rsync -WavP --human-readable --progress $1 $2
end

function mdc # Create and enter into directory
    mkdir $argv[1]
    cd $argv[1]
end

function geo # Geolocation of an IP address
    curl https://ipinfo.io/$argv[1] -s | jq
end

function mygeo # My geolocation
    geo $(curl https://ifconfig.me -s)
end

function gitsize # Calculate size of a Github repository
  echo $argv[1]  | perl -ne 'print $1 if m!([^/]+/[^/]+?)(?:\.git)?$!' | xargs -I{} curl -s -k https://api.github.com/repos/'{}' | jq '.size' | numfmt --to=iec --from-unit=1024
end

function bp # Upload file to bashupload.com and return download url
  curl bashupload.com -T $argv[1] -s | awk '/wget/ {print $2}' 
end

fish_add_path /home/flame/.spicetify
pyenv init - | source