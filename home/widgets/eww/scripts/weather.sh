# full json output
weather_json=$(curl 'https://wttr.in?format=j2')
tooltip=$(curl 'wttr.in/?format=%t+(%f)+%C+%w')
weather_code=$(echo "$weather_json" | jq '.current_condition[0].weatherCode')

# source: https://github.com/chubin/wttr.in/blob/master/lib/constants.py
weather_codes_map='{
    "113": "Sunny",
    "116": "PartlyCloudy",
    "119": "Cloudy",
    "122": "VeryCloudy",
    "143": "Fog",
    "176": "LightShowers",
    "179": "LightSleetShowers",
    "182": "LightSleet",
    "185": "LightSleet",
    "200": "ThunderyShowers",
    "227": "LightSnow",
    "230": "HeavySnow",
    "248": "Fog",
    "260": "Fog",
    "263": "LightShowers",
    "266": "LightRain",
    "281": "LightSleet",
    "284": "LightSleet",
    "293": "LightRain",
    "296": "LightRain",
    "299": "HeavyShowers",
    "302": "HeavyRain",
    "305": "HeavyShowers",
    "308": "HeavyRain",
    "311": "LightSleet",
    "314": "LightSleet",
    "317": "LightSleet",
    "320": "LightSnow",
    "323": "LightSnowShowers",
    "326": "LightSnowShowers",
    "329": "HeavySnow",
    "332": "HeavySnow",
    "335": "HeavySnowShowers",
    "338": "HeavySnow",
    "350": "LightSleet",
    "353": "LightShowers",
    "356": "HeavyShowers",
    "359": "HeavyRain",
    "362": "LightSleetShowers",
    "365": "LightSleetShowers",
    "368": "LightSnowShowers",
    "371": "HeavySnowShowers",
    "374": "LightSleetShowers",
    "377": "LightSleet",
    "386": "ThunderyShowers",
    "389": "ThunderyHeavyRain",
    "392": "ThunderySnowShowers",
    "395": "HeavySnowShowers"
}'

# modified for nerd fonts
weather_icons_map='{
  "Unknown":             "󰼯",
  "Cloudy":              "󰖐",
  "Fog":                 "󰖑",
  "HeavyRain":           "󰖖",
  "HeavyShowers":        "󰖖",
  "HeavySnow":           "󰼶",
  "HeavySnowShowers":    "󰼶",
  "LightRain":           "󰖗",
  "LightShowers":        "󰖗",
  "LightSleet":          "󰖒",
  "LightSleetShowers":   "󰖘",
  "LightSnow":           "󰖘",
  "LightSnowShowers":    "󰖘",
  "PartlyCloudy":        "󰖕",
  "Sunny":               "󰖙",
  "ThunderyHeavyRain":   "󰙾",
  "ThunderyShowers":     "󰙾",
  "ThunderySnowShowers": "󰙾",
  "VeryCloudy":          "󰖐"
}'

weather_condition=$(echo "$weather_codes_map" | jq ".$weather_code")
echo "$weather_icons_map" | jq --arg tooltip "$tooltip" "{symbol: .$weather_condition, tooltip: \$tooltip}"
