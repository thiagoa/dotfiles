alias activate-vpn="nmcli con up id"
alias deactivate-vpn="nmcli con down id"
alias kill-vpn="sudo pkill openvpn"

if [[ "$(uname -s)" == "Linux" ]]; then
  alias xclip="xclip -selection c"
  alias open="xdg-open"
fi
