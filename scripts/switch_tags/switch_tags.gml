//switch_tags(identity, tag_type, index)

for(var i = 0; i < ds_list_size(argument0.tag_list); i++)
{
	var tag_combo = argument0.tag_list[|i];
	
	if(tag_combo[0] == argument1)
	{
		tag_combo[1] = argument2;
		break;
	}
}