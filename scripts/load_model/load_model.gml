//load_model(filepath)

if(!file_exists(argument0))
{
	show_debug_message("File not Found: " + string(argument0));
	return -1;
}

return buffer_load(argument0);
