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

define_timeout(1)
define_multipurpose_modmap({
    Key.APOSTROPHE: [Key.APOSTROPHE, Key.RIGHT_CTRL],
    Key.ENTER: [Key.ENTER, Key.RIGHT_CTRL]
})

define_keymap(re.compile("Firefox|Google-chrome|Slack"), {
    K("C-M-n"): K("C-n"),
    K("C-n"): K("down"),
    K("C-p"): K("up"),
    K("M-p"): K("up"),
    K("M-n"): K("down"),
    K("C-a"): K("home"),
    K("C-e"): K("end"),
    K("M-Shift-comma"): K("C-home"),
    K("M-Shift-dot"): K("C-end"),
    K("M-Shift-RIGHT_BRACE"): K("C-TAB"),
    K("M-Shift-LEFT_BRACE"): K("C-Shift-TAB"),
    K("C-j"): K("C-f6"),
    K("M-r"): K("f5"),
    K("M-l"): K("C-l"),
    K("M-LEFT_BRACE"): K("M-left"),
    K("M-RIGHT_BRACE"): K("M-right"),
    K("C-M-w"): K("C-w"),
    K("C-M-d"): K("C-d"),
    K("M-enter"): K("C-enter"),
}, "Firefox and Chrome")

define_keymap(re.compile("Google-chrome"), {
    K("C-M-j"): K("C-j"),
}, "Chrome")

define_keymap(re.compile("Gnome-terminal"), {
    K("M-Shift-RIGHT_BRACE"): K("C-page_down"),
    K("M-Shift-LEFT_BRACE"): K("C-page_up"),
    K("C-M-j"): K("C-TAB"),
    K("C-M-k"): K("C-Shift-TAB"),
    K("C-j"): K("C-f6"),
}, "Gnome terminal")

define_keymap(re.compile("Geary"), {
    K("C-M-n"): K("C-n"),
}, "Geary")

define_keymap(re.compile("discord|Slack"), {
    K("C-M-k"): K("C-k"),
    K("M-Shift-n"): K("M-Shift-down"),
    K("M-Shift-p"): K("M-Shift-up")
}, "Discord and Slack")

define_keymap(re.compile("Gedit"), {
    K("C-s"): K("C-f"),
    K("C-M-w"): K("C-w"),
    K("C-M-f"): K("C-Shift-KEY_5"),
}, "gedit")

define_keymap(re.compile("Zeal"), {
    K("C-s"): K("C-k"),
}, "Zeal")

define_keymap(re.compile("WhatsApp"), {
    K("M-Shift-LEFT_BRACE"): [K("Shift-TAB"), K("Shift-TAB"), K("up"), K("enter")],
    K("M-Shift-RIGHT_BRACE"): [K("Shift-TAB"), K("Shift-TAB"), K("down"), K("enter")]
}, "Whatsapp")

define_keymap(re.compile(".*"), {
    K("C-LEFT_BRACE"): K("esc")
}, "All apps")

define_keymap(re.compile("albert"), {
    K("M-p"): K("M-up"),
    K("M-n"): K("M-down")
}, "All apps")

this_config_file = sys.argv[-1] # __file__ doesn't work for this...
ignored_apps_on_default_mappings = (Path(this_config_file).parent / 'ignored_apps_on_default_mappings').read_text()

define_keymap(lambda wm_class: wm_class not in ignored_apps_on_default_mappings.split('|'), {
    K("C-b"): with_mark(K("left")),
    K("C-f"): with_mark(K("right")),
    K("C-p"): with_mark(K("up")),
    K("C-n"): with_mark(K("down")),
    K("M-b"): with_mark(K("C-left")),
    K("M-f"): with_mark(K("C-right")),
    K("C-a"): with_mark(K("home")),
    K("C-e"): with_mark(K("end")),
    K("M-v"): with_mark(K("page_up")),
    K("C-v"): with_mark(K("page_down")),
    K("M-Shift-comma"): with_mark(K("C-home")),
    K("M-Shift-dot"): with_mark(K("C-end")),
    K("C-m"): K("enter"),
    K("C-j"): K("enter"),
    K("C-o"): [K("enter"), K("left")],
    K("C-w"): [K("C-x"), set_mark(False)],
    K("M-w"): [K("C-c"), set_mark(False)],
    K("C-y"): [K("C-v"), set_mark(False)],
    K("C-d"): [K("delete"), set_mark(False)],
    K("M-d"): [K("C-delete"), set_mark(False)],
    K("M-backspace"): K("C-backspace"),
    K("C-k"): [K("Shift-end"), K("delete"), set_mark(False)],
    K("C-slash"): [K("C-z"), set_mark(False)],
    K("C-Shift-ro"): K("C-z"),
    K("C-space"): toggle_mark(),
    K("C-M-space"): with_or_set_mark(K("C-right")),
    K("C-s"): K("F3"),
    K("C-r"): K("Shift-F3"),
    K("M-Shift-key_5"): K("C-h"),
    K("C-g"): [K("esc"), set_mark(False), K("C")],
    K("C-q"): escape_next_key,
    K("C-M-v"): set_mark(False),
    K("C-x"): {
        K("h"): [K("C-home"), K("C-a"), set_mark(True)],
        K("C-f"): K("C-o"),
        K("C-s"): K("C-s"),
        K("k"): K("C-f4"),
        K("C-c"): K("C-q"),
        K("C-g"): pass_through_key,
        K("u"): [K("C-z"), set_mark(False)],
    }
}, "Emacs-like keys")