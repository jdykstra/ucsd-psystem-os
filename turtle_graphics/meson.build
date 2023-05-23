turtle_graphics_globals_text = fs.copyfile(globals_text)
turtle_graphics_vstamp_inc_text = fs.copyfile(vstamp_inc_text)

turtle_graphics_main_pas_code = custom_target(
  'turtle_graphics_main_pas_code',
  output : 'main.pas.code',
  input : 'main.text',
  depends : [turtle_graphics_globals_text, turtle_graphics_vstamp_inc_text],
  command : pc_system_command,
)

turtle_graphics_main_lib_code = custom_target(
  'turtle_graphics_main_lib_code',
  output : 'main.lib.code',
  input : turtle_graphics_main_pas_code,
  command : ar_system_command,
)

turtle_graphics_main_code = custom_target(
  'turtle_graphics_main_code',
  output : 'main.code',
  input : [turtle_graphics_main_pas_code, turtle_graphics_main_asm_code],
  command : ld_command,
  build_by_default : true,
)
