//log(type, string)
#macro TEXT 0
#macro ERROR 1
#macro WARNING 2
#macro SEPARATOR 3
#macro TITLE 4

if(argument0 == TEXT)
{
	file_text_write_string(Game.Log, argument1);
	file_text_writeln(Game.Log);
	return;
}

if(argument0 == ERROR)
{
	file_text_write_string(Game.Log, "ERROR: " + argument1);
	file_text_writeln(Game.Log);
	return;
}

if(argument0 == WARNING)
{
	file_text_write_string(Game.Log, "///!\\\ " + argument1);
	file_text_writeln(Game.Log);
	return;
}

if(argument0 == SEPARATOR)
{
	file_text_write_string(Game.Log, /* argument1 */"--------------------------------------------");
	file_text_writeln(Game.Log);
	return;
}

if(argument0 == TITLE)
{
	file_text_write_string(Game.Log, "{---------------- " + argument1 + " ----------------}");
	file_text_writeln(Game.Log);
	return;
}