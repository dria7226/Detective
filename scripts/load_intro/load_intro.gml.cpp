var to_delete = 0;
	//create room
var wainscoting = create_identity(["Level Building/wall_wainscoting"]);

var size = buffer_get_size(wainscoting[Model].lod[0]);

var wall_segment = buffer_create(size, buffer_grow, 1);

buffer_copy(wainscoting[Model].lod[0], 0, size, wall_segment, 0);

var wallpaper = create_identity(["Level Building/wall_deco/high"]);

add_buffer_to_buffer(wall_segment, wallpaper[Model].lod[0], [0,0,4.5]);

var bumper = create_identity(["Level Building/wall_bumper"]);

add_buffer_to_buffer(wall_segment, bumper[Model].lod[0], [0,0,0]);

size = buffer_get_size(wall_segment);

var wall = buffer_create(size, buffer_grow, 1);

buffer_copy(wall_segment, 0, size, wall, 0);

for(var i = 1; i < 3; i++)
	add_buffer_to_buffer(wall, wall_segment, [3.0*i, 0,0]);

var query = [VBO, Position, Rotation, Color, Delete_Protected];

wall = vertex_create_buffer_from_buffer(wall, Game.format);

var walls = [0,0,0,0,0,0,0,0,0,0,0];
walls[0] = [0,0,0];
walls[1] = [-3/2,-9 + 3/2,pi/2];
walls[2] = [-3/2 + 9,3/2,pi/2];
walls[3] = [-3/2,3/2 + 9,pi/2];
walls[4] = [6,-9,pi];
walls[5] = [15,-9,pi];
walls[6] = [6,9,pi];
walls[7] = [15 + 3/2,0 - 3/2,-pi/2];
walls[8] = [15 + 3/2,9 - 3/2,-pi/2];
walls[9] = [15 + 3/2,18 - 3/2,-pi/2];
walls[10] = [0,18,0];

for(var i = 0; i < array_length_1d(walls); i++)
{
	var coords = walls[i];

	identity = create_identity(query);

	identity[VBO].lod[0] = wall;

	change_position(identity, CHANGE_SET, [coords[0],coords[1], 0]);

	change_rotation(identity, CHANGE_SET, [0,0,coords[2]]);

	change_color(identity, CHANGE_SET, [0.2, 0.4, 0.2]);

	ADD_IDENTITY_TO_VISIBLES(identity)
}
walls = 0;

//doorway
boolean_volume = create_identity([Model, VBO, Position,Rotation]);

change_position(boolean_volume, CHANGE_SET, [9, 18, 0]);

to_delete = compress_model_array(create_cube([3,2,6],[0.5,0.25,0],[0xBB,0x42,0x11,255]));

boolean_volume[VBO].lod[@0] = vertex_create_buffer_from_buffer(to_delete, Game.format);
to_delete = 0;

identity = create_identity(query);

set_tags(identity, [Boolean_Group]);

identity[Boolean_Group].subtrahends = [boolean_volume];
identity[Boolean_Group].boolean_type = BOOLEAN_CUTOUT;

identity[VBO].lod[0] = wall;

change_position(identity, CHANGE_SET, [9,18,0]);

change_color(identity, CHANGE_SET, [0.2, 0.4, 0.2]);

ADD_IDENTITY_TO_VISIBLES(identity)

	//floor
identity = create_identity(["Level Building/floor"]);

size = buffer_get_size(identity[Model].lod[0]);

var Floor = buffer_create(size, buffer_grow, 1);

buffer_copy(identity[Model].lod[0], 0, size, Floor, 0);

for(var i = 1; i < 3; i++)
{
	add_buffer_to_buffer(Floor, identity[Model].lod[0], [i*3,0,0]);
}

size = buffer_get_size(Floor);

var temp = buffer_create(size, buffer_fixed, 1);
buffer_copy(Floor, 0, size, temp, 0);

for(var i = 0; i < 3; i++)
{
	add_buffer_to_buffer(Floor, temp, [0, -i*3, 0]);
}

var floor_vbo = vertex_create_buffer_from_buffer(Floor, Game.format);

var floors = [0,0,0,0,0];
floors[0] = [0,0];
floors[1] = [9,0];
floors[2] = [9,9];
floors[3] = [0,18];
floors[4] = [9,18];

