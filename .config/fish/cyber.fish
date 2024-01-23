#!/bin/fish

# ─────────── 《 Aliases 》 ───────────
alias a='~/0x/tools/arsenal/run'
alias htb='cd ~/0x/targets/htb'
alias thm='cd ~/0x/targets/thm/'
alias htbb='cd ~/0x/targets/htb/battlegrounds/'
alias toascii='od -An -tdC'
alias coercer='sudo python3 ~/0x/tools/Coercer/Coercer.py'
alias rmhttp="sed 's~^https\?://~~;s/\/\$//'"
alias ssb='shosubgo -s <YOUR_KEY> -d'
alias aslr_off='echo 0 | sudo tee /proc/sys/kernel/randomize_va_space'
alias libc32f='readelf -s /usr/lib32/libc.so.6 | grep'
alias libc64f='readelf -s /usr/lib/libc.so.6 | grep'
alias libc32s='strings -a -t x /usr/lib32/libc.so.6 | grep'
alias libc64s='strings -a -t x /usr/lib/libc.so.6 | grep'
alias lmk='lemmeknow'
alias pwntemplate='cat ~/0x/archive/xpl/pwn/template.py'

# ──────── 《 Abbreviations 》 ────────
abbr -a rs "rustscan --ulimit 5000 -a"
abbr -a rss "rustscan --ulimit 5000 --top -n -a"
abbr -a nn "sudo nmap -e tun0 -oN nmap-scan.txt --top-ports 1558 -sU -sC -sV -Pn"

abbr -a ff "ffuf -c -v -w /usr/share/wordlists/seclists/Discovery/Web-Content/common.txt -u"
abbr -a ff2 "ffuf -c -v -w /usr/share/wordlists/seclists/Discovery/Web-Content/big.txt -u"
abbr -a ffv "ffuf -c -v -w /usr/share/wordlists/seclists/Discovery/DNS/bitquark-subdomains-top100000.txt -H 'Host: FUZZ.domain.htb' -u http://domain.htb"

# ────────── 《 Functions 》 ──────────
function htb-getdns
  set ip $argv[1]
  set res (curl -I $ip -s | grep Location | cut -d ' ' -f2)
  set trimmed_res (echo -n "$res" | sed -e 's~^https\?://~~' | tr -d '/')

  echo $trimmed_res 

  if test -n "$trimmed_res"
    set existing_entry (grep "$trimmed_res" /etc/hosts)
    if test -z "$existing_entry"
      sudo sh -c "echo '$ip $trimmed_res' >> /etc/hosts"
      echo "Host added to /etc/hosts: $ip $trimmed_res"
    else
      echo "Entry already exists in /etc/hosts: $existing_entry"
    end
  else
    echo "Unable to retrieve a valid domain for $ip"
  end
end

function hexcalc
  set -l input (string join ' ' $argv)
  echo "obase=16;ibase=16;$input" | bc
end

function expsrv # Starting exploit server
  set path ~/0x/tools/srvexpl/
  set vpn $(ifconfig tun0 | grep 'inet.*10.10' | awk '{print $2}')  
  echo "wget http://$vpn/"
  sudo python3 -m http.server 80 -d $path
end

function vpn # Manage/fast start vpn's
  set c $argv[1]
  if test "$c" = "h"
    sudo openvpn ~/0x/vpn/lab_fant9sy.ovpn
  else if test "$c" = "d"
    sudo openvpn ~/0x/vpn/dscvpn-UDP4-1194-nicolas_vnp33113.ovpn
  else if test "$c" = "t"
    sudo openvpn ~/0x/vpn/fant9sy.ovpn
  end
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
