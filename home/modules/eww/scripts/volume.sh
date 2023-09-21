volume=$(pamixer --get-volume)
mute=$(pamixer --get-mute)
sink=$(pamixer --get-default-sink)

jq --null-input --arg volume $volume --arg mute $mute --arg sink "$sink" '{"volume": $volume, "mute": $mute, "sink": $sink}'
