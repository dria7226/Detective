//create_identity(tags)
//returns identity and tag list

var array = argument0;

var answer = array_create(array_length_1d(array) + 1, -1);

var identity = instance_create_layer(0,0,0,Identity);
ds_list_add(Game.identities, identity);

answer[0] = identity;

//parse tag types
var model_name = "none";
for(var i = 0; i < array_length_1d(array); i++)
{
	if( is_string(array[i]) )
	{
		model_name = array[i];
		//model name
		if(	string_char_at(model_name, string_length(model_name)-3) == "." &&
			string_char_at(model_name, string_length(model_name)-2) == "d" &&
			string_char_at(model_name, string_length(model_name)-1) == "a" &&
			string_char_at(model_name, string_length(model_name)  ) == "t")
		{
			var model = load_model(model_name);
			ds_list_add(identity.tag_list, [Model, model]);
			answer[i+1] = Game.tags[Model, model];
		}
	}
	else
	{
		//simple tag
		ds_list_add(identity.tag_list, [array[i], array_length_2d(Game.tags, array[i])]);
		
		if(Game.tag_types[array[i]] == STANDARD_TYPE)
			answer[i+1] = identity;	
		else //OBJECT_TYPE
			answer[i+1] = instance_create_layer(0,0,0,array[i]);
			
		Game.tags[array[i], array_length_2d(Game.tags, array[i])] = answer[i+1];
	}
}

return answer;