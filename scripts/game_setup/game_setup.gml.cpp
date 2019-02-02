initialize_tags();

identities = ds_list_create();

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

load_intro();

// #include "simple_test_scene.txt"

//completely load hub
//load_hub();

//move camera from vinyl to character


//load common identities in module pool
//load_common();
