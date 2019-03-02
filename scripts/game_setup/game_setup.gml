
initialize_tags();
identities = ds_list_create();

changed_identities = ds_list_create(); //changed uniforms

//
var cube = create_identity(["cube", VBO]);

cube[VBO].lod[0] = vertex_create_buffer_from_buffer(cube[Model].lod[0] , Game.format);
//
var plane = create_identity(["plane", VBO]);

plane[VBO].lod[0] = vertex_create_buffer_from_buffer(plane[Model].lod[0] , Game.format);
//

alpha = 0;

load_main_camera();

load_intro();

previous_x = 0; previous_y = 0; speed = 3;

// #include "simple_test_scene.txt"

//completely load hub
//load_hub();

//move camera from vinyl to character


//load common identities in module pool
//load_common();
