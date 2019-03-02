//change_position(identity, type, [amount])

var identity = argument0;

var position = identity[Position];

//track changed identities
set_tags(identity, [Changed_Uniform]);

//derive buffer index from identity index
var buffer_index = identity[INDEX]*6*4;

var is_added = (argument1 == CHANGE_ADD);

for(var i = 0; i < 3; i++)
{
    //change tag
    position.coordinates[i] = position.coordinates[i]*is_added + argument2[i];

    //encode in uniform buffer
    if(position.coordinates[i] > MAX_OFFSET)
    {
        write_normal_value_to_uniform_buffer(buffer_index + i, 1, 4); continue;
    }

    if(position.coordinates[i] < MIN_OFFSET)
    {
        write_normal_value_to_uniform_buffer(buffer_index + i, 0, 4); continue;
    }

    write_normal_value_to_uniform_buffer(buffer_index + i, (position.coordinates[i] - (MIN_OFFSET))/MAX_WORLD_WIDTH, 4);
}

#ifdef SHOW_USE
//uses_identities, uses_position_tag, uses_uniform_buffer
#endif
