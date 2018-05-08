//add_tag(identity, tag)
//if tag exists, do nothing
//if not, add it

for(var i = 0; i < ds_list_size(argument0); i++)
{
	var tag_combo = argument0.tag_list[|i];
	if(tag_combo[0] == argument1)
	{
		return;
	}
	else
	{
		if(i == ds_list_size(argument0)-1)
		{
			ds_list_add(argument0.tag_list, [argument1, array_length_2d(Game.tags, argument1)]);
			
			if(Game.tag_types[argument1] == STANDARD_TYPE)
			{
				Game.tag[argument1, array_length_2d(Game.tags, argument1)] = 0;	
				continue;
			}
			
			if(Game.tag_types[argument1] == OBJECT_TYPE)
			{
				Game.tag[argument1, array_length_2d(Game.tags, argument1)] = instance_create_layer(0,0,0,argument1);
			}
		}
	}
}