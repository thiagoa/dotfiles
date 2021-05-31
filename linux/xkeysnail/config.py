# -*- coding: utf-8 -*-

from pathlib import Path
import sys
import re
from xkeysnail.transform import *

sys.path.insert(0, f'/home/thiago/.xkeysnail')

try:
    from custom_win_ids import custom_win_ids
except ModuleNotFoundError:
    custom_win_ids = {}


### Config helpers

this_config_file = sys.argv[-1] # __file__ doesn't work for this...
ignored_apps_on_default_mappings = (Path(this_config_file).parent / 'ignored_apps_on_default_mappings').read_text()

def get_custom_win_id(name):
    return custom_win_ids.get(name) or 'UNMATCHABLE'

def app(app_id, win_id='.+'):
    return '^' + win_id + '---' + app_id + '$'

def app_re(app_id, win_id='.+'):
    return re.compile(app(app_id, win_id))

def apps_re(app_ids, win_id='.+'):
    app_ids = '(' + '|'.join(app_ids) + ')'
    return re.compile(app(app_ids, win_id))

def wins_re(win_ids, app_id='.+'):
    win_ids = '(' + '|'.join(win_ids) + ')'
    return re.compile(app(app_id, win_ids))

slack_win_id = get_custom_win_id('Slack')
discord_win_id = get_custom_win_id('Discord')
whatsapp_win_id = get_custom_win_id('WhatsApp')


### Global keyboard config

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
    Key.RIGHT_META: Key.RIGHT_ALT,
})

define_conditional_modmap(lambda wm_class, device_name: re.match(".*Logitech K380 Keyboard", device_name), {
    **mappings_for_all_keyboards,
    Key.RIGHT_META: Key.RIGHT_ALT,
})

define_timeout(1)
define_multipurpose_modmap({
    Key.ENTER: [Key.ENTER, Key.RIGHT_CTRL]
})


#### BEGIN CHROME APPS
#
# Put specific shortcuts before the global shortcuts so that they take
# precedence.

define_keymap(wins_re([slack_win_id, discord_win_id]), {
    K("M-Shift-n"): K("M-Shift-down"),
    K("M-Shift-p"): K("M-Shift-up"),
    K("C-Shift-n"): K("M-down"),
    K("C-Shift-p"): K("M-up")
}, "Discord and Slack")

define_keymap(app_re("Google-chrome", 'google-chrome'), {
    K("C-M-j"): K("C-j"),
}, "Chrome")

define_keymap(app_re('Google-chrome', whatsapp_win_id), {
    K("C-M-LEFT_BRACE"): [K("Shift-TAB"), K("Shift-TAB"), K("up"), K("enter")],
    K("C-M-RIGHT_BRACE"): [K("Shift-TAB"), K("Shift-TAB"), K("down"), K("enter")]
}, "WhatsApp")

define_keymap(re.compile(f'Firefox|Google-chrome|{slack_win_id}|{discord_win_id}|{whatsapp_win_id}'), {
    K("M-p"): K("up"),
    K("M-n"): K("down"),

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

define_keymap(app_re("Gedit"), {
    K("C-s"): K("C-f"),
    K("C-M-f"): K("C-Shift-KEY_5"),
}, "gedit")

define_keymap(app_re("Geary"), {
    K("C-comma"): K("C-dot"),
    K("C-dot"): K("C-comma"),
    K("M-comma"): K("C-dot"),
    K("M-dot"): K("C-comma"),
    K("M-Win-f"): K("M-right"),
    K("M-Win-b"): K("M-left")
}, "geary")

define_keymap(app_re("Spotify"), {
    K("C-s"): K("C-l")
}, "Spotify")

define_keymap(app_re("Zeal"), {
    K("C-s"): K("C-k"),
}, "Zeal")

define_keymap(app_re("Evince"), {
    K("C-s"): K("C-f")
}, "Evince")

define_keymap(app_re("Cawbird"), {
    K("M-RIGHT_BRACE"): K("M-right"),
    K("M-LEFT_BRACE"): K("M-left"),
    K("M-n"): K("M-down")
}, "Cawbird")

define_keymap(apps_re(["Gnome-terminal", "DropDownTerminalWindow"]), {
    K("Win-Shift-n"): K("Shift-page_down"),
    K("Win-Shift-p"): K("Shift-page_up")
}, "Terminal apps")

define_keymap(app_re("Gnome-terminal"), {
    K("C-M-RIGHT_BRACE"): K("C-page_down"),
    K("C-M-LEFT_BRACE"): K("C-page_up"),

    # These shortcuts won't work with tmux
    K("C-M-j"): K("C-TAB"),
    K("C-M-k"): K("C-Shift-TAB"),
    K("C-j"): K("C-f6"),
}, "Gnome terminal")

define_keymap(app_re("jetbrains-datagrip"), {
    K("C-EQUAL"): K("C-w"),
    K("C-M-w"): K("C-f4"),
    K("C-M-RIGHT_BRACE"): K("M-right"),
    K("C-M-LEFT_BRACE"): K("M-left"),
}, "Datagrip")

define_keymap(app_re("Crow Translate"), {
    K("Win-t"): [K("C-a"), K("backspace"), K("Win-t")],
    K("C-M-r"): K("C-r")
}, "Crow translate")

define_keymap(app_re("Org.gnome.Nautilus"), {
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

#### END ALL OTHER APPS


#### BEGIN GLOBAL EMACS
#
# For every global keybinding with a Control, do map another global
# keybinding that adds a Meta key to the former global keybinding. For
# example, C-b is taken by an Emacs-like keybinding but we also map
# C-M-b to C-b so that any potential shortcuts are are always
# available to whatever app. No need to worry about Alt
# (Meta).

define_keymap(lambda wm_class: not re.match(apps_re(ignored_apps_on_default_mappings.split('|')), wm_class), {
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
    K("C-M-r"): K("C-r"),
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
