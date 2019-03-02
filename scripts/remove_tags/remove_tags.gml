//remove_tags(identity, [tags], method)
#macro REMOVE_REFERENCE 0
#macro REMOVE_REFERENCE_AND_TAG 1

var number_of_tags = array_length_1d(argument1);

for(var tag = 0; tag < number_of_tags; tag++)
{
	var type = argument1[tag];

	if(argument2 == REMOVE_REFERENCE_AND_TAG)
	{
		//remove tag on the Game.tags side
		instance_destroy(argument0[type]);

		var total = ds_list_size(Game.tags[type])
		for(var i = 0; i < total; i++)
		{
			var tag_list = Game.tags[type];
			if(tag_list[|i] == argument0[type])
			{
				ds_list_delete(tag_list, i);
				break;
			}
		}
	}

	//remove reference on the identity side
	argument0[@type] = -1;
}

#ifdef SHOW_USE
//uses_identities
#endif
