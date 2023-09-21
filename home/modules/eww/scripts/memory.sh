total=$(cat /proc/meminfo | awk '$1 == "MemTotal:" {print $2}')
available=$(cat /proc/meminfo | awk '$1 == "MemAvailable:" {print $2}')
percentage=$(printf %.1f $(echo "$available / $total * 100" | bc -l))
echo $percentage
