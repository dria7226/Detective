//change_angle(identity, type, [amount])

var identity = argument0;

var rotation = identity[Rotation];

//track changed identities
set_tags(identity, [Changed_Uniform]);

//derive buffer index from identity index
var buffer_index = identity[INDEX]*6*4 + 4*3;

var is_added = (argument1 == CHANGE_ADD);

for(var i = 0; i < 3; i++)
{
    //change tag
    rotation.angle[@i] = rotation.angle[i]*is_added + argument2[i];

    //encode in uniform buffer
    #define NORMAL_MAX MAX_ANGLE
    #define NORMAL_MIN MIN_ANGLE
    #define TO_NORMALIZE rotation.angle[i]
    
    #include "normalize_against_minmax.c"

    write_normal_value_to_uniform_buffer(buffer_index + 2*i, normalized_value, 2);
    #undef NORMAL_MIN
    #undef NORMAL_MAX
    #undef TO_NORMALIZE
}

#ifdef SHOW_USE
//uses_identities, uses_rotation_tag, uses_uniform_buffer
#endif
