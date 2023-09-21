read -d '\n' total available < \
	<(awk '/MemTotal|MemAvailable/ {print $2}' /proc/meminfo)

echo $((($total - $available) * 100 / $total))
