yaloe_globals_text = fs.copyfile(globals_text)

yaloe_main_pas_code = custom_target(
  'yaloe_main_pas_code',
  output : 'main.code',
  input : 'main.text',
  depends : yaloe_globals_text,
  command : pc_system_command,
)

yaloe_code = custom_target(
  'yaloe_code',
  output : 'yaloe.code',
  input : yaloe_main_pas_code,
  command : ar_system_command,
  build_by_default : true,
)
