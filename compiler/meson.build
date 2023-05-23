compiler_globals_text = fs.copyfile(globals_text)
compiler_vstamp_inc_text = fs.copyfile(vstamp_inc_text)

compiler_main_pas_code = custom_target(
  'compiler_main_pas_code',
  output : 'main.code',
  input : 'main.text',
  depends : [compiler_globals_text, compiler_vstamp_inc_text],
  command : pc_system_command,
)

system_compiler = custom_target(
  'system_compiler',
  output : 'system.compiler',
  input : compiler_main_pas_code,
  command : ar_system_command,
  build_by_default : true,
)

system_syntax = fs.copyfile('error-messages.text', 'system.syntax')
