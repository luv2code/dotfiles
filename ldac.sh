#! /usr/bin/env zsh
CODEC=`pactl send-message /card/bluez_card.AC_80_0A_28_30_F1/bluez get-codec | sed s/\"//g`

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

pactl send-message /card/bluez_card.AC_80_0A_28_30_F1/bluez switch-codec $NEW_CODEC

if [[ $? -ne 0 ]]; then 
  echo "choose from:"
	pactl send-message /card/bluez_card.AC_80_0A_28_30_F1/bluez list-codecs | jq -r '.[] | "\(.name) \(.description)"'
fi
