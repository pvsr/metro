#!/usr/bin/env fish
set -l key (cat key)
set -l trip (curl -s https://dcmetrohero.com/api/v1/metrorail/trips/$argv[1]/$argv[2] -H "apikey: $key")
#set -l trip (cat metrorail-trips)

if set -l alerts (echo $trip | jq .metroAlerts -e)
  notify-send (echo $alerts | jq -r '(map(.keywords) | add | unique | join(", ")), (map(.description) | join("\\\n\\\n")) | @sh' | string unescape)
end
