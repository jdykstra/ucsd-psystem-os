linker_globals_text = fs.copyfile(globals_text)
linker_vstamp_inc_text = fs.copyfile(vstamp_inc_text)

linker_main_pas_code = custom_target(
  'linker_main_pas_code',
  output : 'main.code',
  input : 'main.text',
  depends : [linker_globals_text, linker_vstamp_inc_text],
  command : pc_system_command,
)

system_linker = custom_target(
  'system_linker',
  output : 'system.linker',
  input : linker_main_pas_code,
  command : ar_system_command,
  build_by_default : true,
)
