
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
format_size = 0;
vertex_format_begin();
vertex_format_add_position_3d(); format_size += 3;
vertex_format_add_color(); format_size += 1;
vertex_format_add_texcoord(); format_size += 2;
format = vertex_format_end();
gpu_set_blendenable(false);
gpu_set_tex_repeat(true);
gpu_set_ztestenable(true);
//gpu_set_tex_filter(true);
surfaces[9 - 1] = -1;
surface_texture_pointers[9 - 1] = -1;
surface_info[1] = [2,2];
surface_info[2] = [2,2];
surface_info[7] = [0.1,0.1];
surface_info[9 -1] = 0;
for(var i = 0; i < 9; i++)
{
 surfaces[i] = -1;
 if(surface_info[i] == 0) surface_info[i] = [1,1];
}
var occlusion_buffer = buffer_create(1, buffer_grow, 1);
visibles = array_create(0);
shader_set(standard);
shader_set_uniform_f(shader_get_uniform(standard, "near_clip"), 1.0);
shader_set_uniform_f(shader_get_uniform(standard, "far_clip"), 300.0); shader_set_uniform_f(shader_get_uniform(standard, "screen_ratio"), window_get_height()/window_get_width());
var occlusion_info = surface_info[7];
shader_set_uniform_f(shader_get_uniform(standard, "a_pixel"), occlusion_info[0]/window_get_width(), occlusion_info[1]/window_get_height());
uniform_sampler = shader_get_sampler_index(standard, "uniform_buffer");
uniform_buffer = buffer_create(10.0*10.0*6*4 ,buffer_fast, 1);
//load common texture
//common_texture = sprite_get_texture(spr_common, 0);
