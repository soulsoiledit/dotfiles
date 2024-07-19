used_percentage=$(free -m | awk '/Mem/{print 100 - 100 * $7/$2}')

jq -n --arg used_percentage "$used_percentage" '{used_percentage: $used_percentage}'
