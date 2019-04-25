
var identity = Game.tags[Camera]; identity = identity[|0].back_reference;
shader_set_uniform_f(shader_get_uniform(standard, "camera_id"), identity[Cached_ID].cache[0], identity[Cached_ID].cache[1], identity[Cached_ID].cache[2], identity[Cached_ID].cache[3]);



//#include "visibility_culling.c"
//#include "mirrors.c"
surface_set_target(surfaces[1]);
shader_set_uniform_i(shader_get_uniform(standard, "vertex_mode"), 0);
shader_set_uniform_i(shader_get_uniform(standard, "fragment_mode"), 0);
var no_of_visibles = array_length_1d(visibles); for(var i = 0; i < no_of_visibles; i++)
{
//NOTES
//- account for mirrors
//- account for animations
identity = visibles[i];
if(identity[Cached_ID] == -1) continue;
shader_set_uniform_f(shader_get_uniform(standard, "id"), identity[Cached_ID].cache[0], identity[Cached_ID].cache[1], identity[Cached_ID].cache[2], identity[Cached_ID].cache[3]);
if(identity[VBO] != -1)
{
    var lod_index = 0;
    //lod_index = (visibles.distance[i] + Options.lod_offset)/MAX_DISTANCE*2);
    vertex_submit(identity[VBO].lod[lod_index], pr_trianglelist, 0);
}
}
surface_reset_target();
//#include "edge.c"
//#include "collect_lights.c"
//non-shadow lights (deferred omni-lights)
//#include "lighting.c"
//shadow lights (shadow mapped spotlights)
//#include "shadowing.c"
//#include "post_processing.c"
shader_set_uniform_i(shader_get_uniform(standard, "vertex_mode"), 1);
shader_set_uniform_i(shader_get_uniform(standard, "fragment_mode"), 1);
surface_set_target(surfaces[5]);
var scale = surface_info[1];
draw_surface_ext(surfaces[1],0,0, 1/scale[0], 1/scale[1],0,c_white,1.0);
surface_reset_target();
//if(IS_SPLITSCREEN)
//{
//  #define FINAL_SURFACE surfaces[PLAYER_TWO]
  //#include "visibility_culling.c"
  //#include "mirrors.c"
  //#include "render_scene.c"
//}
shader_set_uniform_i(shader_get_uniform(standard, "vertex_mode"), 1);
shader_set_uniform_i(shader_get_uniform(standard, "fragment_mode"), 1);
//if(IS_SPLITSCREEN)
//{
//  draw_surface_part(surfaces[PLAYER_ONE],0,0,window_width*SPLITSCREEN_HORIZONTAL_RATIO, window_height/2, window_width*(1-SPLITSCREEN_HORIZONTAL_RATIO), 0);
//  draw_surface_part(surface[PLAYER_TWO],0,0, window_width*SPLITSCREEN_HORIZONTAL_RATIO, window_height/2, 0, window_height/2);
//}
//else
    draw_surface(surfaces[5],0,0);
