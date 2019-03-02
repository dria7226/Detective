#macro NO_OF_TAGS 30
#macro INDEX NO_OF_TAGS

//create tag list
Game.tags = array_create(NO_OF_TAGS);

for(var i = 0; i < NO_OF_TAGS; i++)
{
	Game.tags[i] = ds_list_create();
}
