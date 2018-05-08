//search_tags(identity, tag list)
//return array
//	if not found: -1
//	if     found: index in identity tag list context

var answer = array_create(array_length_1d(argument1), -1);

for(var i = 0; i < array_length_1d(argument1); i++)
{
	for(var j = 0; j < ds_list_size(argument0.tag_list); j++)
	{
		var tag_combo = argument0.tag_list[|j];
		if(tag_combo[0] == argument1[i])
		{
			answer[i] = Game.tags[tag_combo[0], tag_combo[1]];
		}
	}
}

return answer;