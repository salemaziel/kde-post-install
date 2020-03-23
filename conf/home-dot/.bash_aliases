alias updatepc="sudo apt update && sudo apt -y full-upgrade"
alias speed="speedtest-cli --single --secure"
alias ipcheck="curl https://ifconfig.co"
alias lynx="lynx -force_secure"
alias b="buku --suggest"


## Web Dev
alias gd="gatsby develop"
alias gdc="gatsby clean"
alias gdp="gatsby develop -p"
alias gbgs="gatsby build && gatsby serve"
alias ycc="yarn cache clean"
alias ycys="yarn cache clean && yarn start"
alias ycyb="yarn cache clean && yarn build"
alias ycybs="yarn cache clean && yarn build && yarn serve"
alias ghc="git clone"
alias sg="surge teardown"

## VPN
alias wgstart="sudo systemctl start wg-quick@wg0"
alias wgstart1="sudo systemctl start wg-quick@wg1"
alias wgstop="sudo systemctl stop wg-quick@wg*"
alias wgstatus="sudo systemctl status wg-quick@wg*"
alias wgcheck="sudo wg"

alias proton="sudo protonvpn"
alias proton-rcf="sudo protonvpn d && sudo protonvpn c -f"
alias pvpn="sudo protonvpn-cli"
alias pvpn-rcf="sudo protonvpn-cli -d && sudo protonvpn-cli -f"


## SSH Shortcuts
alias sshnew-e="ssh-keygen -t ed25519 -o -a 100"
alias sshnew-r="ssh-keygen -t rsa -b 4096 -o -a 100"

## SSH logins
alias ssh-ple="ssh -i .ssh/Vul-ple-social eljefe@45.63.94.245 -p 4242"
alias ssh-csws="ssh -i .ssh/CS_Workspace codestaff-admin@138.68.3.226 -p 6969"
alias sshpi="ssh -i $HOME/.ssh/blueberry salem@192.168.1.111 -p 4242"
alias ssh-vsea="ssh -i .ssh/vul-sea_WA pc@144.202.89.111 -p 42"
