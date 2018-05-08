//rotate_model(buffer, degrees)

var new_buffer = buffer_create(buffer_get_size(argument0), buffer_fixed, 0);

for(var i = 0; i < buffer_get_size(argument0)/Game.format_size; i+=Game.format_size)
{
	var X = sin(argument1)*argument0[i+1] - cos(argument1)*argument0[i];
	new_buffer[i+1] = cos(argument1)*argument0[i+1] + sin(argument1)*argument0[i];
	new_buffer[i] = X;
	new_buffer[i+2] = argument0[i+2];
	
	for(var j = 3; j < Game.format_size; j++)
	{
		new_buffer[i+3] = argument0[i+j];
	}
}

  
return new_buffer;