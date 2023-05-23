librarian_main_pas_code = custom_target(
  'librarian_main_pas_code',
  output : 'main.code',
  input : 'main.text',
  command : pc_system_command,
)

librarian_code = custom_target(
  'librarian_code',
  output : 'librarian.code',
  input : librarian_main_pas_code,
  command : ar_system_command,
  build_by_default : true,
)