for(var i = 0; i < array_length_1d(floors); i++)
{
	var coords = floors[i];

	identity = create_identity(query);

	identity[VBO].lod[@0] = floor_vbo;

	change_position(identity, CHANGE_SET, [coords[0], coords[1] - 3/2, 0])

	ADD_IDENTITY_TO_VISIBLES(identity)
}

floors = 0;

	//ceiling
//var ceiling = buffer_create(1, buffer_grow, 1);

//index = create_identity(["Level Building/ceiling.dat"]);


	//add items inside

//index = create_identity(["Objects/vinyl_player.dat", VBO]);

//index = create_identity(["Objects/vinyl.dat", VBO]);

//index = create_identity(["Objects/vinyl_highlights.dat", VBO]);

identity = create_identity(["Objects/desk_med_class"]);

var desk = identity[Model].lod[0];

identity = create_identity(query);

// set_tags(identity, [Boolean_Group]);
// identity[Boolean_Group].boolean_type = 1;
//
// identity[Boolean_Group].subtrahends = array_create(6);

var shelf_volume = compress_model_array(create_cube([2.4,1,2/3 - 0.1/3],[0,0,0],[0xBB,0x42,0x11,255]));

to_delete = shelf_volume;
shelf_volume = vertex_create_buffer_from_buffer(shelf_volume, Game.format);
to_delete = 0;

var subtrahend = 0;
for(var side = 0; side < 2; side++)
for(var z = 0; z < 2; z+=2/3)
{
	var shelf = create_identity(query);

	change_position(shelf, CHANGE_SET, [0, -2 + 4.2*side, 0.6 + z]);

	change_position(shelf, CHANGE_ADD, [-1.2, -5.6, 0]);

	shelf[VBO].lod[@0] = shelf_volume;

	//var subs = identity[Boolean_Group].subtrahends;

	//subs[@subtrahend] = shelf;

	subtrahend++;
}

identity[VBO].lod[0] = vertex_create_buffer_from_buffer(desk, Game.format);

change_position(identity, CHANGE_SET, [0, -5, 0]);

change_rotation(identity, CHANGE_SET, [0, 0, pi/2]);

ADD_IDENTITY_TO_VISIBLES(identity)

//

identity = create_identity(["Objects/office_lamp"]);

var lamp = identity[Model].lod[0];

var lamp_cutout_volume = compress_model_array(create_cube([1,1,1],[0,0,0],[1,1,1,255]));

to_delete = lamp_cutout_volume;
lamp_cutout_volume = vertex_create_buffer_from_buffer(lamp_cutout_volume ,Game.format);
to_delete = 0;

identity = create_identity(query);

//set_tags(identity, [Boolean_Group]);

var lamp_cutout = create_identity(query);

lamp_cutout[VBO].lod[0] = lamp_cutout_volume;

change_position(lamp_cutout, CHANGE_ADD, [-0.5, -6.5, 3]);

//identity[Boolean_Group].subtrahends = [lamp_cutout];
//identity[Boolean_Group].fill_in = 1;

identity[VBO].lod[0] = vertex_create_buffer_from_buffer(lamp, Game.format);

change_position(identity, CHANGE_SET, [-0.5, -6.5, 3]);
change_color(identity, CHANGE_SET, [1.0,0.9,0.75]);
change_rotation(identity, CHANGE_SET, [0,0,3*pi/4]);

ADD_IDENTITY_TO_VISIBLES(identity)

//

identity = create_identity(["Objects/typewriter"]);

var lamp = identity[Model].lod[0];

identity = create_identity(query);

identity[VBO].lod[0] = vertex_create_buffer_from_buffer(lamp, Game.format);

change_position(identity, CHANGE_SET, [5/8, -7.5, .6]);

ADD_IDENTITY_TO_VISIBLES(identity)

//load occlusion groups

//query = [Occlusion_Group, VBO, Position, Scale];
//index = create_identity(query);

//index[1] = Game.tags[VBO, 0];

//load song

//setup animation loop

//index = create_identity([Path]);

#ifdef SHOW_USE
//uses_identities, uses_position_tag, uses_rotation_tag, uses_color_tag, uses_grayscale_tag, uses_vbo_tag, uses_model_tag
#endif
