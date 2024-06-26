#!/bin/sh

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

SPACE_ICONS=("$GHOST" "$GHOST" "$GHOST" "$GHOST" "$GHOST" "$GHOST" "$GHOST" "$GHOST")
CURRENT_SPACE_ICONS=("$WORK" "$BROWSER" "$UNI" "$MUSIC" "$MAIL" "$GENERAL" "$GENERAL" "$GENERAL" "$GENERAL")
ACTIVE_SPACE=$(yabai -m query --spaces --space | jq '.index')
CURRENT_APP_IN_SPACE=$(osascript -e 'tell application "System Events" to get name of first application process whose frontmost is true')

space_bg=(
  background.color=$SPACEBG
  background.height=19
  background.corner_radius=50
)

for i in "${!SPACE_ICONS[@]}"; do
  sid=$(($i + 1))

  if [[ $sid -eq $ACTIVE_SPACE ]]; then
    CURRENT_ICON=$PACMAN
    sketchybar --set space.$sid "${space_bg[@]}"
  else
    CURRENT_ICON=${SPACE_ICONS["$i"]}
    sketchybar --set space.$sid background.color=$TRANSPARENT
  fi

  sketchybar --set space.$sid icon="$CURRENT_ICON"
  sketchybar --set current_space icon=${CURRENT_SPACE_ICONS[$(($ACTIVE_SPACE - 1))]}
done
