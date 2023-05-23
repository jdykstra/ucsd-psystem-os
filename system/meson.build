system_globals_text = fs.copyfile(globals_text)
system_vstamp_inc_text = fs.copyfile(vstamp_inc_text)

system_system_pascal = custom_target(
  'system_system_pascal',
  output : 'system.pascal',
  input : 'main.text',
  depends : [system_globals_text, system_vstamp_inc_text],
  command : pc_command,
)

system_library = custom_target(
  'system_library',
  output : 'system.library',
  input : [
    long_integer_main_code,
    pascalio_main_code,
    transcendental_main_code,
    turtle_graphics_main_code,
  ],
  command : [
    ar, '--create', '@OUTPUT@',
    '--copy', '@INPUT0@', '--segment', 'longinte=30',
    '--copy', '@INPUT1@', '--segment', 'pascalio=31',
    '--copy', '@INPUT2@', '--segment', 'transcen=29',
    '--copy', '@INPUT3@', '--segment', 'turtlegr=20',
  ]
)
