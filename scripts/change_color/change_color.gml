
//change_color(identity, type, [value])
var identity = argument0;
var col = identity[Color];
//track changed identities
set_tags(identity, [Changed_Uniform]);
//derive buffer index from identity index
var buffer_index = argument0[INDEX]*6*4 + 4*3 + 2;
//change tag and encode in uniform buffer
var is_added = (argument1 == 1);
for(var i = 0; i < 3; i++)
{
    //change tag
    col.channels[i] = col.channels[i]*is_added + argument2[i];
    //encode in uniform_buffer
    buffer_poke(uniform_buffer, buffer_index + i, buffer_u8, col.channels[i]);
}
