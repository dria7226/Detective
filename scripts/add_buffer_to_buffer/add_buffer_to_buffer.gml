//add_buffer_to_buffer(buffer, model_buffer, offset)

buffer_seek(argument0, buffer_seek_end,0);
buffer_seek(argument1, buffer_seek_start,0);

for(var i = 0; i < buffer_get_size(argument1)/Game.format_size; i+=Game.format_size)
{
	buffer_write(argument0, buffer_f32, buffer_read(argument1, buffer_f32) + argument2[0]);
	buffer_write(argument0, buffer_f32, buffer_read(argument1, buffer_f32) + argument2[1]);
	buffer_write(argument0, buffer_f32, buffer_read(argument1, buffer_f32) + argument2[2]);
	
	buffer_write(argument0, buffer_f32, buffer_read(argument1, buffer_f32));
	buffer_write(argument0, buffer_f32, buffer_read(argument1, buffer_f32));
	buffer_write(argument0, buffer_f32, buffer_read(argument1, buffer_f32));
	buffer_write(argument0, buffer_f32, buffer_read(argument1, buffer_f32));
}