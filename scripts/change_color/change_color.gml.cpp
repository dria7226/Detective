//change_color(identity, type, [value])

var identity = argument0;

var col = identity[Color];

//track changed identities
set_tags(identity, [Changed_Uniform]);

//derive buffer index from identity index
var buffer_index = identity[INDEX]*6*4 + 4*3 + 2*3;

//change tag and encode in uniform buffer
buffer_seek(uniform_buffer, buffer_seek_start, buffer_index);
var is_added = (argument1 == CHANGE_ADD);
for(var i = 0; i < 3; i++)
{
    //change tag
    col.channels[@i] = col.channels[i]*is_added + argument2[i];

    //encode in uniform_buffer
    buffer_write(uniform_buffer, buffer_u8, col.channels[i]);
}

#ifdef SHOW_USE
//uses_identities, uses_color_tag, uses_uniform_buffer
#endif
