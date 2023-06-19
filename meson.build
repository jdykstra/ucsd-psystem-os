project('ucsd-psystem-os', meson_version: '>=0.64.0')

fs = import('fs')

# Core system tools.
python = find_program('python3')

# Vague equivalents of standard tools.
pc = find_program('pc', 'ucsdpsys_compile')
as = find_program('pc_as', 'ucsdpsys_assemble')
ar = find_program('pc_ar', 'ucsdpsys_librarian')
ld = find_program('pc_ld', 'ucsdpsys_link')

# Host-agnostic ucsdpsys tools.
disk = find_program('ucsdpsys_disk')
mkfs = find_program('ucsdpsys_mkfs')
setup = find_program('ucsdpsys_setup')

# Where in our installation prefix volumes get installed
volume_install_dir = get_option('datadir') / 'ucsd-psystem-os'

# Flag used by many ucsdpsys tools to determine endianess and address
# orientation.
arch_flag = '--arch=' + get_option('target_arch')

# Arg subset used by many ucsdpsys tools to specify in/output files.
inout_args = ['-o', '@OUTPUT@', '@INPUT@']

# Generators don't support adding extra dependencies per invocation so we
# unfortunately need to custom-craft custom targets for everything.
pc_args = [arch_flag, '-Wno-shadow', '-I@OUTDIR@', '-I@CURRENT_SOURCE_DIR@']
pc_command = [pc, pc_args, inout_args]
pc_system_command = [pc, pc_args, '-fignore-undefined-segment-zero', inout_args]

# All "assembly" files in this project contain only constant data, so theoreticaly 
# they could be built either as p-code or machine instructions.  However,
# the linker expects a segment kind of SEPRTSEG, which only comes from a
# machine language assembly.
as_args = ['--arch=6502', '-I.', '-I@CURRENT_SOURCE_DIR@']
as_command = [as, as_args, inout_args]

ar_system_command = [ar, '-o', '@OUTPUT@', '--file=@INPUT@', '--remove-system-segments']

ld_command = [ld, inout_args]

mkfsdisk_env = environment({
  'MKFS': mkfs.full_path(),
  'DISK': disk.full_path(),
  'MKFS_ARCH': get_option('target_arch'),
  'MKFS_SIZE': get_option('disk_kb').to_string(),
})
mkfsdisk_command = [python, files('etc/mkfsdisk.py'), '@OUTPUT@', '@INPUT@']

vstamp_inc_text = files('etc/vstamp.inc.text')
globals_text = files('system/globals.text')

subdir('diagnostic')

subdir('editor')
subdir('filer')
subdir('compiler')
subdir('linker')
subdir('host' / 'klebsch')
subdir('long_integer')
subdir('transcendental')
subdir('turtle_graphics')
subdir('pascalio')
subdir('system')

subdir('basic')
subdir('binder')
subdir('bios.diag')
subdir('calc')
subdir('copydupdir')
subdir('disassembler')
subdir('edittort11')
subdir('execerr')
subdir('libmap')
subdir('librarian')
subdir('markdupdir')
subdir('radix')
subdir('rt11toedit')
subdir('setup')
subdir('xref')
subdir('yaloe')

subdir('man')

diagnostic_vol = custom_target(
  'diagnostic_vol',
  output : 'diagnostic.vol',
  input : diagnostic_system_pascal,
  command : mkfsdisk_command,
  env : mkfsdisk_env,
  build_by_default : true,
  install : true,
  install_dir : volume_install_dir,
)

system_vol = custom_target(
  'system_vol',
  output : 'system.vol',
  input : [
    system_system_pascal,
    system_miscinfo,
    system_compiler,
    system_editor,
    system_filer,
    system_library,
    system_linker,
    system_syntax,
  ],
  command : mkfsdisk_command,
  env : mkfsdisk_env,
  build_by_default : true,
  install : true,
  install_dir : volume_install_dir,
)

utility_vol = custom_target(
  'utility_vol',
  output : 'utility.vol',
  input : [
    basic_code,
    binder_code,
    bios_diag_code,
    calc_code,
    copydupdir_code,
    disassembl_code,
    edittort11_code,
    execerr_code,
    libmap_code,
    librarian_code,
    markdupdir_code,
    radix_code,
    rt11toedit_code,
    setup_code,
    xref_code,
    yaloe_code,
  ],
  command : mkfsdisk_command,
  env : mkfsdisk_env,
  build_by_default : true,
  install : true,
  install_dir : volume_install_dir,
)
