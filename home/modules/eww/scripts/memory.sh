total=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
available=$(awk '/MemAvailable/ {print $2}' /proc/meminfo)

jq --null-input \
	--arg total $total \
	--arg available $available \
	'{"total": $total, "available": $available}'
