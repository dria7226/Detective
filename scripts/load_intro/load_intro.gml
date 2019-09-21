
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
walls[1] = [-3/2,-9 + 3/2,3.1415926535897932384626433832795/2];
walls[2] = [-3/2 + 9,3/2,3.1415926535897932384626433832795/2];
walls[3] = [-3/2,3/2 + 9,3.1415926535897932384626433832795/2];
walls[4] = [6,-9,3.1415926535897932384626433832795];
walls[5] = [15,-9,3.1415926535897932384626433832795];
walls[6] = [6,9,3.1415926535897932384626433832795];
walls[7] = [15 + 3/2,0 - 3/2,-3.1415926535897932384626433832795/2];
walls[8] = [15 + 3/2,9 - 3/2,-3.1415926535897932384626433832795/2];
walls[9] = [15 + 3/2,18 - 3/2,-3.1415926535897932384626433832795/2];
walls[10] = [0,18,0];

for(var i = 0; i < array_length_1d(walls); i++)
{
 var coords = walls[i];

 identity = create_identity(query);

 identity[VBO].lod[0] = wall;

 change_position(identity, 0, [coords[0],coords[1], 0]);

 change_rotation(identity, 0, [0,0,coords[2]]);

 change_color(identity, 0, [0.2, 0.4, 0.2]);

 visibles[array_length_1d(visibles)] = identity;
}
walls = 0;

//doorway
identity = create_identity(query);

identity[VBO].lod[0] = vertex_create_buffer_from_buffer(wall_segment, Game.format);

change_position(identity, 0, [9,18,0]);

change_color(identity, 0, [0.2, 0.4, 0.2]);

visibles[array_length_1d(visibles)] = identity;

identity = create_identity(query);

identity[VBO].lod[0] = vertex_create_buffer_from_buffer(wall_segment, Game.format);

change_position(identity, 0, [15,18,0]);

change_color(identity, 0, [0.2, 0.4, 0.2]);

visibles[array_length_1d(visibles)] = identity;

buffer_delete(wall_segment);

identity = create_identity(["Level Building/doorway"]);

var doorway = identity[Model].lod[0];

identity = create_identity(query);

identity[VBO].lod[0] = vertex_create_buffer_from_buffer(doorway, Game.format);

change_position(identity, 0, [12, 18, 0]);

visibles[array_length_1d(visibles)] = identity;

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

 identity[VBO].lod[0] = floor_vbo;

 change_position(identity, 0, [coords[0], coords[1] - 3/2, 0])

 visibles[array_length_1d(visibles)] = identity;
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

identity[VBO].lod[0] = vertex_create_buffer_from_buffer(desk, Game.format);

change_position(identity, 0, [0, -5, 0]);

change_rotation(identity, 0, [0, 0, 3.1415926535897932384626433832795/2]);

visibles[array_length_1d(visibles)] = identity;

//

identity = create_identity(["Objects/office_lamp"]);

var lamp = identity[Model].lod[0];

identity = create_identity(query);

identity[VBO].lod[0] = vertex_create_buffer_from_buffer(lamp, Game.format);

change_position(identity, 0, [6.5, 1.5, 3]);
change_color(identity, 0, [1.0,0.9,0.75]);
change_rotation(identity, 0, [0,0,-3.1415926535897932384626433832795/4]);

visibles[array_length_1d(visibles)] = identity;

//load occlusion groups

//query = [Occlusion_Group, VBO, Position, Scale];
//index = create_identity(query);

//index[1] = Game.tags[VBO, 0];

//load song

//setup animation loop

//index = create_identity([Path]);
