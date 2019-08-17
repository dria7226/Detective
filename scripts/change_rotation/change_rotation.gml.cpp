//change_rotation(identity, type, [amount])
var identity = argument0;

var rotation = identity[Rotation];

if(rotation == -1)
{
    log(WARNING, "Inexistent Rotation tag.", debug_get_callstack());
    return;
}

#ifdef UNIFORM_COMPRESSION
if(identity[Cached_ID] == -1)
    set_tags(identity, [Cached_ID]);
#endif

#ifdef UNIFORM_BUFFER
//derive buffer index from identity index
var buffer_index = identity[INDEX]*6*4 + 4*3;
#endif

for(var i = 0; i < 3; i++)
{
    //change tag
    rotation.axes[@i] = rotation.axes[i]*argument1 + argument2[i];
    #ifdef UNIFORM_COMPRESSION
    var no_of_circles = rotation.axes[i]/2/pi;
    var is_negative = (no_of_circles < 0);

    no_of_circles += (is_negative*2 - 1)*floor(no_of_circles*(1 - is_negative*2)) + is_negative;
    #endif

    #ifdef UNIFORM_BUFFER
    #define NORMAL_MAX MAX_ANGLE
    #define NORMAL_MIN MIN_ANGLE
    #define TO_NORMALIZE rotation.axes[i]

    #include "normalize_against_minmax.c"

    //encode in uniform buffer
    write_normal_value_to_uniform_buffer(buffer_index + 2*i, normalized_value, 2);

    #undef NORMAL_MIN
    #undef NORMAL_MAX
    #undef TO_NORMALIZE
    #endif

    #ifdef UNIFORM_COMPRESSION
    //compress and store in [Cached_ID]
    var current = abs(identity[Cached_ID].cache[i]);
    var s = sign(identity[Cached_ID].cache[i]);
    s += (s==0);
    var angle = floor(current/COMPRESSED_UNIFORM_POSITION);
    current = current - angle*COMPRESSED_UNIFORM_POSITION;

    current += floor(no_of_circles*999)*COMPRESSED_UNIFORM_POSITION;

    identity[Cached_ID].cache[@i] = current*s;
    #endif
}

#ifdef SHOW_USE
//uses_identities, uses_rotation_tag, uses_uniform_buffer, uses_uniform_compression
#endif
