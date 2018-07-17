initialize_tags();

Game.identities = ds_list_create();

//
var cube = create_identity(["cube.dat", VBO]);

var vbo = Game.tags[|VBO];

vbo[|0] = vertex_create_buffer_from_buffer(cube[0] , Game.format);
//
var plane = create_identity(["plane.dat", VBO]);

vbo = Game.tags[|VBO];

vbo[|1] = vertex_create_buffer_from_buffer(plane[0] , Game.format);
//

Game.alpha = 0;

load_intro();

//completely load main menu
//load_main_menu();

//move camera from vinyl to typewriter


//load common identities in module pool
//load_common();