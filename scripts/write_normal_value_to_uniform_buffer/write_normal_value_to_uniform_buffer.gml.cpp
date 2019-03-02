//write_normal_value_to_uniform_buffer(offset, value, precision)
var max_value = byte/256.0;
var f = floor(argument1/max_value);
buffer_poke(uniform_buffer, argument0, buffer_u8, f);
for(var i = 1; i < argument2; i++)
{
    f -= f*max_value;
    max_value /= (byte + (i != argument2-1));
    f = floor(f/max_value);
    buffer_poke(uniform_buffer, argument0, buffer_u8, f);
}
