//NOTE: EVERYTHING NEEDS TO BE TAGGED AS DELETE PROTECTED

	//create room
#define COUNT_STATIC visibles_static_count++;
var index = create_identity(["Level Building/wall_wainscoting.dat"]);

var model = Game.tags[|Model]; model = model[|index[0]];

var wall_segment = buffer_create(buffer_get_size(model), buffer_grow, 1);

buffer_copy(model, 0, buffer_get_size(model), wall_segment, 0);

index = create_identity(["Level Building/wall_deco/high.dat"]);

model = Game.tags[|Model]; model = model[|index[0]];

add_buffer_to_buffer(wall_segment, model, [0,0,4.5]);

index = create_identity(["Level Building/wall_bumper.dat"]);

model = Game.tags[|Model]; model = model[|index[0]];

add_buffer_to_buffer(wall_segment, model, [0,0,0]);

var wall = buffer_create(buffer_get_size(wall_segment), buffer_grow, 1);

buffer_copy(wall_segment, 0, buffer_get_size(wall_segment), wall, 0);

for(var i = 1; i < 3; i++)
	add_buffer_to_buffer(wall, wall_segment, [3.0*i, 0,0]);

buffer_delete(wall_segment);

var query = [VBO, Position, Rotation, Color, Grayscale];

index = create_identity(query);

wall = vertex_create_buffer_from_buffer(wall, Game.format);

var identity = Game.tags[|query[0]]; identity[|index[0]] = wall;

identity = Game.tags[|query[3]]; identity = identity[|index[3]];
identity.R = 0.2;
identity.G = 0.4;
identity.B = 0.2;

identity = Game.tags[|query[4]]; identity[|index[4]] = 1.0;

ADD_IDENTITY_TO_VISIBLES(index[5])
turn_dynamic_to_static(index[5]);

//
index = create_identity(query);

identity = Game.tags[|query[0]]; identity[|index[0]] = wall;

identity = Game.tags[|query[1]]; identity = identity[|index[1]]; identity.X = 3*3;

identity = Game.tags[|query[3]]; identity = identity[|index[3]];
identity.R = 0.2;
identity.G = 0.4;
identity.B = 0.2;

identity = Game.tags[|query[4]]; identity[|index[4]] = 0.5;

ADD_IDENTITY_TO_VISIBLES(index[5])
turn_dynamic_to_static(index[5]);

//
index = create_identity(query);

identity = Game.tags[|query[0]]; identity[|index[0]] = wall;

identity = Game.tags[|query[1]]; identity = identity[|index[1]];
identity.X = -3/2;
identity.Y = -3*3 + 3/2;

identity = Game.tags[|query[2]]; identity = identity[|index[2]]; identity.yaw = pi/2;

identity = Game.tags[|query[3]]; identity = identity[|index[3]];
identity.R = 0.2;
identity.G = 0.4;
identity.B = 0.2;

identity = Game.tags[|query[4]]; identity[|index[4]] = 0.0;

ADD_IDENTITY_TO_VISIBLES(index[5])
turn_dynamic_to_static(index[5]);
#undef COUNT_STATIC
#define COUNT_STATIC

	//floor
index = create_identity(["Level Building/floor.dat"]);

model = Game.tags[|Model]; model = model[|index[0]];

var Floor = buffer_create(buffer_get_size(model), buffer_grow, 1);

buffer_copy(model, 0, buffer_get_size(model), Floor, 0);

for(var i = 1; i < 3; i++)
{
	add_buffer_to_buffer(Floor, model, [i*3,0,0]);
}

var temp = buffer_create(buffer_get_size(Floor), buffer_fixed, 1);
buffer_copy(Floor, 0, buffer_get_size(Floor), temp, 0);

for(var i = 0; i < 3; i++)
{
	add_buffer_to_buffer(Floor, temp, [0, -i*3, 0]);
}

index = create_identity(query);

identity = Game.tags[|query[0]]; identity[|index[0]] = vertex_create_buffer_from_buffer(Floor, Game.format);

identity = Game.tags[|query[1]]; identity = identity[|index[1]]; identity.Y = -1.5;

identity = Game.tags[|query[4]]; identity[|index[4]] = 1.0;

ADD_IDENTITY_TO_VISIBLES(index[5])

index = create_identity(query);

identity = Game.tags[|query[0]]; identity[|index[0]] = identity[|index[0]-1];

identity = Game.tags[|query[1]]; identity = identity[|index[1]]; identity.X = 9;
identity = Game.tags[|query[1]]; identity = identity[|index[1]]; identity.Y = -1.5;

identity = Game.tags[|query[4]]; identity[|index[4]] = 1.0;

ADD_IDENTITY_TO_VISIBLES(index[5])

	//ceiling
//var ceiling = buffer_create(1, buffer_grow, 1);

//index = create_identity(["Level Building/ceiling.dat"]);


	//add items inside

//index = create_identity(["Objects/vinyl_player.dat", VBO]);

//index = create_identity(["Objects/vinyl.dat", VBO]);

//index = create_identity(["Objects/vinyl_highlights.dat", VBO]);

index = create_identity(["Objects/desk_med_class.dat"]);

model = Game.tags[|Model]; model = model[|index[0]];

index = create_identity(query);

identity = Game.tags[|query[0]]; identity[|index[0]] = vertex_create_buffer_from_buffer(model, Game.format);

identity = Game.tags[|query[1]]; identity = identity[|index[1]]; identity.X = 3;
identity = Game.tags[|query[1]]; identity = identity[|index[1]]; identity.Y = -1.5;

identity = Game.tags[|query[4]]; identity[|index[4]] = 1.0;

ADD_IDENTITY_TO_VISIBLES(index[5])

//

index = create_identity(["Objects/office_lamp.dat"]);

model = Game.tags[|Model]; model = model[|index[0]];

index = create_identity(query);

identity = Game.tags[|query[0]]; identity[|index[0]] = vertex_create_buffer_from_buffer(model, Game.format);

identity = Game.tags[|query[1]]; identity = identity[|index[1]]; identity.X = 2.5;
identity = Game.tags[|query[1]]; identity = identity[|index[1]]; identity.Y = -1.5;
identity = Game.tags[|query[1]]; identity = identity[|index[1]]; identity.Z = 3;

identity = Game.tags[|query[2]]; identity = identity[|index[2]]; identity.yaw = 0;

identity = Game.tags[|query[4]]; identity[|index[4]] = 1.0;

ADD_IDENTITY_TO_VISIBLES(index[5])

#undef COUNT_STATIC
#define COUNT_STATIC

//load occlusion groups

//query = [Occlusion_Group, VBO, Position, Scale];
//index = create_identity(query);

//index[1] = Game.tags[VBO, 0];

//load song

//setup animation loop

//index = create_identity([Path]);
