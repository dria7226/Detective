initialize_tags();

Game.identities = ds_list_create();

var occlusion_cube = create_identity(["cube.dat", VBO]);

var model = Game.tags[Model, occlusion_cube];

Game.test_vbo = vertex_create_buffer_from_buffer(model.buffer, Game.format);

Game.tags[VBO, 0] = vertex_create_buffer_from_buffer(model.buffer, Game.format);

load_intro();

//completely load main menu
//load_main_menu();

//move camera from vinyl to typewriter


//load common identities in module pool
//load_common();