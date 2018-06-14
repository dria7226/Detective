//NOTE: EVERYTHING NEEDS TO BE TAGGED AS DELETE PROTECTED

//load main camera
var query = [Camera, Position, Rotation];

var index = create_identity(query);

Game.tags[query[1], index[1]].X = 4.5;
Game.tags[query[1], index[1]].Y = -9.0;
Game.tags[query[1], index[1]].Z = 4.0;

//load level

	//create room
index = create_identity(["Level Building/wall_wainscoting.dat"]);

var wall_segment = buffer_create(1, buffer_grow, 1);

buffer_copy(Game.tags[Model, index[0]], 0, buffer_get_size(Game.tags[Model, index[0]]), wall_segment, 0);

index = create_identity(["Level Building/wall_deco.dat"]);

add_buffer_to_buffer(wall_segment, Game.tags[Model, index[0]], [0,0,4.5]);

var wall = buffer_create(1, buffer_grow, 1);

buffer_copy(wall_segment, 0, buffer_get_size(wall_segment), wall, 0);

for(var i = 1; i < 3; i++)
	add_buffer_to_buffer(wall, wall_segment, [3.0*i, 0,0]);

query = [VBO, Position, Rotation, Color, Grayscale, Visible];

index = create_identity(query);

wall = vertex_create_buffer_from_buffer(wall, Game.format);

Game.tags[query[0], index[0]] = wall;

Game.tags[query[3], index[3]].r = 0.2;
Game.tags[query[3], index[3]].g = 0.4;
Game.tags[query[3], index[3]].b = 0.2;

Game.tags[query[4], index[4]] = 1.0;

Game.tags[query[5], index[5]] = index[6];
//
index = create_identity(query);

Game.tags[query[0], index[0]] = wall;

Game.tags[query[1], index[1]].X = 3*3;

Game.tags[query[3], index[3]].r = 0.2;
Game.tags[query[3], index[3]].g = 0.4;
Game.tags[query[3], index[3]].b = 0.2;

Game.tags[query[4], index[4]] = 1.0;

Game.tags[query[5], index[5]] = index[6];
//
index = create_identity(query);

Game.tags[query[0], index[0]] = wall;

Game.tags[query[1], index[1]].Y = -3*3;

Game.tags[query[2], index[2]].pitch = pi/2;

Game.tags[query[3], index[3]].r = 0.2;
Game.tags[query[3], index[3]].g = 0.4;
Game.tags[query[3], index[3]].b = 0.2;

Game.tags[query[4], index[4]] = 1.0;

Game.tags[query[5], index[5]] = index[6];

	//floor
index = create_identity(["Level Building/floor.dat"]);

var Floor = buffer_create(1, buffer_grow, 1);

buffer_copy(Game.tags[Model, index[0]], 0, buffer_get_size(Game.tags[Model, index[0]]), Floor, 0);

for(var i = 1; i < 6; i++)
{
	for(var j = 0; j < 3; j++)
	{
		add_buffer_to_buffer(Floor, Game.tags[Model, index[0]], [i*3, -j*3, 0]);
	}
}

index = create_identity(query);

Game.tags[query[0], index[0]] = vertex_create_buffer_from_buffer(Floor, Game.format);

Game.tags[query[1], index[1]].Y = -1.5;

Game.tags[query[4], index[4]] = 1.0;

Game.tags[query[5], index[5]] = index[6];

	//ceiling
var ceiling = buffer_create(1, buffer_grow, 1);

index = create_identity(["Level Building/ceiling.dat"]);


	//add items inside

index = create_identity(["Objects/vinyl_player.dat", VBO]);

index = create_identity(["Objects/vinyl.dat", VBO]);

index = create_identity(["Objects/vinyl_highlights.dat", VBO]);

index = create_identity(["Objects/desk_med_class.dat", VBO]);

index = create_identity(["Objects/office_lamp.dat", VBO]);


//load occlusion groups

query = [Occlusion_Group, VBO, Position, Scale, List];
index = create_identity(query);

//index[1] = Game.tags[VBO, 0];

//load song

//setup animation loop

index = create_identity([Path]);