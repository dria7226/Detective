
var camera = Game.tags[Camera]; camera = camera[|0].back_reference;
var position = camera[Position];
shader_set_uniform_f(shader_get_uniform(standard, "camera_position"), position.coordinates[X], position.coordinates[Y], position.coordinates[Z]);
var rotation = camera[Rotation];
shader_set_uniform_f(shader_get_uniform(standard, "camera_angle"), rotation.angle[ROLL], rotation.angle[PITCH], rotation.angle[YAW]);


//#include "visibility_culling.c"
//#include "mirrors.c"
surface_set_target(surfaces[1]);
shader_set_uniform_i(shader_get_uniform(standard, "vertex_mode"), 0);
shader_set_uniform_i(shader_get_uniform(standard, "fragment_mode"), 0);
texture_set_stage(uniform_sampler, surface_texture_pointers[0]);
var no_of_visibles = array_length_1d(visibles); for(var i = 0; i < no_of_visibles; i++)
{
//NOTES
//- account for mirrors
//- account for animations
var identity = visibles[i];
shader_set_uniform_f(shader_get_uniform(standard, "id"), identity[INDEX]%256/255, floor(identity[INDEX]/256)%256/255, floor(identity[INDEX]/(256*256))/255);
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
shader_set_uniform_i(shader_get_uniform(standard, "fragment_mode"), 6);
surface_set_target(surfaces[5]);
draw_rectangle(0,0, 3,3,false);
surface_reset_target();
shader_set_uniform_i(shader_get_uniform(standard, "fragment_mode"), 1);
//if(IS_SPLITSCREEN)
//{
//  draw_surface_part(surfaces[PLAYER_ONE],0,0,window_width*SPLITSCREEN_HORIZONTAL_RATIO, window_height/2, window_width*(1-SPLITSCREEN_HORIZONTAL_RATIO), 0);
//  draw_surface_part(surface[PLAYER_TWO],0,0, window_width*SPLITSCREEN_HORIZONTAL_RATIO, window_height/2, 0, window_height/2);
//}
//else
    draw_surface(surfaces[5],0,0);
