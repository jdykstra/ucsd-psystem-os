long_integer_globals_text = fs.copyfile(globals_text)
long_integer_vstamp_inc_text = fs.copyfile(vstamp_inc_text)

long_integer_main_pas_code = custom_target(
  'long_integer_main_pas_code',
  output : 'main.pas.code',
  input : 'main.text',
  depends : [long_integer_globals_text, long_integer_vstamp_inc_text],
  command : pc_system_command,
)

long_integer_main_lib_code = custom_target(
  'long_integer_main_lib_code',
  output : 'main.lib.code',
  input : long_integer_main_pas_code,
  command : ar_system_command,
)

long_integer_main_code = custom_target(
  'long_integer_main_code',
  output : 'main.code',
  input : [long_integer_main_pas_code, long_integer_main_asm_code],
  command : ld_command,
  build_by_default : true,
)
