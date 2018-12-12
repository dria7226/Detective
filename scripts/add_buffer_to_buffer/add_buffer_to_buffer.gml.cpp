//add_buffer_to_buffer(buffer, model_buffer, offset)

var arg0_size = buffer_get_size(argument0);
var arg1_size = buffer_get_size(argument1);

buffer_resize(argument0, arg0_size + arg1_size);
buffer_seek(argument0, buffer_seek_start, arg0_size);
buffer_seek(argument1, buffer_seek_start, 0);

var no_of_vertices = arg1_size/(Game.format_size*4);

repeat(no_of_vertices)
{
	//Position 3x4 bytes
	for(i = 0; i < 3; i++)
	{
		var position = buffer_read(argument1, buffer_f32);
		var normal = position/COMPRESSED_NORMAL_POSITION;
		if(position < 0)
			normal = COMPRESSED_NORMAL_POSITION*ceil(normal);
		else
			normal = COMPRESSED_NORMAL_POSITION*floor(normal);

		position = position - normal + argument2[i];

		position = position*(abs(normal/position) + 1);

		buffer_write(argument0, buffer_f32, position);
	}

	//Color 1x4 bytes
	buffer_write(argument0, buffer_f32, buffer_read(argument1, buffer_f32));

	//Texture Coordinates 2x4 bytes
	buffer_write(argument0, buffer_f32, buffer_read(argument1, buffer_f32));
	buffer_write(argument0, buffer_f32, buffer_read(argument1, buffer_f32));
}
