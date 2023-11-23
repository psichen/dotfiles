exec kmonad ~/.config/kmonad/kmonad.kbd &
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
