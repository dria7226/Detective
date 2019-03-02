
//write_normal_value_to_uniform_buffer(offset, value, precision)
var max_value = 255.0/256.0;
var f = argument1;
var value = floor(f/max_value);
buffer_poke(uniform_buffer, argument0, buffer_u8, value);
for(var i = 1; i < argument2; i++)
{
    f -= value*max_value;
    max_value /= (255.0 + (i != argument2-1));
    value = floor(f/max_value);
    buffer_poke(uniform_buffer, argument0 + i, buffer_u8, value);
}
