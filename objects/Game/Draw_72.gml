
shader_set_uniform_i(shader_get_uniform(standard, "vertex_mode"), 1);
shader_set_uniform_i(shader_get_uniform(standard, "fragment_mode"), 1);
for(var i = 0; i < 9; i++)
{
 if(!surface_exists(surfaces[i]))
 {
  if(i == 0)
  {
   surfaces[i] = surface_create(10.0*3, 10.0*3);
   surface_set_target(surfaces[i]);
   draw_clear(c_white);
   shader_set_uniform_i(shader_get_uniform(standard, "fragment_mode"), 6);

   var total_statics = ds_list_size(tags[|Static]);
   for(var i = 0; i < total_statics; i++)
   {
    update_static(i);
   }

   shader_set_uniform_i(shader_get_uniform(standard, "fragment_mode"), 1);
   surface_reset_target();
  }
  else
  {
   var scale = surface_info[i];
   surfaces[i] = surface_create(floor(scale[0]*window_get_width()), floor(scale[1]*window_get_height()));
  }

    //cache texture pointers for the surfaces
  surface_texture_pointers[i] = surface_get_texture(surfaces[i]);
 }

 if(i == 0)
  continue;

 surface_set_target(surfaces[i]);
 draw_clear(c_white);
 surface_reset_target();
}
var statics = tags[|Static];
var total_statics = ds_list_size(statics);
var total_new_statics = ds_list_size(new_statics);
surface_set_target(surfaces[0]);
shader_set_uniform_i(shader_get_uniform(standard, "vertex_mode"), 1);
shader_set_uniform_i(shader_get_uniform(standard, "fragment_mode"), 6);
var next_candidate = 0;
for(var i = 0; i < total_new_statics; i++)
{
    var to_be_added = new_statics[|i];
    var j = next_candidate;
    for(; j < total_statics; j++)
    {
        if(statics[|j] != -1)
            statics[|j] = to_be_added[0];
        else
            continue;
        break;
    }
    if(j == total_statics)
    {
        ds_list_add(statics, to_be_added[0]);
        total_statics++;
    }
    var tag_combo = to_be_added[1];
    tag_combo[1] = j;
    next_candidate = j+1;
    update_static(j);
}
surface_reset_target();
ds_list_clear(new_statics);
alpha += delta_time/5000000;
var rotation = tags[|Rotation]; rotation = rotation[|0];
rotation.yaw += (previous_x - mouse_x)/(delta_time/1000000)/4000;
rotation.pitch += (previous_y - mouse_y)/(delta_time/1000000)/4000;
if(rotation.pitch > 3.1415926535897932384626433832795/2) rotation.pitch = 3.1415926535897932384626433832795/2;
if(rotation.pitch < -3.1415926535897932384626433832795/2) rotation.pitch = -3.1415926535897932384626433832795/2;
//var index = tags[|Rotation]; index = index[|6];
//index.yaw = alpha*2;
