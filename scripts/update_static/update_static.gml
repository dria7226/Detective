
//updated_static(index)
var statics = tags[|Static];

var query = [Position, Rotation, Scale, Color, Grayscale, VBO];

var index = search_tags(statics[|argument0], query);

if(index[0] != -1)
{
  var id_tag = tags[|query[0]]; id_tag = id_tag[|index[0]];
  shader_set_uniform_f("pass_offset", id_tag.X, id_tag.Y, id_tag.Z);
}
else
  shader_set_uniform_f("pass_offset", 0,0,0);

if(index[1] != -1)
{
  id_tag = tags[|query[1]]; id_tag = id_tag[|index[1]];
  shader_set_uniform_f("pass_angle", id_tag.roll, id_tag.pitch, id_tag.yaw);
}
else
  shader_set_uniform_f("pass_angle", 0,0,0);

if(index[2] != -1)
{
  id_tag = tags[|query[2]]; id_tag = id_tag[|index[2]];
  shader_set_uniform_f("pass_scale", id_tag.X, id_tag.Y, id_tag.Z);
}
else
  shader_set_uniform_f("pass_scale", 1,1,1);

if(index[3] != -1)
{
  id_tag = tags[|query[3]]; id_tag = id_tag[|index[3]];
  shader_set_uniform_f("color", id_tag.R, id_tag.G, id_tag.B);
}
else
  shader_set_uniform_f("color", 0,0,0);


if(index[4] != -1)
{
    id_tag = tags[|query[4]];
    shader_set_uniform_f("grayscale", id_tag[|index[4]]);
}
else
    shader_set_uniform_f("grayscale", 1.0);

//draw to uniform buffer

var X = argument0%UNIFORM_BUFFER_WIDTH;
var Y = (argument0 - X)/UNIFORM_BUFFER_WIDTH;
X *= 3; Y *= 3;

//in pixels
draw_rectangle(X, Y, X+2, Y+2, false);
