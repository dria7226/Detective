//NOTE: EVERYTHING NEEDS TO BE TAGGED AS DELETE PROTECTED

//load main camera
var identity = create_identity([Camera, Position, Rotation]);

identity[2].Z = 1.0;
//tags[2].pitch = -pi/2;

//load level

	//create room
var wall_segment = buffer_create(1, buffer_grow, 4);

identity = create_identity(["wall_deco.dat"]);

add_buffer_to_buffer(wall_segment, identity[1].buffer,[0,0,4.5]);

identity = create_identity(["wall_bumper_med_class.dat"]);

add_buffer_to_buffer(wall_segment, identity[1].buffer,[0,0,0]);

identity = create_identity(["wall_cover_med_class.dat"]);

add_buffer_to_buffer(wall_segment, identity[1].buffer,[0,0,0]);

//identity = create_identity([VBO]);

//Game.test_vbo = vertex_create_buffer_from_buffer(wall_segment, Game.format);

identity = create_identity(["floor.dat"]);

identity = create_identity(["ceiling.dat"]);


	//add items inside

identity = create_identity(["vinyl_player.dat", VBO]);

identity = create_identity(["vinyl.dat", VBO]);

identity = create_identity(["vinyl_highlights.dat", VBO]);

identity = create_identity(["desk_med_class.dat", VBO]);

identity = create_identity(["office_lamp.dat", VBO]);


//load occlusion groups
identity = create_identity([Occlusion_Group, VBO, Position, Scale, List]);

var tag_combo_list = Game.identities[|identity];
tag_combo_list = tag_combo_list.tag_list;

var tag_combo = tag_combo_list[|1];

//Game.tags[tag_combo[0], tag_combo[1]] = Game.tags[VBO, 0];
//tag_combo = tag_combo_list[|3];
//Game.tags[tag_combo[0], tag_combo[1]] = ;

//load song

//setup animation loop

identity = create_identity([Path]);