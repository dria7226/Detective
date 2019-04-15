//turn_static_to_dynamic(static id)

var tags = Game.tags[|Static];
tags = tags[|argument0];
tags = Game.identities[|tags].tag_list;

//remove static tag from identity tag list
for(var i = 0; i < ds_list_size(tags); i++)
{
    var tag_combo = tags[|i];
    if(tag_combo[0] == Static)
    {
        tags[|i] = 0;
        ds_list_delete(tags, i);
        i--;
    }
}

//turn static value into -1
tags = Game.tags[|Static];

if(Game.tag_types[Static] == OBJECT_TYPE)
    instance_destroy(tags[|argument0]);

tags[|argument0] = -1;
