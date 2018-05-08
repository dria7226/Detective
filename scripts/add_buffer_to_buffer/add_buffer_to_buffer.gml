//add_buffer_to_buffer(buffer, model_buffer, offset)

for(var i = 0; i < buffer_get_size(argument1)/Game.format_size; i+=Game.format_size)
{
	argument0[i  ] = argument1[i  ] + argument2[0];
	argument0[i+1] = argument1[i+1] + argument2[1];
	argument0[i+2] = argument1[i+2] + argument2[2];
								
	argument0[i+3] = argument1[i+3];
	argument0[i+4] = argument1[i+4];
	argument0[i+5] = argument1[i+5];
	argument0[i+6] = argument1[i+6];
}