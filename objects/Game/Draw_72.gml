<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
shader_set_uniform_i(shader_get_uniform(standard, "vertex_mode"), 1);
shader_set_uniform_i(shader_get_uniform(standard, "fragment_mode"), 1);
for(var i = 0; i < 9; i++)
{
 if(!surface_exists(surfaces[i]))
 {
  if(i == 0)
  {
   surfaces[i] = surface_create(10.0*6, 10.0);
   buffer_set_surface(uniform_buffer, surfaces[0], 0,0,0);
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
buffer_set_surface(uniform_buffer, surfaces[0], 0,0,0);
