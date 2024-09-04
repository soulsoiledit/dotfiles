network() {
  if [[ -n $(ip route) ]]; then
    status='network-up'
    symbol='󰖩'
  else
    status='network-down'
    symbol='󰖪'
  fi

  ssid=$(nmcli -t -f name connection show --active | head -n 1)

  if [[ "$ssid" == "lo" ]]; then
    ssid="None"
  fi

  jq -n -c --arg status "$status" --arg symbol "$symbol" --arg ssid "$ssid" '{status: $status, symbol: $symbol, $ssid}'
}

network
ip monitor route | rg --line-buffered 'default' | while read -r _; do
  network
done
