#!/bin/fish

# ─────────── 《 Aliases 》 ───────────
alias htb='cd /home/flame/0x/targets/htb'

# ──────── 《 Abbreviations 》 ────────
abbr -a rs "rustscan --ulimit 5000 -a"
abbr -a rss "rustscan --ulimit 5000 --top -n -a"
abbr -a nn "sudo nmap -e tun0 -oN nmap-scan.txt --top-ports 1558 -sU -sC -sV -Pn"
abbr -a wl "/usr/share/wordlists"
abbr -a pipe "|"
abbr -a null "2>/dev/null"

# ────────── 《 Functions 》 ──────────
function expsrv # Starting exploit server
  set path /home/flame/0x/tools/srvexpl/
  set vpn $(ifconfig tun0 | grep 'inet.*10.10' | awk '{print $2}')  
  echo "wget http://$vpn/"
  sudo python3 -m http.server 80 -d $path
end

function iftun # Getting VPN address and send to clipboard
  set vpn $(ifconfig | grep 'inet.*10.10' | awk '{print $2}')
  xsel -c
  echo $vpn
  set sendtoclip $(echo $vpn | clip)
end

function dbquery # Search for credential leaks
    curl $API_BASE/$argv[1] -s | jq
end

function crawlh1 # Crawl (almost) all scopes with subdomains containing wildcards (*) in Hackerone
  curl -sL "https://raw.githubusercontent.com/arkadiyt/bounty-targets-data/main/data/hackerone_data.json" | jq -r '.[].targets.in_scope[] | [.asset_identifier, .asset_type] | @tsv' | awk '/URL/{print $1}' | sed -n '/^\*\./{s/^\*\.\([^[:space:]]*\)/\1/; T; s/^ //; p}' | sed 's/,/\n/g; s/^\*\.//g' | sed '/\.\*/d' | sed 's|/\*$||' | sed 's/^\*\.//' | sed '/^\*$/d' | tr '[:upper:]' '[:lower:]' | sort
end

function jqurls # Sanitizing ffuf output filtering URLs
    jq '.results[].url' | tr -d '"'
end
