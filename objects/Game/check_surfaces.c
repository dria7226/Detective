SET_UNIFORM_I("vertex_mode", VERTEX_FLAT)
SET_UNIFORM_I("fragment_mode", FRAGMENT_FLAT)
for(var i = 0; i < NO_OF_SURFACES; i++)
{
	if(!surface_exists(surfaces[i]))
	{
		if(i == UNIFORM_BUFFER)
		{
			surfaces[i] = surface_create(UNIFORM_BUFFER_WIDTH*6, UNIFORM_BUFFER_WIDTH);

			buffer_set_surface(uniform_buffer, surfaces[UNIFORM_BUFFER], 0,0,0);
		}
		else
		{
			var scale = surface_info[i];
			surfaces[i] = surface_create(floor(scale[0]*window_get_width()), floor(scale[1]*window_get_height()));
		}

	  //cache texture pointers for the surfaces
		surface_texture_pointers[i] = surface_get_texture(surfaces[i]);
	}

	if(i == UNIFORM_BUFFER)
		continue;

	surface_set_target(surfaces[i]);
	draw_clear(c_black);
	surface_reset_target();
}

#ifdef SHOW_USE
//uses_uniform_buffer
#endif
