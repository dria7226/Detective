//create_identity(tags)
//returns identity and tag list

var array = argument0;

var answer = array_create(array_length_1d(array) + 1, -1);

ds_list_add(Game.identities, instance_create_layer(0,0,0,Identity));
var identity = Game.identities[|ds_list_size(Game.identities)];

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
			string_char_at(model_name, string_length(model_name)) == "t")
		{
			
			ds_list_add(identity.tag_list, [Model, load_model(model_name)]);
			answer[1 + i] = Game.tags[Model, array_length_2d(Game.tags, Model)-1];
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