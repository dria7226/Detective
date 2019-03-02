
//change_position(identity, type, [amount])
var identity = argument0;

var position = identity[Position];

//track changed identities
set_tags(identity, [Changed_Uniform]);

//change tag
var is_added = (argument1 == 1);
for(var i = 0; i < 3; i++)
    position.coordinates[i] = position.coordinates[i]*is_added + argument2[i];

//derive buffer index from identity index
var buffer_index = identity[INDEX]*6*4;

//encode in uniform buffer
for(var i = 0; i < 3; i++)
{
    if(position.coordinates[i] > 10560.0/2.0)
    {
        write_normal_value_to_uniform_buffer(buffer_index + i, 1, 4); continue;
    }

    if(position.coordinates[i] < -10560.0/2.0)
    {
        write_normal_value_to_uniform_buffer(buffer_index + i, 0, 4); continue;
    }

    write_normal_value_to_uniform_buffer(buffer_index + i, (position.coordinates[i] - (-10560.0/2.0))/10560.0, 4);
}