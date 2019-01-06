//add_buffer_to_buffer(buffer, model_buffer, offset)

var arg0_size = buffer_get_size(argument0);
var arg1_size = buffer_get_size(argument1);

buffer_resize(argument0, arg0_size + arg1_size);

buffer_copy(argument1, 0, arg1_size, argument0, arg0_size);

for(var i = arg0_size; i < arg0_size + arg1_size; i += Game.format_size*4)
{
	for(var j = 0; j < 3; j++)
	{
		var position = buffer_peek(argument0, i + j*4, buffer_f32);

		var normal = position/COMPRESSED_NORMAL_POSITION;
		if(position < 0)
			normal = ceil(normal)*COMPRESSED_NORMAL_POSITION;
		else
			normal = floor(normal)*COMPRESSED_NORMAL_POSITION;

		position = position - normal + argument2[j];

		var s = sign(position);
		s += (s == 0);

	 	position += s*abs(normal);

		buffer_poke(argument0, i + j*4, buffer_f32, position);
	}
}
