
var identity = Game.tags[Camera]; identity = identity[|0].back_reference;
var position = identity[Position];
shader_set_uniform_f(in_camera_position, position.coordinates[X], position.coordinates[Y], position.coordinates[Z]);
var rotation = identity[Rotation];
shader_set_uniform_f(in_camera_angle, rotation.axes[ROLL], rotation.axes[PITCH], rotation.axes[YAW]);
shader_set_uniform_f(zoom, identity[Camera].zoom);
//#include "visibility_culling.c"
//#include "mirrors.c"
surface_set_target(surfaces[0]);
gpu_set_tex_filter(true);
shader_set_uniform_i(vertex_mode, 0);
shader_set_uniform_i(fragment_mode, 0);
var last_boolean_group = -1;
var no_of_visibles = array_length_1d(visibles); for(var i = 0; i < no_of_visibles; i++)
{
//NOTES
//- account for mirrors
//- account for animations
var lod_index = 0;
lod_index = 0;
//LOD_VAR = (visibles.distance[i] + Options.lod_offset)/MAX_DISTANCE*2);
identity = visibles[i];
if(identity[Boolean_Group] != -1 && identity[Boolean_Group] != last_boolean_group && identity[Boolean_Group].boolean_type == BOOLEAN_CUTOUT)
{
    var subtrahends = identity[Boolean_Group].subtrahends;
    var no_of_subtrahends = array_length_1d(subtrahends);
    surface_reset_target();
shader_set_uniform_i(vertex_mode, 1);
shader_set_uniform_i(fragment_mode, 1);
surface_set_target(surfaces[2]);
draw_clear(c_black);
shader_set_uniform_i(vertex_mode, 0);
shader_set_uniform_i(fragment_mode, 2);
gpu_set_zfunc(cmpfunc_always);
gpu_set_cullmode(cull_noculling);
shader_set_uniform_i(boolean_phase, 1);
for(var b = 0; b < no_of_subtrahends; b++)
{
    identity = subtrahends[b];
var offset = default_offset;
position = identity[Position];
if(position != -1)
    offset = position.coordinates;
var angle = default_angle;
rotation = identity[Rotation];
if(rotation != -1)
    angle = rotation.axes;
var color = default_color;
var color_and_gs = identity[Color];
if(color_and_gs != -1)
    color = color_and_gs.channels;
shader_set_uniform_f(in_offset, offset[X], offset[Y], offset[Z]);
shader_set_uniform_f(in_angle, angle[ROLL], angle[PITCH], angle[YAW]);
shader_set_uniform_f(in_color, color[R], color[G], color[B], color[GS]);
    var lod_b = 0;
lod_b = 0;
//LOD_VAR = (visibles.distance[i] + Options.lod_offset)/MAX_DISTANCE*2);
    if(identity[VBO] != -1)
    {
        vertex_submit(identity[VBO].lod[lod_b], pr_trianglelist, 0);
    }
}
surface_reset_target();
gpu_set_cullmode(cull_counterclockwise);
gpu_set_zfunc(cmpfunc_lessequal);
identity = visibles[i];
texture_set_stage(boolean_depth_b_sampler, surface_get_texture(surfaces[2]));
    shader_set_uniform_i(fragment_mode, 0);
    surface_set_target(surfaces[0]);
    shader_set_uniform_i(boolean_phase, 2);
}
identity = visibles[i];
if(identity[VBO] != -1)
{
var offset = default_offset;
position = identity[Position];
if(position != -1)
    offset = position.coordinates;
var angle = default_angle;
rotation = identity[Rotation];
if(rotation != -1)
    angle = rotation.axes;
var color = default_color;
var color_and_gs = identity[Color];
if(color_and_gs != -1)
    color = color_and_gs.channels;
shader_set_uniform_f(in_offset, offset[X], offset[Y], offset[Z]);
shader_set_uniform_f(in_angle, angle[ROLL], angle[PITCH], angle[YAW]);
shader_set_uniform_f(in_color, color[R], color[G], color[B], color[GS]);
lod_index = 0;
//LOD_VAR = (visibles.distance[i] + Options.lod_offset)/MAX_DISTANCE*2);
    vertex_submit(identity[VBO].lod[lod_index], pr_trianglelist, 0);
}
if(identity[Boolean_Group] != -1)
{
    var next_boolean_group = -1;
    if(i < no_of_visibles-1)
    {
        next_boolean_group = visibles[i+1];
        next_boolean_group = next_boolean_group[Boolean_Group];
    }
    if(identity[Boolean_Group] != next_boolean_group)
    {
        if(identity[Boolean_Group].boolean_type)
        {
            //BOOLEAN_CUTOUT
            //draw fill in
            //var fill_in_to_draw = identity[Boolean_Group].fill_in;
            //         if(!fill_in_to_draw)
            //             fill_in_to_draw = identity[Boolean_Group].subtrahends;
            //
            //         var no_of_fill_ins = array_length_1d(fill_in_to_draw);
            //         for(var i = 0; i < no_of_fill_ins; i++)
            //         {
            //             identity = fill_in_to_draw[i];
            //
            //             if(identity[VBO] != -1)
            //             {
            //                 #define SET_OBJECT_UNIFORMS
            //                 #include "set_uniforms.c"
            //
            //                 #undef LOD_VAR
            //                 #define LOD_VAR lod_index
            //                 #include "pick_lod.c"
            //
            //                 vertex_submit(identity[VBO].lod[LOD_VAR], pr_trianglelist, 0);
            //             }
                //     }
        }
        else
        {
            //BOOLEAN_CARVE
            gpu_set_zfunc(cmpfunc_greaterequal);
            shader_set_uniform_i(boolean_phase, 3);
            for(var b = 0; b < no_of_subtrahends; b++)
            {
                identity = subtrahends[b];
var offset = default_offset;
position = identity[Position];
if(position != -1)
    offset = position.coordinates;
var angle = default_angle;
rotation = identity[Rotation];
if(rotation != -1)
    angle = rotation.axes;
var color = default_color;
var color_and_gs = identity[Color];
if(color_and_gs != -1)
    color = color_and_gs.channels;
shader_set_uniform_f(in_offset, offset[X], offset[Y], offset[Z]);
shader_set_uniform_f(in_angle, angle[ROLL], angle[PITCH], angle[YAW]);
shader_set_uniform_f(in_color, color[R], color[G], color[B], color[GS]);
                var lod_b = 0;
lod_b = 0;
//LOD_VAR = (visibles.distance[i] + Options.lod_offset)/MAX_DISTANCE*2);
                if(identity[VBO] != -1)
                {
                    vertex_submit(identity[VBO].lod[lod_b], pr_trianglelist, 0);
                }
            }
            gpu_set_zfunc(cmpfunc_lessequal);
        }
        shader_set_uniform_i(boolean_phase, 0);
    }
}
last_boolean_group = identity[Boolean_Group];
}
gpu_set_tex_filter(false);
surface_reset_target();
//#include "collect_lights.c"
//non-shadow lights (deferred light volumes)
//#include "lighting.c"
//shadow lights (shadow mapped spotlights)
//#include "shadowing.c"
//#include "post_processing.c"
shader_set_uniform_i(vertex_mode, 1);
shader_set_uniform_i(fragment_mode, 1);
surface_set_target(surfaces[5]);
var scale = surface_info[0];
draw_surface_ext(surfaces[0],0,0, 1/scale[0], 1/scale[1],0,c_white,1.0);
surface_reset_target();
//if(IS_SPLITSCREEN)
//{
//  #define FINAL_SURFACE surfaces[PLAYER_TWO]
  //#include "visibility_culling.c"
  //#include "mirrors.c"
  //#include "render_scene.c"
//}
shader_set_uniform_i(vertex_mode, 1);
shader_set_uniform_i(fragment_mode, 1);
//if(IS_SPLITSCREEN)
//{
//  draw_surface_part(surfaces[PLAYER_ONE],0,0,window_width*SPLITSCREEN_HORIZONTAL_RATIO, window_height/2, window_width*(1-SPLITSCREEN_HORIZONTAL_RATIO), 0);
//  draw_surface_part(surface[PLAYER_TWO],0,0, window_width*SPLITSCREEN_HORIZONTAL_RATIO, window_height/2, 0, window_height/2);
//}
//else
    draw_surface(surfaces[5],0,0);
gpu_set_blendenable(true);
gpu_set_blendmode(bm_normal);
draw_surface_ext(surfaces[2],0,0,0.5,1,0,0,0.5);
gpu_set_blendenable(false);
