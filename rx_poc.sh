#! /bin/bash

#Assing city name as San Juan & obtain weather report
city='San Juan'
curl -s wttr.in/$city?T --output weather_report

# To extract Current Temperature
obs_temp=$(curl -s wttr.in/$city?T | grep -m 1 '°.' | grep -Eo -e '-?[[:digit:]].*')
echo "The current Temperature of $city: $obs_temp"

# To extract the forecast tempearature for noon tomorrow
fc_temp=$(curl -s wttr.in/$city?T | head -23 | tail -1 | grep '°.' | cut -d 'C' -f2 | grep -Eo -e '-?[[:digit:]].*')
echo "The forecasted temperature for noon tomorrow for $city : $fc_temp C"


# Assign Country and City to variable TZ
TZ='Puerto Rico/San Juan'

# Use command substitution to store the current day, month, and year in corresponding variables
hour=$(TZ='Puerto Rico/San Juan' date -u +%H) 
day=$(TZ='Puerto Rico/San Juan' date -u +%d) 
month=$(TZ='Puerto Rico/San Juan' date +%m)
year=$(TZ='Puerto Rico/San Juan' date +%Y)


# Log the weather
record=$(echo -e "$year\t$month\t$day\t$obs_temp\t$fc_temp C")
echo $record>>rx_poc.log

