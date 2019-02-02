//create_identity(tags)
//returns identity and tag list

var array = argument0;
var number_of_tags = array_length_1d(array);

var identity = instance_create_layer(0,0,0,Identity);
ds_list_add(Game.identities, identity);

//parse tag types
var model_name = "none";

var answer = array_create(number_of_tags, 0);

for(var i = 0; i < number_of_tags; i++)
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

			answer[i] = model;
		}
	}
	else
	{
		//simple tag
		var index = ds_list_size(Game.tags[|array[i]]);

		if(Game.tag_types[array[i]] == OBJECT_TYPE)
		{
			ds_list_add(Game.tags[|array[i]], instance_create_layer(0,0,0,array[i]));
		}
		else
		{
			ds_list_add(Game.tags[|array[i]], 0);
		}

		ds_list_add(identity.tag_list, [array[i], index]);

		answer[i] = index;
	}
}

answer[number_of_tags] = identity;

return answer;
