filer_globals_text = fs.copyfile(globals_text)
filer_vstamp_inc_text = fs.copyfile(vstamp_inc_text)

filer_main_pas_code = custom_target(
  'filer_main_pas_code',
  output : 'main.code',
  input : 'main.text',
  depends : [filer_globals_text, filer_vstamp_inc_text],
  command : pc_system_command,
)

system_filer = custom_target(
  'system_filer',
  output : 'system.filer',
  input : filer_main_pas_code,
  command : ar_system_command,
  build_by_default : true,
)
