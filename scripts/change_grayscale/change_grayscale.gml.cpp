//change_grayscale(identity, type, value)

var identity = argument0;

var color = identity[Color];

if(color == -1)
{
    log(WARNING, "Inexistent Color tag.", debug_get_callstack());
    return;
}

//change tag and encode in uniform buffer
color.channels[GS] = color.channels[GS]*argument1 + argument2;

#ifdef UNIFORM_BUFFER
//derive buffer index from identity index
var buffer_index = identity[INDEX]*6*4 + 4*3 + 2*3 + 3;

buffer_poke(uniform_buffer, buffer_index, buffer_u8, floor(color.channels[GS]*MAX_COLOR_AND_GS));
#endif

#ifdef UNIFORM_COMPRESSION
if(identity[Cached_ID] == -1)
    set_tags(identity, [Cached_ID]);

identity[Cached_ID].cache[@3] =  floor(identity[Cached_ID].cache[3]*100*100);

identity[Cached_ID].cache[@3] += floor(color.channels[GS]*MAX_COLOR_AND_GS)/100;
identity[Cached_ID].cache[@3] /= 100*100;
#endif

#ifdef SHOW_USE
//uses_identities, uses_color_tag, uses_uniform_buffer, uses_uniform_compression
#endif
