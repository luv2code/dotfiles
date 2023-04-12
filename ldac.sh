#! /usr/bin/env zsh
CODEC=`pacmd send-message /card/bluez_card.F8_4E_17_55_4B_EF/bluez get-codec | sed s/\"//g`

if [[ "$1" == *q && "$1" != ldac_* ]]; then 
  NEW_CODEC="ldac_$1"
else
  NEW_CODEC="$1"
fi

if [[ "$NEW_CODEC" == "$CODEC" ]]; then
  echo "$NEW_CODEC already set"
  exit 0
else
  echo "set $NEW_CODEC"
fi

pactl send-message /card/bluez_card.F8_4E_17_55_4B_EF/bluez switch-codec $NEW_CODEC

if [[ $? -ne 0 ]]; then 
  echo "choose from:"
  pacmd send-message /card/bluez_card.F8_4E_17_55_4B_EF/bluez list-codecs | jq -r '.[].name'
fi
