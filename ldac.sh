#! /usr/bin/env zsh

pactl send-message /card/bluez_card.F8_4E_17_55_4B_EF/bluez switch-codec "ldac_$1"
