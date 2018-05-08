//remove_identity(identity_index, method)

var identity = Game.identites[|argument0];

//remove tags
for(var i = 0; i < ds_list_size(identity.tag_list); i++)
{
	var tag_combo = identity.tag_list[|i];
	remove_tag(identity, tag_combo[0], argument1);
}

//remove identity
ds_list_delete(Game.identities, argument0);