if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  kmonad ~/.config/kmonad/kmonad.kbd &
  #exec startx
fi
