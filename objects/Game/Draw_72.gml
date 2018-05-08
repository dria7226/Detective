//check surfaces
for(var i = 0; i < NO_OF_SURFACES; i++)
{
	if(!surface_exists(surfaces[i]))
	{
		if(i == OCCLUSION)
		surfaces[i] = surface_create(window_get_width()*OCCLUSION_RATIO, window_get_height()*OCCLUSION_RATIO);
		else
		surfaces[i] = surface_create(window_get_width(), window_get_height());
	}
}