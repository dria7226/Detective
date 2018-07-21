//add_buffer_to_vbo(buffer, model_buffer, offset)

buffer_seek(argument1, buffer_seek_start, 0);

for(var i = 0; i < buffer_get_size(argument1)/Game.format_size; i+=Game.format_size)
{
	vertex_position_3d(argument0, buffer_read(argument1, buffer_f32) + argument2[0]
								, buffer_read(argument1, buffer_f32) + argument2[1]
								, buffer_read(argument1, buffer_f32) + argument2[2]);
								
	vertex_color(argument0,
				 make_color_rgb(buffer_read(argument1, buffer_f32),
								buffer_read(argument1, buffer_f32),
								buffer_read(argument1, buffer_f32)),
				buffer_read(argument1, buffer_f32));
				
	vertex_texcoord(argument0,	buffer_read(argument1, buffer_f32),
								buffer_read(argument1, buffer_f32));
}