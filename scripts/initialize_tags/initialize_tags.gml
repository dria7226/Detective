#macro STANDARD_TYPE 0
#macro OBJECT_TYPE 1

var object_types = [Camera,
					Path,
					Position,
					Rotation,
					Color,
					Character,
					Item,
					Memory];

Game.tag_types = array_create(30, 0);

for(var i = 0; i < array_length_1d(object_types); i++)
{
	Game.tag_types[object_types[i]] = OBJECT_TYPE;
}

Game.tags[array_length_1d(Game.tag_types), 0] = 0;