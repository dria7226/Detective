//remove_tag(identity, tag, method)

#macro REMOVE_REFERENCE 0
#macro REMOVE_REFERENCE_AND_TAG 1

for(var i = 0; i < ds_list_size(argument0); i++)
{
	var tag_combo = argument0.tag_list[|i];
	if(tag_combo[0] == argument1)
	{
		if(argument2 == REMOVE_REFERENCE_AND_TAG)
		{
			if(Game.tag_types[argument1] == STANDARD_TYPE)
			{
				Game.tags[tag_combo[0], tag_combo[1]] = 0;
				continue;
			}
			
			if(Game.tag_types[argument1] == OBJECT_TYPE)
			{
				instance_destroy(Game.tags[tag_combo[0], tag_combo[1]]);
			}
		}

		ds_list_delete(argument0.tag_list, i);
	}
}