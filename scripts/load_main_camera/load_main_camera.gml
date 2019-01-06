//load main camera
var query = [Camera, Position, Rotation, "Objects/movie_camera.dat", VBO];

var index = create_identity(query);

var vbo = Game.tags[|query[4]]; vbo = vbo[|index[4]];
var model = Game.tags[|Model]; model = model[|index[3]];
export_model_to_stl(model, "camera.stl");
vbo = vertex_create_buffer_from_buffer(model, Game.format);

var test_buffer = buffer_create(buffer_get_size(model), buffer_fixed, 1);
buffer_copy_from_vertex_buffer(vbo, 0, vertex_get_number(vbo) - 1, test_buffer, 0);
export_model_to_stl(test_buffer, "camera_after.stl");

var position = Game.tags[|query[1]]; position = position[|index[1]];
position.X = 4.5;
position.Y = -9.0;
position.Z = 5.5;
