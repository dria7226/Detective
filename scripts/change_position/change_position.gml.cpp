//change_position(identity, type, [amount])

var identity = argument0;

var position = identity[Position];

if(position == -1)
{
    log(WARNING, "Inexistent Position tag.", debug_get_callstack());
    return;
}

#ifdef UNIFORM_COMPRESSION
if(identity[Cached_ID] == -1)
    set_tags(identity, [Cached_ID]);
#endif

#ifdef UNIFORM_BUFFER
//derive buffer index from identity index
var buffer_index = identity[INDEX]*6*4;
#endif

for(var i = 0; i < 3; i++)
{
    //change tag
    position.coordinates[@i] = position.coordinates[i]*argument1 + argument2[i];


    #ifdef UNIFORM_BUFFER
    #define NORMAL_MAX MAX_OFFSET
    #define NORMAL_MIN MIN_OFFSET
    #define TO_NORMALIZE position.coordinates[i]

    #include "normalize_against_minmax.c"

    //encode in uniform buffer
    write_normal_value_to_uniform_buffer(buffer_index + 4*i, normalized_value, 4);

    #undef NORMAL_MIN
    #undef NORMAL_MAX
    #undef TO_NORMALIZE
    #endif

    #ifdef UNIFORM_COMPRESSION
    //compress and store in [Cached_ID]
    var angle = floor(abs(identity[Cached_ID].cache[i])/COMPRESSED_UNIFORM_POSITION);
    var s = sign(position.coordinates[i]);
    s += (s==0);

    identity[Cached_ID].cache[@i] = position.coordinates[i] + angle*COMPRESSED_UNIFORM_POSITION*s;
    #endif
}

#ifdef SHOW_USE
//uses_identities, uses_position_tag, uses_uniform_buffer, uses_uniform_compression
#endif
