initialize_tags();

Game.identities = ds_list_create();

var occlusion_cube = create_identity(["cube.dat", VBO]);

Game.tags[VBO, 0] = vertex_create_buffer_from_buffer(occlusion_cube[0] , Game.format);

Game.alpha = 0;

load_intro();

//completely load main menu
//load_main_menu();

//move camera from vinyl to typewriter


//load common identities in module pool
//load_common();