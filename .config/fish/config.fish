#!/bin/fish

# Sourcing my infosec stuff configs
source /home/flame/.config/fish/cyber.fish

# Environment
set fish_greeting
#pokemon-colorscripts -r --no-title
set -x PATH /home/flame/.local/share/gem/ruby/3.0.0/bin /home/flame/.cargo/bin /home/flame/.local/bin/ /home/flame/go/bin $PATH

# ──────── 《 Abbreviations 》 ────────
abbr ifc ifconfig
abbr cl clear
abbr nv nvim

# ─────────── 《 Aliases 》 ───────────
# General
alias rl='readlink -f'
alias nv='nvim'
alias eq='nvim .'
alias cls='clear ; cd'
alias logoff='sh /usr/bin/logoff.sh'
alias dog='/usr/bin/cat'
alias rf='rm -rf'
alias surfd='/usr/bin/surf duckduckgo.com'
alias surfg='/usr/bin/surf google.com'
alias hist='history'
alias xcc='xclip -selection clipboard -o'
alias clip='xsel -i -b'
alias b64='base64'
alias bd='base64 -d'
alias fuck='sudo'
alias pping='/usr/bin/ping'
alias note='dnote'
alias md='mkdir'
alias chx='chmod +x'
alias hosts='sudo $EDITOR /etc/hosts'
alias du='dust'
alias tx='tmuxinator'
alias t='tmux'
alias bbs='feh --bg-fill /home/flame/Pictures/wallpapers/dark/anime05.jpg --bg-fill /home/flame/Pictures/wallpapers/justblack.jpg'

function fehbg
  set chs $argv[1]
  feh --bg-fill $chs --bg-fill /home/flame/Pictures/wallpapers/justblack.jpg
end


# Git
alias gist='gh gist create'
alias gistp='gh gist create --public'
alias lg='lazygit'

# Prettier output
alias ip='ip -color=auto'
alias dmesg='dmesg --color=always'
alias ping='prettyping'
alias cat='bat'
alias catp='bat --paging=never'

# Shells
alias b='bash'
alias f='fish'

# Virtual box 
alias vm='VBoxManage'
alias vmlv='VBoxManage list vms'
alias vmlrv='VBoxManage list runningvms'

# Changing keyboard layout
alias setbr='setxkbmap -layout br'
alias setus='setxkbmap -layout us'

# Human readability
alias df='duf -hide-fs squashfs'
alias free='free -h'

# Fast edit/read configs
alias config='cat /home/flame/.config/fish/config.fish /home/flame/.config/fish/cyber.fish'

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
alias fehbgr='feh --bg-fill $(shuf -n 1 -e /home/flame/Pictures/wallpapers/dark/*) --bg-fill /home/flame/Pictures/wallpapers/justblack.jpg'
alias frenzch='/home/flame/frenzch.sh/frenzch.sh'
alias clock='tty-clock -c -C4'

# "ls" to "exa"
alias ls='exa --icons --color=always --group-directories-first' 
alias l='exa --icons --color=always --group-directories-first' 
alias la='exa --icons -la --color=always --group-directories-first'
alias ll='exa --icons -lah --color=always --group-directories-first'
alias lah='exa --icons -lah --color=always --group-directories-first'
alias lsize='du -hs * | sort -hr | less'

# Package managers
alias pacs='sudo pacman -S'
alias pacss='sudo pacman -Ss'
alias pacsyu='sudo pacman -Syu'
alias pacsyyu='sudo pacman -Syyu'
alias ys='yay -S'
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

# Virtual Box
alias vmoff='VBoxManage controlvm $1 acpipowerbutton'
alias vmforceoff='VBoxManage controlvm $1 poweroff'
alias vmstart='VBoxManage startvm $1 --type separate'
alias vmstarth='VBoxManage startvm $1 --type headless'

# Logging
alias lastjctl='journalctl -p 3 -xb'

# ────────── 《 Functions 》 ──────────
function extract
	if test -f "$1"
		set filename (basename "$1")
		set foldername (echo "$filename" | sed 's/\.[^.]*$//')
		set fullpath (perl -MCwd -e 'print Cwd::abs_path($ARGV[0])' "$1")
		set didfolderexist false
		if test -d "$foldername"
			set didfolderexist true
			read -p "$foldername already exists, do you want to overwrite it? (y/n) " -n 1
			echo
			if test "$REPLY" = "n" or "$REPLY" = "N"
				return
			end
		end
		mkdir -p "$foldername" && cd "$foldername"
		switch "$1"
			case '*.tar.bz2'
				tar xjf "$fullpath"
				;;
			case '*.tar.gz'
				tar xzf "$fullpath"
				;;
			case '*.tar.xz'
				tar Jxvf "$fullpath"
				;;
			case '*.tar.Z'
				tar xzf "$fullpath"
				;;
			case '*.tar'
				tar xf "$fullpath"
				;;
			case '*.taz'
				tar xzf "$fullpath"
				;;
			case '*.tb2'
				tar xjf "$fullpath"
				;;
			case '*.tbz'
				tar xjf "$fullpath"
				;;
			case '*.tbz2'
				tar xjf "$fullpath"
				;;
			case '*.tgz'
				tar xzf "$fullpath"
				;;
			case '*.txz'
				tar Jxvf "$fullpath"
				 ;;
			case '*.zip'
				unzip "$fullpath"
				;;
			# Default case.
			case '*'
				echo "'$1' cannot be extracted via extract()"
				cd ..
				if not $didfolderexist
					rm -r "$foldername"
				end
				;;
		end
	else
		echo "'$1' is not a valid file"
	end
end

function echovar --no-scope-shadowing
    if set -q -- $argv
        set varname $argv
    else
        set varname (echo $argv | string upper)
    end
    eval 'echo $'$varname
end

function mvl
    set destination $argv[1]
    mv ~/Downloads/(/bin/ls -t -A ~/Downloads/ | head -1) $destination
end

function row --argument index
    sed -n "$index p"
end

function skip-lines --argument n
    tail +(math 1 + $n)
end

function bak --argument filename
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
    geo $(curl ifconfig.me -s)
end

function gitsize # Calculate size of a Github repository
  echo $argv[1]  | perl -ne 'print $1 if m!([^/]+/[^/]+?)(?:\.git)?$!' | xargs -I{} curl -s -k https://api.github.com/repos/'{}' | jq '.size' | numfmt --to=iec --from-unit=1024
end

fish_add_path /home/flame/.spicetify

