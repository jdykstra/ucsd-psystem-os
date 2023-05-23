pascalio_globals_text = fs.copyfile(globals_text)

pascalio_main_pas_code = custom_target(
  'pascalio_main_pas_code',
  output : 'main.code',
  input : 'main.text',
  depends : pascalio_globals_text,
  command : pc_system_command,
)

pascalio_main_code = custom_target(
  'pascalio_main_code',
  output : 'system.pascalio',
  input : pascalio_main_pas_code,
  command : ar_system_command,
  build_by_default : true,
)
