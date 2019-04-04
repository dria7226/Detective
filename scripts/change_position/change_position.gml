
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
var normalized_value = 0.0;
if(position.coordinates[i] > 10560.0/2.0)
{
    normalized_value = 1.0;
}
if(position.coordinates[i] < -10560.0/2.0)
{
    normalized_value = 0.0;
}
normalized_value = (position.coordinates[i] - (-10560.0/2.0))/(10560.0/2.0 - (-10560.0/2.0));
    write_normal_value_to_uniform_buffer(buffer_index + 4*i, normalized_value, 4);
}
