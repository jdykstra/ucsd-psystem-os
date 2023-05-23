#! /usr/bin/env python3

"""UCSD p-System volume creation wrapper

Combines creating disk images with population.
"""

import sys
import os
import subprocess
from pathlib import Path


def main(args=sys.argv[1:]):
    mkfs = os.environ.get('MKFS', 'ucsdpsys_mkfs')
    disk = os.environ.get('DISK', 'ucsdpsys_disk')
    mkfs_arch = os.environ.get('MKFS_ARCH', None)
    mkfs_size = os.environ.get('MKFS_SIZE', None)

    outfile, *infiles = args

    mkfs_command = [mkfs, f'--label={Path(outfile).stem}']
    if mkfs_arch is not None:
        mkfs_command.append(f'--arch={mkfs_arch}')
    if mkfs_size is not None:
        mkfs_command.append(f'-B{mkfs_size}')
    mkfs_command.append(outfile)
    subprocess.run(mkfs_command, check=True)

    disk_put_command = [disk, '-f', outfile, '--put'] + infiles
    subprocess.run(disk_put_command, check=True)

    disk_crunch_command = [disk, '-f', outfile, '--crunch', '--list',
                           '--sort=name']
    subprocess.run(disk_crunch_command, check=True)


if __name__ == '__main__':
    main()
