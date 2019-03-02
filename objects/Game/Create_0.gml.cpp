Log = file_text_open_write("log.txt");

renderer_setup();

game_setup();

buffer_save(uniform_buffer, "uniform_buffer");