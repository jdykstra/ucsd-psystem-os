system_miscinfo = custom_target(
  'system_miscinfo',
  output : 'system.miscinfo',
  input : 'miscinfo.text',
  command : [setup, arch_flag, '--encode', '@INPUT@', '@OUTPUT@'],
  env : mkfsdisk_env,
  build_by_default : true,
)

subdir('long_integer')
subdir('transcendental')
subdir('turtle_graphics')
