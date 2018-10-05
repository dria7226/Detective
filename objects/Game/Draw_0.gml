var camera_tag = tags[|Camera]; camera_tag = camera_tag[|0];
SET_UNIFORM_F("near_clip", camera_tag.near_clip)

var position = tags[|Position]; position = position[|0];
var rotation = tags[|Rotation]; rotation = rotation[|0];

SET_UNIFORM_F("camera_position", position.X, position.Y, position.Z)
SET_UNIFORM_F("camera_angle", rotation.roll, rotation.pitch, rotation.yaw+alpha)
visible_models = 0;
//iterate down hierarchy
  //#include "frustrum_test.txt"
if(occlusion_culling_enabled)
{
SET_UNIFORM_I("vertex_mode", 3);
SET_UNIFORM_I("fragment_mode", 0);
surface_set_target(occlusion);
draw_clear(c_white);
SET_UNIFORM_F("scale", 0.62408,0.5436,0.62796);
//draw bounding volumes
for(var i = 0; i < array_size*array_size; i++)
{
  var position = model_array[i];
  SET_UNIFORM_F("offset", position[0], position[1], position[2] + 0.62796);
  SET_UNIFORM_F("id", i%256/255, floor(i/256)%256/255, floor(i/(256*256))/255);
  vertex_submit(cube, pr_trianglelist, -1);
}
surface_reset_target();
//post processing
surface_set_target(occlusion_first_pass);
draw_clear(c_white);
SET_UNIFORM_I("vertex_mode", 1);
SET_UNIFORM_I("fragment_mode", 3);
draw_surface(occlusion, 0, 0);
surface_reset_target();
surface_set_target(occlusion_second_pass);
draw_clear(c_white);
SET_UNIFORM_I("fragment_mode", 4);
draw_surface(occlusion_first_pass, 0, 0);
surface_reset_target();
//read surface and build visible array
var occlusion_buffer = buffer_create(surface_get_width(occlusion)*surface_get_height(occlusion)*4, buffer_grow, 1);
buffer_get_surface(occlusion_buffer, occlusion_second_pass, 0, 0, 0); //formatted as BGRA
var occlusion_buffer_size = buffer_get_size(occlusion_buffer)/4;
//refresh visibles
for(var i = 0; i < occlusion_buffer_size; i++)
{
  var visible_index = [0,0,0];
  visible_index[2] = buffer_read(occlusion_buffer, buffer_u8);
  visible_index[1] = buffer_read(occlusion_buffer, buffer_u8);
  visible_index[0] = buffer_read(occlusion_buffer, buffer_u8); //formatted as BGRA
  buffer_read(occlusion_buffer, buffer_u8);
  //show_debug_message("r: " + string(visible_index[2]) + ", g: " + string(visible_index[1]) + ", b: " + string(visible_index[0]));
  if( visible_index[0] == 255 &&
    visible_index[1] == 255 &&
    visible_index[2] == 255)
    break;
  else
  {
    //decode visible index
    visible_models[i] = visible_index[2] + visible_index[1]*256 + visible_index[0]*256*256;
  }

  //show_debug_message(string(i) + " : " + string(visible_models[i]));
}
}
else
{
 for(var i = 0; i < array_size*array_size; i++) visible_models[i] = i;
}
ITERATE_VISIBLES
{
surface_set_target(DIFFUSE_SURFACE);
draw_clear(c_white);
SET_UNIFORM_I("vertex_mode", VERTEX_REGULAR)
SET_UNIFORM_I("fragment_mode", FRAGMENT_REGULAR)
//SET_UNIFORM_F("camera_offset", -25, 0, 10);
//SET_UNIFORM_F("camera_angle", 0, -pi/4, 0);
SET_UNIFORM_F("scale", 1.0, 1.0, 1.0)
SET_UNIFORM_F("grayscale", 1.0)
SET_UNIFORM_F("color", 0.2, 0.6, 0.2)
for(var i = 0; i < array_length_1d(visible_models); i++)
{
 var position = visible_models[i];
 if(position != -1)
 {
  position = model_array[position];
  SET_UNIFORM_F("offset", position[0], position[1], position[2])
  SET_UNIFORM_F("id",i%256/255, floor(i/256)%256/255, floor(i/(256*256))/255)
  vertex_submit(model, pr_trianglelist, texture);
 }
}
surface_reset_target();
surface_set_target(surfaces[PLAYER_ONE]);
draw_surface(DIFFUSE_SURFACE, 0,0);
surface_reset_target();
}
if(IS_SPLITSCREEN)
{
  ITERATE_VISIBLES
  {
surface_set_target(DIFFUSE_SURFACE);
draw_clear(c_white);
SET_UNIFORM_I("vertex_mode", VERTEX_REGULAR)
SET_UNIFORM_I("fragment_mode", FRAGMENT_REGULAR)
//SET_UNIFORM_F("camera_offset", -25, 0, 10);
//SET_UNIFORM_F("camera_angle", 0, -pi/4, 0);
SET_UNIFORM_F("scale", 1.0, 1.0, 1.0)
SET_UNIFORM_F("grayscale", 1.0)
SET_UNIFORM_F("color", 0.2, 0.6, 0.2)
for(var i = 0; i < array_length_1d(visible_models); i++)
{
 var position = visible_models[i];
 if(position != -1)
 {
  position = model_array[position];
  SET_UNIFORM_F("offset", position[0], position[1], position[2])
  SET_UNIFORM_F("id",i%256/255, floor(i/256)%256/255, floor(i/(256*256))/255)
  vertex_submit(model, pr_trianglelist, texture);
 }
}
surface_reset_target();
surface_set_target(surfaces[PLAYER_TWO]);
draw_surface(DIFFUSE_SURFACE, 0,0);
surface_reset_target();
  }
}
SET_UNIFORM_I("vertex_mode", VERTEX_FLAT);
SET_UNIFORM_I("fragment_mode", FRAGMENT_FLAT);
if(IS_SPLITSCREEN)
{
  draw_surface_part(surfaces[PLAYER_ONE],);
  draw_surface_part(surface[PLAYER_TWO],);
}
else
  draw_surface(surfaces[PLAYER_ONE], 0, 0);
