#macro STANDARD_TYPE 0
#macro OBJECT_TYPE 1

var object_types = [Camera,
					Path,
					Model,
					Position,
					Rotation,
					Color,
					Character,
					Item,
					Memory];
					
for(var i = 0; i < array_length_1d(object_types); i++)
{
	Game.tag_types[object_types[i]] = OBJECT_TYPE;
}

Game.tags[30,0] = 0;