var position = tags[|Position]; position = position[|0];
shader_set_uniform_f(shader_get_uniform(standard, "camera_position"), position.X, position.Y, position.Z);
var rotation = tags[|Rotation]; rotation = rotation[|0];
shader_set_uniform_f(shader_get_uniform(standard, "camera_angle"), rotation.roll, rotation.pitch, rotation.yaw);


//#include "visibility_culling.txt"
//#include "mirrors.txt"
for(var i = 0; i < array_length_1d(visibles); i++)
{
surface_set_target(surfaces[0]);
//NOTES
//account for animation as well
//account for mirrors
shader_set_uniform_i(shader_get_uniform(standard, "vertex_mode"), 0);
shader_set_uniform_i(shader_get_uniform(standard, "fragment_mode"), 0);
var query = [Position, Rotation, Scale, Color, VBO];
var index = search_tags(visibles[i], query);
if(index[0] != -1)
{
  var id_tag = tags[|query[0]]; id_tag = id_tag[|index[0]];
  shader_set_uniform_f(shader_get_uniform(standard, "offset"), id_tag.X, id_tag.Y, id_tag.Z);
}
else
  shader_set_uniform_f(shader_get_uniform(standard, "offset"), 0,0,0);
if(index[1] != -1)
{
  id_tag = tags[|query[1]]; id_tag = id_tag[|index[1]];
  shader_set_uniform_f(shader_get_uniform(standard, "angle"), id_tag.roll, id_tag.pitch, id_tag.yaw);
}
else
  shader_set_uniform_f(shader_get_uniform(standard, "angle"), 0,0,0);
if(index[2] != -1)
{
  id_tag = tags[|query[2]]; id_tag = id_tag[|index[2]];
  shader_set_uniform_f(shader_get_uniform(standard, "scale"), id_tag.X, id_tag.Y, id_tag.Z);
}
else
  shader_set_uniform_f(shader_get_uniform(standard, "scale"), 1,1,1);
shader_set_uniform_f(shader_get_uniform(standard, "grayscale"), 1.0);
if(index[3] != -1)
{
  id_tag = tags[|query[3]]; id_tag = id_tag[|index[3]];
  shader_set_uniform_f(shader_get_uniform(standard, "color"), id_tag.R, id_tag.G, id_tag.B);
}
else
  shader_set_uniform_f(shader_get_uniform(standard, "color"), 0,0,0);
if(index[4] != -1)
{
  id_tag = tags[|query[4]];
  vertex_submit(id_tag[|index[4]], pr_trianglelist, 0);
}
//if(index[0] == -1 || index[1] == -1) continue;
//SET_UNIFORM_F("id", PACK_32_BITS(index[0]))

//#include "pick_and_render_lod.txt"

surface_reset_target();
//#include "edge.txt"
//#include "collect_lights.txt"
//non-shadow lights (deferred omni-lights)
//#include "lighting.txt"
//shadow lights (shadow mapped spotlights)
//#include "shadowing.txt"
//#include "post_processing.txt"
shader_set_uniform_i(shader_get_uniform(standard, "vertex_mode"), 1);
shader_set_uniform_i(shader_get_uniform(standard, "fragment_mode"), 1);
surface_set_target(surfaces[6]);
var scale = surface_info[0];
draw_surface_ext(surfaces[0],0,0, 1/scale[0], 1/scale[1],0,c_white,1.0);
surface_reset_target();
}
//if(IS_SPLITSCREEN)
//{
//  #define FINAL_SURFACE surfaces[PLAYER_TWO]
  //#include "visibility_culling.txt"
  //#include "mirrors.txt"
//  ITERATE_VISIBLES
//  {
//    #include "render_scene.txt"
//  }
//}
shader_set_uniform_i(shader_get_uniform(standard, "vertex_mode"), 1);
shader_set_uniform_i(shader_get_uniform(standard, "fragment_mode"), 1);
//if(IS_SPLITSCREEN)
//{
//  draw_surface_part(surfaces[PLAYER_ONE],0,0,window_width*SPLITSCREEN_HORIZONTAL_RATIO, window_height/2, window_width*(1-SPLITSCREEN_HORIZONTAL_RATIO), 0);
//  draw_surface_part(surface[PLAYER_TWO],0,0, window_width*SPLITSCREEN_HORIZONTAL_RATIO, window_height/2, 0, window_height/2);
//}
//else
    draw_surface(surfaces[6],0,0);
