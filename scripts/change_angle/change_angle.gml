
//change_angle(identity, type, [amount])
var identity = argument0;

var rotation = identity[Rotation];

//track changed identities
set_tags(identity, [Changed_Uniform]);

//change tag
var is_added = (argument1 == 1);
for(var i = 0; i < 3; i++)
    rotation.angle[i] = rotation.angle[i]*is_added + argument2[i];

//derive buffer index from identity index
var buffer_index = argument0[INDEX]*6*4 + 4*3;

//encode in uniform buffer
for(var i = 0; i < 3; i++)
{
    if(rotation.angle[i] > 3.1415926535897932384626433832795)
    {
        write_normal_value_to_uniform_buffer(buffer_index + i, 1, 2); continue;
    }

    if(rotation.angle[i] < -3.1415926535897932384626433832795)
    {
        write_normal_value_to_uniform_buffer(buffer_index + i, 0, 2); continue;
    }

    write_normal_value_to_uniform_buffer(buffer_index + i, (rotation.angle[i] - (-3.1415926535897932384626433832795))/2*3.1415926535897932384626433832795, 2);
}
