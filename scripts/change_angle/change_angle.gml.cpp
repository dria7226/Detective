//change_angle(identity, type, [amount])

var identity = argument0;

var rotation = identity[Rotation];

//track changed identities
set_tags(identity, [Changed_Uniform]);

//derive buffer index from identity index
var buffer_index = argument0[INDEX]*6*4 + 4*3;

var is_added = (argument1 == CHANGE_ADD);

for(var i = 0; i < 3; i++)
{
    //change tag
    rotation.angle[i] = rotation.angle[i]*is_added + argument2[i];

    //encode in uniform buffer
    if(rotation.angle[i] > MAX_ANGLE)
    {
        write_normal_value_to_uniform_buffer(buffer_index + i, 1, 2); continue;
    }

    if(rotation.angle[i] < MIN_ANGLE)
    {
        write_normal_value_to_uniform_buffer(buffer_index + i, 0, 2); continue;
    }

    write_normal_value_to_uniform_buffer(buffer_index + i, (rotation.angle[i] - (MIN_ANGLE))/2*pi, 2);
}

#ifdef SHOW_USE
//uses_identities, uses_rotation_tag, uses_uniform_buffer
#endif
