#!/usr/bin/env zsh

# Get coordinate (latitude, longitude)
coordinate=$(curl -s --max-time 5 https://ipinfo.io/loc)
if [[ -z "$coordinate" || ! "$coordinate" =~ ^[0-9.-]+,[0-9.-]+$ ]]; then
  echo "Failed to get coordinate. Exiting..."
  exit 1
fi

latitude="${coordinate%,*}N"
longtitude="${coordinate#*,}E"
echo "Using sunwait with coordinate: $latitude, $longtitude"

# Infinite loop to continuously check the current time
while true; do
  now=$(date +%H:%M)
  sunset=$(sunwait list set $latitude $longtitude)
  sunrise=$(sunwait list rise $latitude $longtitude)

  if [[ "$sunrise" < "$now" && "$now" < "$sunset" ]]; then
    echo "Waiting for sunset: $sunset"
    sunwait wait set $latitude $longtitude
    echo "Sunset reached! Enabling hyprsunset."
    pkill hyprsunset || hyprsunset &
  else
    echo "Waiting for sunrise: $sunrise"
    sunwait wait rise $latitude $longtitude
    echo "Sunrise reached! Disabling hyprsunset."
    pkill hyprsunset
  fi

  sleep 60 # sleep 1 min
done
