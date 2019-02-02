//sanitize_query(query)
var banned_tags = [Static];
var number_of_banned_tags = array_length_1d(banned_tags);

var query = argument0;
var number_of_tags = array_length_1d(query);

//inhibit banned tags
var sanitized_list = ds_list_create();
for(var i = 0; i < number_of_tags; i++)
{
	for(var ban = 0; ban < number_of_banned_tags; ban++)
	{
		if(query[i] == banned_tags[ban])
        {
            log(WARNING, "Attempting to create " + object_get_name(banned_tags[ban]) + " tag using create_identity(). Please use appropriate script.");
            i++; ban = 0;
        }
	}

    ds_list_add(sanitized_list, query[i]);
}

number_of_tags = ds_list_size(sanitized_list);
var sanitized_query = array_create(number_of_tags);

for(var i = 0; i < number_of_tags; i++)
    sanitized_query[i] = sanitized_list[|i];

ds_list_destroy(sanitized_list);

return sanitized_query;
