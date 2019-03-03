
//change_angle(identity, type, [amount])
var identity = argument0;
var rotation = identity[Rotation];
//track changed identities
set_tags(identity, [Changed_Uniform]);
//derive buffer index from identity index
var buffer_index = identity[INDEX]*6*4 + 4*3;
var is_added = (argument1 == 1);
for(var i = 0; i < 3; i++)
{
    //change tag
    rotation.angle[@i] = rotation.angle[i]*is_added + argument2[i];
    //encode in uniform buffer
var normalized_value = 0.0;
if(rotation.angle[i] > 3.1415926535897932384626433832795)
{
    normalized_value = 1.0;
}
if(rotation.angle[i] < -3.1415926535897932384626433832795)
{
    normalized_value = 0.0;
}
normalized_value = (rotation.angle[i] - (-3.1415926535897932384626433832795))/(3.1415926535897932384626433832795 - (-3.1415926535897932384626433832795));
    write_normal_value_to_uniform_buffer(buffer_index + 2*i, normalized_value, 2);
}
