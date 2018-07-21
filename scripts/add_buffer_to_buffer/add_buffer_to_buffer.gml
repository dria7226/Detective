//add_buffer_to_buffer(buffer, model_buffer, offset)

buffer_seek(argument1, buffer_seek_start,0);

var no_of_vertices = buffer_get_size(argument1)/(Game.format_size*4);

repeat(no_of_vertices)
{	
	//Position 3x4 bytes
	buffer_write(argument0, buffer_f32, buffer_read(argument1, buffer_f32) + argument2[0]);
	buffer_write(argument0, buffer_f32, buffer_read(argument1, buffer_f32) + argument2[1]);
	buffer_write(argument0, buffer_f32, buffer_read(argument1, buffer_f32) + argument2[2]);
	
	//Color 1x4 bytes
	buffer_write(argument0, buffer_f32, buffer_read(argument1, buffer_f32));
	
	//Texture Coordinates 2x4 bytes
	buffer_write(argument0, buffer_f32, buffer_read(argument1, buffer_f32));
	buffer_write(argument0, buffer_f32, buffer_read(argument1, buffer_f32));
}