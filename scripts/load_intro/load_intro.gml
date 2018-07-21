//NOTE: EVERYTHING NEEDS TO BE TAGGED AS DELETE PROTECTED

//load main camera
var query = [Camera, Position, Rotation, "Objects/movie_camera.dat", VBO];

var index = create_identity(query);

var vbo = Game.tags[|query[4]]; vbo = vbo[|index[4]];
var model = Game.tags[|Model]; model = model[|index[3]];
vbo = vertex_create_buffer_from_buffer(model, Game.format);

var position = Game.tags[|query[1]]; position = position[|index[1]];
position.X = 4.5;
position.Y = -9.0;
position.Z = 4.0;

//load level

	//create room
index = create_identity(["Level Building/wall_wainscoting.dat"]);

var wall_segment = buffer_create(1, buffer_grow, 1); 

model = Game.tags[|Model]; model = model[|index[0]];

buffer_copy(model, 0, buffer_get_size(model), wall_segment, 0);

index = create_identity(["Level Building/wall_deco.dat"]);

model = Game.tags[|Model]; model = model[|index[0]];

add_buffer_to_buffer(wall_segment, model, [0,0,4.5]);

var wall = buffer_create(1, buffer_grow, 1);

buffer_copy(wall_segment, 0, buffer_get_size(wall_segment), wall, 0);

for(var i = 1; i < 3; i++)
	add_buffer_to_buffer(wall, wall_segment, [3.0*i, 0,0]);
	
buffer_delete(wall_segment);

query = [VBO, Position, Rotation, Color, Grayscale, Visible];

index = create_identity(query);

wall = vertex_create_buffer_from_buffer(wall, Game.format);

var identity = Game.tags[|query[0]]; identity[|index[0]] = wall;

identity = Game.tags[|query[3]]; identity = identity[|index[3]];
identity.r = 0.2;
identity.g = 0.4;
identity.b = 0.2;

identity = Game.tags[|query[4]]; identity[|index[4]] = 1.0;

identity = Game.tags[|query[5]]; identity[|index[5]] = index[6];

//
index = create_identity(query);

identity = Game.tags[|query[0]]; identity[|index[0]] = wall;

identity = Game.tags[|query[1]]; identity = identity[|index[1]]; identity.X = 3*3;

identity = Game.tags[|query[3]]; identity = identity[|index[3]];
identity.r = 0.2;
identity.g = 0.4;
identity.b = 0.2;

identity = Game.tags[|query[4]]; identity[|index[4]] = 0.5;

identity = Game.tags[|query[5]]; identity[|index[5]] = index[6];
//
index = create_identity(query);

identity = Game.tags[|query[0]]; identity[|index[0]] = wall;

identity = Game.tags[|query[1]]; identity = identity[|index[1]]; identity.Y = -3*3;

identity = Game.tags[|query[2]]; identity = identity[|index[2]]; identity.yaw = pi/2;

identity = Game.tags[|query[3]]; identity = identity[|index[3]];
identity.r = 0.2;
identity.g = 0.4;
identity.b = 0.2;

identity = Game.tags[|query[4]]; identity[|index[4]] = 0.0;

identity = Game.tags[|query[5]]; identity[|index[5]] = index[6];

	//floor
index = create_identity(["Level Building/floor.dat"]);

model = Game.tags[|Model]; model = model[|index[0]];

var Floor = buffer_create(1, buffer_grow, 1);

buffer_copy(model, 0, buffer_get_size(model), Floor, 0);

for(var i = 1; i < 6; i++)
{
	for(var j = 0; j < 3; j++)
	{
		add_buffer_to_buffer(Floor, model, [i*3, -j*3, 0]);
	}
}

index = create_identity(query);

identity = Game.tags[|query[0]]; identity[|index[0]] = vertex_create_buffer_from_buffer(Floor, Game.format);

identity = Game.tags[|query[1]]; identity = identity[|index[1]]; identity.Y = -1.5;

identity = Game.tags[|query[4]]; identity[|index[4]] = 1.0;

identity = Game.tags[|query[5]]; identity[|index[5]] = index[6];

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

identity = Game.tags[|query[2]]; identity = identity[|index[2]]; identity.yaw = pi;

identity = Game.tags[|query[4]]; identity[|index[4]] = 1.0;

identity = Game.tags[|query[5]]; identity[|index[5]] = index[6];

//index = create_identity(["Objects/office_lamp.dat", VBO]);


//load occlusion groups

query = [Occlusion_Group, VBO, Position, Scale];
index = create_identity(query);

//index[1] = Game.tags[VBO, 0];

//load song

//setup animation loop

index = create_identity([Path]);

//debugging
for(var j = 0; j < ds_list_size(tags[|VBO]); j++)
{
	vbo = tags[|VBO];
	show_debug_message("VBO: " + string(j) + " Size: " + string(buffer_get_size(vbo[|j])) + " Number of vertices: " + string(buffer_get_size(vbo[|j])/24));
	//for(var i = 0; i < buffer_get_size(vbo[|j])/24; i++)
	//{
	//	show_debug_message("      X      Y      color      U      V   ");
	//	show_debug_message(	"  # " + string(i) + 
	//						"     " + string(buffer_read(vbo[|j], buffer_f32)) +
	//						"     " + string(buffer_read(vbo[|j], buffer_f32)) +
	//						"     " + string(buffer_read(vbo[|j], buffer_f32)) +
	//						"     " + string(buffer_read(vbo[|j], buffer_f32)) +
	//						"     " + string(buffer_read(vbo[|j], buffer_f32)) +
	//						"     " + string(buffer_read(vbo[|j], buffer_f32)));
	//	show_debug_message(" ");
	//}
}