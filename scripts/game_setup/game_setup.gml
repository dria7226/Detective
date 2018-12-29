initialize_tags();

identities = ds_list_create();

visibles = array_create(0);

//
var cube = create_identity(["cube.dat", VBO]);

var model = tags[|Model];

var vbo = tags[|VBO];

vbo[|cube[1]] = vertex_create_buffer_from_buffer(model[|cube[0]] , Game.format);
//
var plane = create_identity(["plane.dat", VBO]);

vbo = tags[|VBO];

vbo[|plane[1]] = vertex_create_buffer_from_buffer(model[|plane[0]] , Game.format);
//

alpha = 0;

load_main_camera();

//load_intro();
var other_plane = create_identity(["Level Building/floor.dat", VBO]);
var scene = buffer_create(buffer_get_size(model[|other_plane[0]]), buffer_grow, 1);
buffer_copy(model[|other_plane[0]], 0, buffer_get_size(model[|other_plane[0]]), scene, 0);
for(var i = 0; i < 10; i++)
    add_buffer_to_buffer(scene, model[|other_plane[0]], [0,0,i+1]);
vbo[|other_plane[1]] = vertex_create_buffer_from_buffer(scene, Game.format);
visibles[array_length_1d(visibles)] = other_plane[2];
//completely load main menu
//load_main_menu();
//move camera from vinyl to typewriter
//load common identities in module pool
//load_common();
