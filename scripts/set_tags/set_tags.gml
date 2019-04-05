//set_tags(identity, [tags])

//parse tag types
var number_of_tags = array_length_1d(argument1);

for(var i = 0; i < number_of_tags; i++)
{
	var reading = argument1[i];

	var is_model = is_string(reading);

	var type = 0;
	var value = 0;

	if(!is_model && reading > 100000)
	{
		type = reading.object_id;
		value = reading;
	}
	else
	{
		if(is_model)
			type = Model;
		else
			type = reading;

		value = instance_create_layer(0,0,0, type);

		if(is_model)
		for(var j = 0; j < 3; j++)
			value.lod[j] = load_model(reading);

		ds_list_add(Game.tags[type], value);
	}

	argument0[@type] = value;
}

//uses_identities, uses_model_tag
