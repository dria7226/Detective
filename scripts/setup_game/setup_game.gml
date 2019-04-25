
setup_tags();
identities = ds_list_create();

//
var cube = create_identity(["cube", VBO]);

cube[VBO].lod[0] = vertex_create_buffer_from_buffer(cube[Model].lod[0] , Game.format);
//
var plane = create_identity(["plane", VBO]);

plane[VBO].lod[0] = vertex_create_buffer_from_buffer(plane[Model].lod[0] , Game.format);
//

alpha = 0;

load_main_camera();

//load_intro();
var test = create_identity(["Objects/office_lamp", VBO]);
test[VBO].lod[0] = vertex_create_buffer_from_buffer(test[Model].lod[0], Game.format);
for(var i = 0; i < 10; i++)
{
    for(var j = 0; j < 10; j++)
    {
        var identity = create_identity([VBO, Position]);
        identity[VBO].lod[0] = test[VBO].lod[0];
        change_position(identity, 0, [i,j,6]);
        visibles[array_length_1d(visibles)] = identity;
    }
}
previous_x = 0; previous_y = 0; speed = 3;
//completely load hub
//load_hub();
//move camera from vinyl to character
//load common identities in module pool
//load_common();
