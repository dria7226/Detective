//check surfaces and clear them
SET_UNIFORM_I("vertex_mode", VERTEX_FLAT)
SET_UNIFORM_I("fragment_mode", FRAGMENT_FLAT)
for(var i = 0; i < NO_OF_SURFACES; i++)
{
	if(!surface_exists(surfaces[i]))
	{
		var scale = surface_info[i];
		surfaces[i] = surface_create(floor(scale[0]*window_get_width()), floor(scale[1]*window_get_height()));

	  //cache texture pointers for the surfaces
		surface_texture_pointers[i] = surface_get_texture(surfaces[i]);
	}

	surface_set_target(surfaces[i]);
	draw_clear(c_white);
	surface_reset_target();
}

alpha += delta_time/5000000;
