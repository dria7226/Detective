//load main camera
var query = [Camera, Position, Rotation, "Objects/movie_camera.dat", VBO];

var index = create_identity(query);

var vbo = Game.tags[|query[4]]; vbo = vbo[|index[4]];
var model = Game.tags[|Model]; model = model[|index[3]];
vbo = vertex_create_buffer_from_buffer(model, Game.format);

var position = Game.tags[|query[1]]; position = position[|index[1]];
position.X = 4.5;
position.Y = -9.0;
position.Z = 5.5;
