import XMonad

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers

import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.Spiral
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Spacing
import XMonad.Layout.Magnifier

import XMonad.Util.EZConfig(additionalKeysP)
import XMonad.Util.Loggers

import XMonad.Hooks.EwmhDesktops

------------------------------------------------------------------------
-- super key
myModMask = mod1Mask
-- Terminal
myTerminal = "alacritty"
-- Launcher
myLauncher = "rofi -show run"
-- Bar
myBar = "xmobar"

------------------------------------------------------------------------
-- Workspaces
--myWorkspaces = ["1:main","2:wall","3:misc"] ++ map show [4..9]
myWorkspaces = ["壹","贰","叁","肆","伍","陆","柒","捌","玖"]

------------------------------------------------------------------------
-- Window rules
myManageHook = composeAll
    [ isDialog --> doFloat
    , className =? "matplotlib" --> doFloat
    ]

------------------------------------------------------------------------
-- Layouts
myLayout = avoidStruts $ tiled ||| threeCol ||| spiral (6/7) ||| Full
  where
    threeCol = magnifiercz' 1.3 $ ThreeColMid nmaster delta ratio
    tiled    = Tall nmaster delta ratio
    nmaster  = 1
    ratio    = 1/2
    delta    = 3/100

------------------------------------------------------------------------
-- Colors and borders
myNormalBorderColor  = "#7c7c7c"
myFocusedBorderColor = "#ffb6b0"
-- Color of current window title in xmobar.
xmobarTitleColor = "#FFB6B0"
-- Color of current workspace in xmobar.
xmobarCurrentWorkspaceColor = "#CEFFAC"
-- Width of the window border in pixels.
myBorderWidth = 3

------------------------------------------------------------------------
-- StatusBar
myXmobarPP :: PP
myXmobarPP = def
    { ppSep             = magenta " • "
    , ppTitleSanitize   = xmobarStrip
    , ppCurrent         = wrap " " "" . xmobarBorder "Bottom" "#8be9fd" 2
    , ppHidden          = white . wrap " " ""
    , ppUrgent          = red . wrap (yellow "!") (yellow "!")
    , ppOrder           = \[ws, l, _, wins] -> [ws, l, wins]
    , ppExtras          = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused   = wrap (white    "[") (white    "]") . magenta . ppWindow
    formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . blue    . ppWindow

    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

    blue, lowWhite, magenta, red, white, yellow :: String -> String
    magenta  = xmobarColor "#ff79c6" ""
    blue     = xmobarColor "#bd93f9" ""
    white    = xmobarColor "#f8f8f2" ""
    yellow   = xmobarColor "#f1fa8c" ""
    red      = xmobarColor "#ff5555" ""
    lowWhite = xmobarColor "#bbbbbb" ""

------------------------------------------------------------------------
-- toggle Xmobar
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

------------------------------------------------------------------------
-- Run xmonad with all the defaults we set up.
main :: IO ()
main = xmonad . ewmhFullscreen . ewmh =<< statusBar myBar myXmobarPP toggleStrutsKey myConfig

myConfig = def
    { modMask    = myModMask
    , workspaces = myWorkspaces
    , layoutHook = smartSpacing 3 $ smartBorders $ myLayout
    , manageHook = myManageHook
    }
  `additionalKeysP`
    [ ("M-f", spawn "firefox")
    , ("M-a", spawn myTerminal)
    , ("M-p", spawn myLauncher)
    , ("M-u", spawn "systemctl suspend")
    ]
