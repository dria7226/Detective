//get_rotated_model(buffer, degrees)

buffer_seek(argument0, buffer_seek_start, 0);

var new_buffer = buffer_create(buffer_get_size(argument0), buffer_fixed, 0);

var no_of_vertices = buffer_get_size(new_buffer)/(Game.format_size*4);

repeat(no_of_vertices)
{
	//Position 3x4 bytes
	var XY = [0,0];
	var NXY = [0,0];
	for(i = 0; i < 2; i++)
	{
		XY[i] = buffer_read(argument0, buffer_f32);
		NXY[i] = XY[i]/COMPRESSED_NORMAL_POSITION;
		if(XY[i] < 0)
			NXY[i] = COMPRESSED_NORMAL_POSITION*ceil(NXY[i]);
		else
			NXY[i] = COMPRESSED_NORMAL_POSITION*floor(NXY[i]);

		XY[i] -= NXY[i];

		NXY[i] = abs(NXY[i])/128 - 1;
	}

	//rotate
	XY[0] = sin(argument1)*XY[1] - cos(argument1)*XY[0];
	XY[1] = cos(argument1)*XY[1] + sin(argument1)*XY[0];

	NXY[0] = sin(argument1)*NXY[1] - cos(argument1)*NXY[0];
	NXY[1] = cos(argument1)*NXY[1] + sin(argument1)*NXY[0];

	//write
	for(i = 0; i < 2; i++)
	{
		NXY[i] = (NXY[i] + 1)*128;
		XY[i] = XY[i]*(NXY[i]/abs(XY[i]) + 1);
		buffer_write(new_buffer, buffer_f32, XY[i]);
	}

	buffer_write(new_buffer, buffer_f32, buffer_read(argument0, buffer_f32));

	//Color 1x4 bytes
	buffer_write(new_buffer, buffer_f32, buffer_read(argument0, buffer_f32));

	//Texture Coordinates 2x4 bytes
	buffer_write(new_buffer, buffer_f32, buffer_read(argument0, buffer_f32));
	buffer_write(new_buffer, buffer_f32, buffer_read(argument0, buffer_f32));
}

return new_buffer;
