
//write_normal_value_to_uniform_buffer(offset, value, precision)
if(argument1 < 0){ log(WARNING, "Value (" + string(argument1) + ") needs to be normalized for write_normal_value_to_uniform_buffer.", debug_get_callstack()); return;}
if(argument2 <= 0){ log(WARNING, "Invalid precision (" + string(argument2) + ") used in write_normal_value_to_uniform_buffer.", debug_get_callstack()); return;}
buffer_seek(uniform_buffer, buffer_seek_start, argument0);
var max_value = 255.0/(255.0 + (argument2 != 1));
var f = argument1;
var value = floor(f/max_value);
buffer_write(uniform_buffer, buffer_u8, value);
for(var i = 1; i < argument2; i++)
{
    f -= value*max_value;
    max_value /= 255.0 + (i-1 != argument2);
    value = floor(f/max_value);
    buffer_write(uniform_buffer, buffer_u8, value);
}
