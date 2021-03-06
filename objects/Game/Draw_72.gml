
shader_set_uniform_i(vertex_mode, 1);
shader_set_uniform_i(fragment_mode, 1);
for(var i = 0; i < 10; i++)
{
 if(!surface_exists(surfaces[i]))
 {
   var scale = surface_info[i];
   surfaces[i] = surface_create(floor(scale[0]*window_get_width()), floor(scale[1]*window_get_height()));
    //cache texture pointers for the surfaces
  surface_texture_pointers[i] = surface_get_texture(surfaces[i]);
 }
 surface_set_target(surfaces[i]);
 draw_clear(c_black);
 surface_reset_target();
}
