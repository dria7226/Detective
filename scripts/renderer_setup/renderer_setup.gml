Game.format_size = 0;
vertex_format_begin();
vertex_format_add_position_3d(); Game.format_size += 3;
vertex_format_add_color(); Game.format_size += 4;
Game.format = vertex_format_end();

gpu_set_blendenable(false);

#macro OCCLUSION 8
#macro DIFFUSE 0
#macro DEPTH 1
#macro NORMAL 2
#macro EDGE 3
#macro SHADOW 4
#macro BLACK 5
#macro GRAY 6
#macro RGB 7
#macro NO_OF_SURFACES 9

#macro OCCLUSION_RATIO 1/10

for(var i = 0; i < NO_OF_SURFACES; i++)
{
	if(i == OCCLUSION)
	Game.surfaces[i] = surface_create(window_get_width()*OCCLUSION_RATIO, window_get_height()*OCCLUSION_RATIO);
	else
	Game.surfaces[i] = surface_create(window_get_width(), window_get_height());
}
