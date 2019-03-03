
//write_normal_value_to_uniform_buffer(offset, value, precision)
buffer_seek(uniform_buffer, buffer_seek_start, argument0);
var max_value = 255.0/256.0;
var f = argument1;
var value = floor(f/max_value);
buffer_write(uniform_buffer, buffer_u8, value);
for(var i = 1; i < argument2; i++)
{
    f -= value*max_value;
    max_value /= (255.0 + (i != argument2-1));
    value = floor(f/max_value);
    buffer_write(uniform_buffer, buffer_u8, value);
}
