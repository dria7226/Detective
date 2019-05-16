//change_color(identity, type, [value])

var identity = argument0;

var col = identity[Color];

if(col == -1)
{
    log(WARNING, "Inexistent Color tag.", debug_get_callstack());
    return;
}

#ifdef UNIFORM_BUFFER
//derive buffer index from identity index
var buffer_index = identity[INDEX]*6*4 + 4*3 + 2*3;

//change tag and encode in uniform buffer
buffer_seek(uniform_buffer, buffer_seek_start, buffer_index);
#endif

#ifdef UNIFORM_COMPRESSION
if(identity[Cached_ID] == -1)
    set_tags(identity, [Cached_ID]);

identity[Cached_ID].cache[@3] = (identity[Cached_ID].cache[3]*1000*1000*1000)%1000;
#endif

for(var i = 0; i < 3; i++)
{
    //change tag
    col.channels[@i] = col.channels[i]*argument1 + argument2[i];

    #ifdef UNIFORM_BUFFER
    //encode in uniform_buffer
    buffer_write(uniform_buffer, buffer_u8, floor(col.channels[i]*byte));
    #endif

    #ifdef UNIFORM_COMPRESSION
    identity[Cached_ID].cache[@3] /= 1000;
    identity[Cached_ID].cache[@3] += floor(col.channels[i]*byte);
    #endif
}

#ifdef SHOW_USE
//uses_identities, uses_color_tag, uses_uniform_buffer, uses_uniform_compression
#endif
