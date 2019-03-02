//create_identity(tags)

var array = argument0;
var number_of_tags = array_length_1d(array);

var identity = array_create(NO_OF_TAGS + 1, -1);
var total_identities = ds_list_size(Game.identities);

var i = 0;
for(;i < total_identities; i++)
{
    if(Game.identities[|i] != 0) continue;

    Game.identities[|i] = identity;
    break;
}

if(i >= total_identities)
    ds_list_add(Game.identities, identity);

identity[@INDEX] = i;

set_tags(identity, array);

return identity;

//uses_identities
