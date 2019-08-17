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

buffer_delete(wall_segment);

var query = [VBO, Position, Rotation, Color, Grayscale, Delete_Protected];

var identity = create_identity(query);

wall = vertex_create_buffer_from_buffer(wall, Game.format);

identity[VBO].lod[0] = wall;

change_color(identity, CHANGE_SET, [0.2, 0.4, 0.2]);

ADD_IDENTITY_TO_VISIBLES(identity)

//
identity = create_identity(query);

identity[VBO].lod[0] = wall;

change_position(identity, CHANGE_SET, [3*3, 0, 0]);

change_color(identity, CHANGE_SET, [0.2, 0.4, 0.2]);

change_grayscale(identity, CHANGE_SET, 0.1);

ADD_IDENTITY_TO_VISIBLES(identity)

//
identity = create_identity(query);

identity[VBO].lod[0] = wall;

change_position(identity, CHANGE_SET, [-3/2, -3*3 + 3/2, 0]);

change_rotation(identity, CHANGE_SET, [0, 0, pi/2]);

change_color(identity, CHANGE_SET, [1.0, 1.0, 0.9]);

change_grayscale(identity, CHANGE_SET, 0.0);

test_var = identity;

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

identity = create_identity(query);

var floor_vbo = vertex_create_buffer_from_buffer(Floor, Game.format);

identity[VBO].lod[0] = floor_vbo;

change_position(identity, CHANGE_SET, [0, -3/2, 0])

ADD_IDENTITY_TO_VISIBLES(identity)

identity = create_identity(query);

identity[VBO].lod[0] = floor_vbo;

change_position(identity, CHANGE_SET, [3*3, -3/2, 0]);

ADD_IDENTITY_TO_VISIBLES(identity)

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

identity[VBO].lod[0] = vertex_create_buffer_from_buffer(desk, Game.format);

change_position(identity, CHANGE_SET, [3, -3/2, 0]);

ADD_IDENTITY_TO_VISIBLES(identity)

//

identity = create_identity(["Objects/office_lamp"]);

var lamp = identity[Model].lod[0];

identity = create_identity(query);

identity[VBO].lod[0] = vertex_create_buffer_from_buffer(lamp, Game.format);

change_position(identity, CHANGE_SET, [2.5, -3/2, 3]);
change_grayscale(identity, CHANGE_SET, 1.0);

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
