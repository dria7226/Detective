//add_tags(identity, tags)
//if tag exists, do nothing
//if not, add it

for(var tag = 0; tag < array_length_1d(argument1); tag++)
{
	for(var i = 0; i < ds_list_size(argument0); i++)
	{
		var tag_combo = argument0.tag_list[|i];
		if(tag_combo[0] == argument1[tag])
		{
			return;
		}
	}

	ds_list_add(argument0.tag_list, [argument1[tag], array_length_2d(Game.tags, argument1)]);

	var list = Game.tags[|argument1[tag]];
	if(Game.tag_types[argument1[tag]] == STANDARD_TYPE)
	{
		ds_list_add(list, 0);
	}
			
	if(Game.tag_types[argument1[tag]] == OBJECT_TYPE)
	{
		ds_list_add(list, instance_create_layer(0,0,0, argument1[tag]));
	}
}