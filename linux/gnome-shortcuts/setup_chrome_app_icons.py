#!/usr/bin/env python3
import sys
import os
from shutil import copyfile
from pathlib import Path

sys.path.insert(0, f'{Path.home()}/.xkeysnail')

from custom_win_ids import custom_win_ids

def copy_icons(app_id, icon_name):
    source = os.path.join(Path.home(), '.dotfiles', 'linux', 'gnome-shortcuts', icon_name)
    icon_file = f'chrome-{custom_win_ids[app_id]}-Default.png'
    dest_tmpl = os.path.join(Path.home(), '.local', 'share', 'icons', 'hicolor', '{}', 'apps', icon_file)

    for size in ['16x16', '32x32', '48x48', '128x128', '256x256']:
        dest = dest_tmpl.format(size)
        dest_dir = os.path.dirname(dest)

        if os.path.exists(dest_dir):
            copyfile(source, dest)
        else:
            print(f'Path {dest_dir} does not exist!')

if __name__ == '__main__':
    copy_icons('Slack', 'slack.png')
    copy_icons('Discord', 'discord.png')
    copy_icons('WhatsApp', 'whatsapp.png')
