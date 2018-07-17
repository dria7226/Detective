//search_tags(identity, tags)
//return array
//	if not found: -1
//	if     found: corresponding tag index

var answer = array_create(array_length_1d(argument1), -1);

var length = ds_list_size(argument0.tag_list);

var array_length = array_length_1d(argument1);

for(var i = 0; i < array_length; i++)
{
	for(var j = 0; j < length; j++)
	{
		var tag_combo = argument0.tag_list[|j];
		if(tag_combo[0] == argument1[i])
		{
			answer[i] = tag_combo[1];
			break;
		}
	}
}

return answer;