//change_grayscale(identity, type, value)

var identity = argument0;

var gs = identity[Grayscale];

if(gs == -1)
{
    log(WARNING, "Inexistent Grayscale tag.", debug_get_callstack());
    return;
}

//change tag and encode in uniform buffer
gs.value = gs.value*argument1 + argument2;

#ifdef UNIFORM_BUFFER
//derive buffer index from identity index
var buffer_index = identity[INDEX]*6*4 + 4*3 + 2*3 + 3;

buffer_poke(uniform_buffer, buffer_index, buffer_u8, floor(gs.value*byte));
#endif

#ifdef UNIFORM_COMPRESSION
if(identity[Cached_ID] == -1)
    set_tags(identity, [Cached_ID]);

identity[Cached_ID].cache[@3] =  floor(identity[Cached_ID].cache[3]*1000*1000);

identity[Cached_ID].cache[@3] += floor(gs.value*byte)/1000;
identity[Cached_ID].cache[@3] /= 1000*1000;
#endif

#ifdef SHOW_USE
//uses_identities, uses_grayscale_tag, uses_uniform_buffer, uses_uniform_compression
#endif
