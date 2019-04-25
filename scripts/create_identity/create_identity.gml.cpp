//create_identity(tags)

var array = argument0;

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

#ifdef UNIFORM_BUFFER
var id_to_set = [i/UNIFORM_BUFFER_WIDTH, 0];
id_to_set[1] = floor(id_to_set[0]);

identity[@Cached_ID].cache[0] = id_to_set[0] - id_to_set[1];
identity[@Cached_ID].cache[1] = id_to_set[1]/UNIFORM_BUFFER_WIDTH;
#endif

return identity;

//uses_identities
