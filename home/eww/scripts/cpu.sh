cpu_perc=$(top -b -n 2 | rg -o '^%Cpu.*, (\d+\.\d+) id' -r '$1' | tail -n 1)
jq -n --arg cpu_perc "$cpu_perc" '{cpu_percentage: $cpu_perc}'
