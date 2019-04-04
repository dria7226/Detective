//change_position(identity, type, [amount])

var identity = argument0;

var position = identity[Position];

//track changed identities
set_tags(identity, [Changed_Uniform]);

//derive buffer index from identity index
var buffer_index = identity[INDEX]*6*4;

for(var i = 0; i < 3; i++)
{
    //change tag
    position.coordinates[@i] = position.coordinates[i]*argument1 + argument2[i];

    //encode in uniform buffer
    #define NORMAL_MAX MAX_OFFSET
    #define NORMAL_MIN MIN_OFFSET
    #define TO_NORMALIZE position.coordinates[i]

    #include "normalize_against_minmax.c"

    write_normal_value_to_uniform_buffer(buffer_index + 4*i, normalized_value, 4);
    #undef NORMAL_MIN
    #undef NORMAL_MAX
    #undef TO_NORMALIZE
}

#ifdef SHOW_USE
//uses_identities, uses_position_tag, uses_uniform_buffer
#endif
