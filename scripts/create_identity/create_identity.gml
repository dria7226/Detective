//create_identity(tags)

var array = argument0;

var index = ds_list_size(Game.identities);
ds_list_add(Game.identities, instance_create_layer(0,0,0,Identity));
var identity = Game.identities[|index];

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
		}
	}
	else
	{
		//simple tag
		ds_list_add(identity.tag_list, [array[i], array_length_2d(Game.tags, array[i])]);
		Game.tags[array[i], array_length_2d(Game.tags, array[i])] = instance_create_layer(0,0,0,array[i]);
	}
}


return index;