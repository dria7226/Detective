
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
//updated_static(index)
var statics = tags[|Static];
var query = [Position, Rotation, Scale, Color, Grayscale, VBO];
var index = search_tags(statics[|argument0], query);
if(index[0] != -1)
{
  var id_tag = tags[|query[0]]; id_tag = id_tag[|index[0]];
  shader_set_uniform_f(shader_get_uniform(standard, "pass_offset"), id_tag.X, id_tag.Y, id_tag.Z);
}
else
  shader_set_uniform_f(shader_get_uniform(standard, "pass_offset"), 0,0,0);
if(index[1] != -1)
{
  id_tag = tags[|query[1]]; id_tag = id_tag[|index[1]];
  shader_set_uniform_f(shader_get_uniform(standard, "pass_angle"), id_tag.roll, id_tag.pitch, id_tag.yaw);
}
else
  shader_set_uniform_f(shader_get_uniform(standard, "pass_angle"), 0,0,0);
if(index[2] != -1)
{
  id_tag = tags[|query[2]]; id_tag = id_tag[|index[2]];
  shader_set_uniform_f(shader_get_uniform(standard, "pass_scale"), id_tag.X, id_tag.Y, id_tag.Z);
}
else
  shader_set_uniform_f(shader_get_uniform(standard, "pass_scale"), 1,1,1);
if(index[3] != -1)
{
  id_tag = tags[|query[3]]; id_tag = id_tag[|index[3]];
  shader_set_uniform_f(shader_get_uniform(standard, "color"), id_tag.R, id_tag.G, id_tag.B);
}
else
  shader_set_uniform_f(shader_get_uniform(standard, "color"), 0,0,0);
if(index[4] != -1)
{
    id_tag = tags[|query[4]];
    shader_set_uniform_f(shader_get_uniform(standard, "grayscale"), id_tag[|index[4]]);
}
else
    shader_set_uniform_f(shader_get_uniform(standard, "grayscale"), 1.0);
//draw to uniform buffer
var X = argument0%10.0;
var Y = (argument0 - X)/10.0;
X *= 3; Y *= 3;
//in pixels
draw_rectangle(X, Y, X+2, Y+2, false);
