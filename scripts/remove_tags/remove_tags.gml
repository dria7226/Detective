//remove_tags(identity, tags, method)

#macro REMOVE_REFERENCE 0
#macro REMOVE_REFERENCE_AND_TAG 1

for(var tag = 0; tag < array_length_1d(argument1); tag++)
{
	for(var i = 0; i < ds_list_size(argument0.tag_list); i++)
	{
		var tag_combo = argument0.tag_list[|i];
		if(tag_combo[0] == argument1[tag])
		{
			if(argument2 == REMOVE_REFERENCE_AND_TAG)
			{
				if(Game.tag_types[argument1[tag]] == STANDARD_TYPE)
				{
					var list = Game.tags[|tag_combo[0]];
					ds_list_delete(list, tag_combo[1]);
					continue;
				}
			
				if(Game.tag_types[argument1[tag]] == OBJECT_TYPE)
				{
					var list = Game.tags[|tag_combo[0]];
					ds_list_delete(list, tag_combo[1]);
					instance_destroy(list[|tag_combo[1]]);
				}
			}

			ds_list_delete(argument0.tag_list, i);
		}
	}
}