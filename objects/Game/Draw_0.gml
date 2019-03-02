
/* Copyright (C) 1991-2016 Free Software Foundation, Inc.
   This file is part of the GNU C Library.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with the GNU C Library; if not, see
   <http://www.gnu.org/licenses/>.  */
/* This header is separate from features.h so that the compiler can
   include it implicitly at the start of every compilation.  It must
   not itself include <features.h> or any other header that includes
   <features.h> because the implicit include comes before any feature
   test macros that may be defined in a source file before it first
   explicitly includes a system header.  GCC knows the name of this
   header in order to preinclude it.  */
/* glibc's intent is to support the IEC 559 math functionality, real
   and complex.  If the GCC (4.9 and later) predefined macros
   specifying compiler intent are available, use them to determine
   whether the overall intent is to support these features; otherwise,
   presume an older compiler has intent to support these features and
   define these macros by default.  */
/* wchar_t uses Unicode 8.0.0.  Version 8.0 of the Unicode Standard is
   synchronized with ISO/IEC 10646:2014, plus Amendment 1 (published
   2015-05-15).  */
/* We do not support C11 <threads.h>.  */
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
