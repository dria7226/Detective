//remove_identity(identity_index, method)
#macro REMOVE_IDENTITY 0
#macro REMOVE_IDENTITY_AND_TAGS 1

var identity = Game.identites[|argument0];

//remove tags
if(argument1 == REMOVE_IDENTITY_AND_TAGS)
{
	var tag_list = array_create(NO_OF_TAGS);
	for(var i = 0; i < NO_OF_TAGS; i++)
		tag_list[i] = i;

	remove_tags(identity, tag_list, REMOVE_IDENTITY_AND_TAGS);
}

//remove identity
Game.identities[|argument0] = 0;
