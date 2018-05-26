//NOTE: EVERYTHING NEEDS TO BE TAGGED AS DELETE PROTECTED

//load main camera
var identity = create_identity([Camera, Position, Rotation]);

identity[2].Z = 4.0;
identity[2].Y = -9.0;
identity[3].pitch = pi/2;

//load level

	//create room
identity = create_identity(["wall_cover_med_class.dat"]);

var wall_segment = buffer_create(1, buffer_grow, 1);

buffer_copy(identity[1], 0, buffer_get_size(identity[1] ), wall_segment, 0);

identity = create_identity(["wall_bumper_med_class.dat"]);

add_buffer_to_buffer(wall_segment, identity[1] , [0,-0.05,0]);

identity = create_identity(["wall_deco.dat"]);

add_buffer_to_buffer(wall_segment, identity[1] ,[0,0,4.5]);

var wall = buffer_create(1, buffer_grow, 1);

buffer_copy(wall_segment, 0, buffer_get_size(wall_segment), wall, 0);

for(var i = 1; i < 3; i++)
	add_buffer_to_buffer(wall, wall_segment, [3.0*i, 0,0]);

identity = create_identity([VBO, Position, Rotation, Color, Grayscale, Visible]);

identity[1] = vertex_create_buffer_from_buffer(wall, Game.format);

Game.test_vbo = vertex_create_buffer_from_buffer(wall, Game.format);

var a = identity[1];

identity[2].Y = 0.5;

identity[4].r = 0.2; identity[4].g = 0.4; identity[4].b = 0.2;

identity[6] = identity;

var Floor = buffer_create(1, buffer_grow, 1);

identity = create_identity(["floor.dat"]);

buffer_copy(identity[1], 0, buffer_get_size(identity[1]), Floor, 0);

var ceiling = buffer_create(1, buffer_grow, 1);

identity = create_identity(["ceiling.dat"]);


	//add items inside

identity = create_identity(["vinyl_player.dat", VBO]);

identity = create_identity(["vinyl.dat", VBO]);

identity = create_identity(["vinyl_highlights.dat", VBO]);

identity = create_identity(["desk_med_class.dat", VBO]);

identity = create_identity(["office_lamp.dat", VBO]);


//load occlusion groups
identity = create_identity([Occlusion_Group, VBO, Position, Scale, List]);

//identity[1] = Game.tags[VBO, 0];

//load song

//setup animation loop

identity = create_identity([Path]);