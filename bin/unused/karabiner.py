#!/usr/bin/env python
# Taken from somewhere in the Internet and changed by me...
#
# I (Thiago) have added the custom "toggle_modifiers" option that is
# tailored to my config and external keyboard

import os
import sys
import json
import signal
import psutil
import argparse
import subprocess
from os.path import expanduser
from collections import OrderedDict

CONFIG_PATH = '.config/karabiner/karabiner.json'

MODIFIER_OPTIONS = {
    'command_as_option': {
        'left_command': 'left_option',
        'right_command': 'right_option',
        'left_option': 'left_command',
        'right_option': 'right_command'
    },
    'command_as_command': {
        'left_command': 'left_command',
        'right_command': 'right_command',
        'left_option': 'left_option',
        'right_option': 'right_option'
    }
}

home = expanduser("~")
config = {}

def find_procs_by_name(name):
    "Return a list of processes matching 'name'."
    ls = []
    for p in psutil.process_iter():
        proc_name = ""
        try:
            proc_name = p.name()
        except (psutil.AccessDenied, psutil.ZombieProcess):
            pass
        except psutil.NoSuchProcess:
            continue
        if name in proc_name:
            ls.append(p.pid)
    return ls


def get_profiles():
    with open('{}/{}'.format(home, CONFIG_PATH)) as json_data:
        profiles = []
        config = json.load(json_data)
        for profile in config['profiles']:
            profiles.append((profile['name'], profile['selected']))
        return profiles


def get_active_profile():
    return [x[0] for x in get_profiles() if x[1]][0]


def rewrite_config(choice):
    with open('{}/{}'.format(home, CONFIG_PATH)) as conf_file:
        config = json.load(conf_file, object_pairs_hook=OrderedDict)
        for profile in config['profiles']:
            profile['selected'] = profile['name'] == choice

    with open('{}/{}'.format(home, CONFIG_PATH), 'w') as conf_file:
        conf_file.write(json.dumps(config, indent=4, separators=(',', ': ')))


def toggle_modifiers(key):
    modifier_options = MODIFIER_OPTIONS[key]

    with open('{}/{}'.format(home, CONFIG_PATH)) as conf_file:
        config = json.load(conf_file, object_pairs_hook=OrderedDict)

        [profile] = [p for p in config['profiles'] if p['name'] == 'MacBook']

        for mod in profile['simple_modifications']:
            from_key_code = mod['from']['key_code']
            to_key_code = mod['to']['key_code']

            if from_key_code in modifier_options:
                mod['to']['key_code'] = modifier_options[from_key_code]

    with open('{}/{}'.format(home, CONFIG_PATH), 'w') as conf_file:
        conf_file.write(json.dumps(config, indent=4, separators=(',', ': ')))


def restart_karabiner():
    for pid in find_procs_by_name('karabiner_console_user_server'):
        os.kill(pid, signal.SIGTERM)


def parse_args():
    parser = argparse.ArgumentParser(prog='karabiner_profile')
    parser.add_argument('-p', '--profile', help="select profile", choices=[x[0] for x in get_profiles()])
    parser.add_argument('-l', '--list', help="list profiles", default=False, action='store_true')
    parser.add_argument('-t', '--toggle-modifiers', help="toggle modifiers", choices=[value for value in MODIFIER_OPTIONS.keys()])
    return parser.parse_args()


def run_notifier(message):
    print(message)
    args = ['/usr/local/bin/terminal-notifier', '-sender', 'com.apple.Terminal', '-title', 'Karabiner', '-message', message]
    subprocess.check_call(args)


def main():
    args = parse_args()
    if args.list:
        for profile, _ in get_profiles():
            print('* {}'.format(profile))
    elif args.profile:
        rewrite_config(args.profile)
        restart_karabiner()
        run_notifier('Activated new profile: {}'.format(args.profile))
    elif args.toggle_modifiers:
        toggle_modifiers(args.toggle_modifiers)
        restart_karabiner()
        run_notifier('Toggled modifiers to {}'.format(args.toggle_modifiers))
    else:
        run_notifier('Current active profile: {}'.format(get_active_profile()))
    sys.exit(0)


if __name__ == "__main__":
    main()
