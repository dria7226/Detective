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

load_intro();

//completely load main menu
//load_main_menu();

//move camera from vinyl to typewriter


//load common identities in module pool
//load_common();
