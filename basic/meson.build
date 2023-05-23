basic_main_pas_code = custom_target(
  'basic_main_pas_code',
  output : 'main.code',
  input : 'main.text',
  command : pc_system_command,
)

basic_code = custom_target(
  'basic_code',
  output : 'basic.code',
  input : basic_main_pas_code,
  command : ar_system_command,
  build_by_default : true,
)
