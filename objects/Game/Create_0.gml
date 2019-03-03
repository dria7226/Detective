
Log = file_text_open_write("log.txt");
renderer_setup();
game_setup();

buffer_poke(uniform_buffer, 48, buffer_u8, 128);