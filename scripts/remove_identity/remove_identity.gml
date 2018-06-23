//remove_identity(identity_index, method)

var identity = Game.identites[|argument0];

//remove tags
var tag_list = array_create(1, identity.tag_list[|0]);
for(var i = 1; i < ds_list_size(identity.tag_list); i++)
{
	tag_list[i] = identity.tag_list[|i];
}

remove_tags(identity, tag_list, argument1);

//remove identity
ds_list_delete(Game.identities, argument0);