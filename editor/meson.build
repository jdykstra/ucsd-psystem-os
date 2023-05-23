editor_globals_text = fs.copyfile(globals_text)
editor_vstamp_inc_text = fs.copyfile(vstamp_inc_text)

editor_main_pas_code = custom_target(
  'editor_main_pas_code',
  output : 'main.code',
  input : 'main.text',
  depends : [editor_globals_text, editor_vstamp_inc_text],
  command : pc_system_command,
)

system_editor = custom_target(
  'system_editor',
  output : 'system.editor',
  input : editor_main_pas_code,
  command : ar_system_command,
  build_by_default : true,
)
