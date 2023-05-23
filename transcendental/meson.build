transcendental_globals_text = fs.copyfile(globals_text)
transcendental_vstamp_inc_text = fs.copyfile(vstamp_inc_text)

transcendental_main_pas_code = custom_target(
  'transcendental_main_pas_code',
  output : 'main.pas.code',
  input : 'main.text',
  depends : [transcendental_globals_text, transcendental_vstamp_inc_text],
  command : pc_system_command,
)

transcendental_main_lib_code = custom_target(
  'transcendental_main_lib_code',
  output : 'main.lib.code',
  input : transcendental_main_pas_code,
  command : ar_system_command,
)

transcendental_main_code = custom_target(
  'transcendental_main_code',
  output : 'main.code',
  input : [transcendental_main_pas_code, transcendental_main_asm_code],
  command : ld_command,
  build_by_default : true,
)
