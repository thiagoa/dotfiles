# -*- coding: utf-8 -*-

from pathlib import Path
import sys
import re
from xkeysnail.transform import *

mappings_for_all_keyboards = {
    Key.CAPSLOCK: Key.LEFT_CTRL,
    Key.RIGHT_CTRL: Key.RIGHT_META
}

define_modmap(mappings_for_all_keyboards)

define_conditional_modmap(lambda wm_class, device_name: re.match(".*Keychron", device_name), {
    **mappings_for_all_keyboards,
    Key.LEFT_META: Key.LEFT_ALT,
    Key.LEFT_ALT: Key.LEFT_META,
    Key.RIGHT_META: Key.RIGHT_ALT
})

define_conditional_modmap(lambda wm_class, device_name: re.match(".*Logitech MX Keys", device_name), {
    **mappings_for_all_keyboards,
    Key.CAPSLOCK: Key.LEFT_CTRL,
    Key.RIGHT_META: Key.RIGHT_ALT,

    # Commented out until Ubuntu decides to change these keys this out
    # of the blue again...
    #
    #Key.LEFT_META: Key.LEFT_ALT,
    #Key.LEFT_ALT: Key.LEFT_META
})

define_timeout(1)
define_multipurpose_modmap({
    # I previously set apostrophe as dual-function control
    #
    # Key.APOSTROPHE: [Key.APOSTROPHE, Key.RIGHT_CTRL],

    Key.ENTER: [Key.ENTER, Key.RIGHT_CTRL]
})

this_config_file = sys.argv[-1] # __file__ doesn't work for this...
ignored_apps_on_default_mappings = (Path(this_config_file).parent / 'ignored_apps_on_default_mappings').read_text()

define_keymap(re.compile("Org.gnome.Nautilus"), {
    K("C-M-h"): K("M-home"),
    K("M-p"): K("M-up"),
    K("M-n"): K("M-down"),
    K("C-M-l"): K("C-M-Win-l"),
    K("M-LEFT_BRACE"): K("M-left"),
    K("M-RIGHT_BRACE"): K("M-right"),
    K("M-Shift-n"): K("C-Shift-n"),
    K("C-M-LEFT_BRACE"): K("C-page_up"),
    K("C-M-RIGHT_BRACE"): K("C-page_down")
}, "Nautilus")

#### BEGIN CHROME APPS
#
# Put specific shortcuts before the global shortcuts so that they take
# precedence.

define_keymap(re.compile("Webdiscord|Webslack"), {
    K("M-Shift-n"): K("M-Shift-down"),
    K("M-Shift-p"): K("M-Shift-up"),
    K("C-Shift-n"): K("M-down"),
    K("C-Shift-p"): K("M-up")
}, "Discord and Slack")

define_keymap(re.compile("WhatsApp"), {
    K("C-M-LEFT_BRACE"): [K("Shift-TAB"), K("Shift-TAB"), K("up"), K("enter")],
    K("C-M-RIGHT_BRACE"): [K("Shift-TAB"), K("Shift-TAB"), K("down"), K("enter")]
}, "Whatsapp")

define_keymap(re.compile("Google-chrome"), {
    K("C-M-j"): K("C-j"),
}, "Chrome")

define_keymap(re.compile("Firefox|Google-chrome|Webslack|Webdiscord|WhatsApp"), {
    K("M-p"): K("up"),
    K("M-n"): K("down"),
    K("M-Shift-comma"): K("C-home"),
    K("M-Shift-dot"): K("C-end"),
    K("C-M-RIGHT_BRACE"): K("C-TAB"),
    K("C-M-LEFT_BRACE"): K("C-Shift-TAB"),
    K("C-j"): K("C-f6"),
    K("M-r"): K("f5"),
    K("M-l"): K("C-l"),
    K("M-LEFT_BRACE"): K("M-left"),
    K("M-RIGHT_BRACE"): K("M-right"),
    K("M-enter"): K("C-enter"),
    K("M-u"): K("C-k"),
    K("M-Shift-enter"): [K("esc"), K("C-Shift-enter")],

    # Thunderbird specific, but might serve for other apps
    K("C-M-r"): K("C-r"),
    K("C-M-Shift-r"): K("C-Shift-r"),
}, "Firefox and Chrome")

#### END CHROME APPS


#### BEGIN ALL OTHER APPS

define_keymap(re.compile("Gedit"), {
    K("C-s"): K("C-f"),
    K("C-M-f"): K("C-Shift-KEY_5"),
}, "gedit")

define_keymap(re.compile("Spotify"), {
    K("C-s"): K("C-l")
}, "Spotify")

define_keymap(re.compile("Zeal"), {
    K("C-s"): K("C-k"),
}, "Zeal")

define_keymap(re.compile("Evince"), {
    K("C-s"): K("C-f")
}, "Evince")

define_keymap(re.compile("Cawbird"), {
    K("M-RIGHT_BRACE"): K("M-right"),
    K("M-LEFT_BRACE"): K("M-left"),
    K("M-n"): K("M-down")
}, "Cawbird")

define_keymap(re.compile("Gnome-terminal|DropDownTerminalWindow"), {
    K("Win-Shift-n"): K("Shift-page_down"),
    K("Win-Shift-p"): K("Shift-page_up")
}, "Terminal apps")

