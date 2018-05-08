//add_buffer_to_vbo(buffer, model_buffer, offset)

for(var i = 0; i < buffer_get_size(argument1)/Game.format_size; i+=Game.format_size)
{
	vertex_position_3d(argument0, argument1[i] + argument2[0]
								, argument1[i+1] + argument2[1]
								, argument1[i+2] + argument2[2]);
								
	vertex_color(argument0,
				 make_color_rgb(argument1[i+3],
								argument1[i+4],
								argument1[i+5]),
				argument1[i+6]);
}