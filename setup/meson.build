setup_main_pas_code = custom_target(
  'setup_main_pas_code',
  output : 'main.code',
  input : 'main.text',
  command : pc_system_command,
)

setup_code = custom_target(
  'setup_code',
  output : 'setup.code',
  input : setup_main_pas_code,
  command : ar_system_command,
  build_by_default : true,
)