define_keymap(re.compile("Gnome-terminal"), {
    K("C-M-RIGHT_BRACE"): K("C-page_down"),
    K("C-M-LEFT_BRACE"): K("C-page_up"),

    # These shortcuts won't work with tmux
    K("C-M-j"): K("C-TAB"),
    K("C-M-k"): K("C-Shift-TAB"),
    K("C-j"): K("C-f6"),
}, "Gnome terminal")

define_keymap(re.compile("jetbrains-datagrip"), {
    K("C-EQUAL"): K("C-w"),
    K("C-M-w"): K("C-f4"),
    K("C-M-RIGHT_BRACE"): K("M-right"),
    K("C-M-LEFT_BRACE"): K("M-left"),
}, "Datagrip")

define_keymap(re.compile("Crow Translate"), {
    K("Win-t"): [K("C-a"), K("backspace"), K("Win-t")],
}, "Crow translate")

#### END ALL OTHER APPS


#### BEGIN GLOBAL EMACS
#
# For every global keybinding with a Control, do map another global
# keybinding that adds a Meta key to the former global keybinding. For
# example, C-b is taken by an Emacs-like keybinding but we also map
# C-M-b to C-b so that any potential shortcuts are are always
# available to whatever app. No need to worry about Alt
# (Meta).

define_keymap(lambda wm_class: wm_class not in ignored_apps_on_default_mappings.split('|'), {
    K("C-b"): with_mark(K("left")),
    K("C-M-b"): K("C-b"),
    K("C-f"): with_mark(K("right")),
    K("C-M-f"): K("C-f"),
    K("C-p"): with_mark(K("up")),
    K("C-M-p"): K("C-p"),
    K("C-n"): with_mark(K("down")),
    K("C-M-n"): K("C-n"),
    K("C-Shift-b"): [K("left"), K("left"), K("left"), K("left"), K("left")],
    K("C-Shift-f"): [K("right"), K("right"), K("right"), K("right"), K("right")],
    K("C-Shift-n"): [K("down"), K("down"), K("down"), K("down"), K("down")],
    K("C-Shift-p"): [K("up"), K("up"), K("up"), K("up"), K("up")],
    K("M-b"): with_mark(K("C-left")),
    K("M-f"): with_mark(K("C-right")),
    K("C-a"): with_mark(K("home")),
    K("C-M-a"): K("C-a"),
    K("C-e"): with_mark(K("end")),
    K("C-M-e"): K("C-e"),
    K("M-v"): with_mark(K("page_up")),
    K("C-v"): with_mark(K("page_down")),
    K("C-M-v"): K("C-v"),
    K("M-Shift-comma"): with_mark(K("C-home")),
    K("M-Shift-dot"): with_mark(K("C-end")),
    K("C-m"): K("enter"),
    K("C-M-m"): K("C-m"),
    K("C-o"): [K("enter"), K("left")],
    K("C-M-o"): K("C-o"),
    K("C-w"): [K("C-x"), set_mark(False)],
    K("C-M-w"): K("C-w"),
    K("M-w"): [K("C-c"), set_mark(False)],
    K("C-y"): [K("C-v"), set_mark(False)],
    K("C-M-y"): K("C-y"),
    K("C-d"): [K("delete"), set_mark(False)],
    K("C-M-d"): K("C-d"),
    K("M-d"): [K("C-delete"), set_mark(False)],
    K("M-backspace"): K("C-backspace"),
    K("C-backspace"): [K("Shift-home"), K("delete"), set_mark(False)],
    K("C-Shift-backspace"): [K("end"), K("Shift-home"), K("delete"), set_mark(False)],
    K("C-k"): [K("Shift-end"), K("delete"), set_mark(False)],
    K("C-M-k"): K("C-k"),
    K("C-slash"): [K("C-z"), set_mark(False)],
    K("C-Shift-slash"): [K("C-Shift-z"), set_mark(False)],
    K("C-Shift-ro"): K("C-z"),
    K("C-space"): toggle_mark(),
    K("C-M-space"): with_or_set_mark(K("C-right")),
    K("C-s"): K("F3"),
    K("C-M-s"): K("C-s"),
    K("C-r"): K("Shift-F3"),
    K("M-Shift-key_5"): K("C-h"),
    K("C-g"): [K("esc"), set_mark(False), K("C")],
    K("C-M-g"): K("C-g"),
    K("C-q"): escape_next_key,
    K("C-M-q"): K("C-q"),
    K("C-x"): {
        K("h"): [K("C-home"), K("C-a"), set_mark(True)],
        K("C-f"): K("C-o"),
        K("C-s"): K("C-s"),
        K("k"): K("C-f4"),
        K("C-c"): K("C-q"),
        K("C-g"): pass_through_key,
        K("u"): [K("C-z"), set_mark(False)],
    },
    K("C-M-s"): K("C-s")
}, "Emacs-like keys")

#### END GLOBAL EMACS


#### BEGIN GLOBAL
#
# Available to all apps. Must be defined last so that specific apps
# can override them.

define_keymap(re.compile(".*"), {
    K("C-LEFT_BRACE"): K("esc"),
    K("C-M-LEFT_BRACE"): K("esc"),

    # Dismiss current Gnome notification
    K("Win-k"): [K("Win-r"), K("esc")],
}, "All apps")

#### END GLOBAL
