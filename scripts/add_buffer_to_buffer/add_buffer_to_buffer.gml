
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
//add_buffer_to_buffer(buffer, model_buffer, offset)
if(argument0 == argument1)
{
 log(ERROR, "Cant add buffer to itself.");
 return;
}
var arg0_size = buffer_get_size(argument0);
var arg1_size = buffer_get_size(argument1);
buffer_resize(argument0, arg0_size + arg1_size);
buffer_seek(argument0, buffer_seek_start, arg0_size);
buffer_seek(argument1, buffer_seek_start, 0);
var no_of_vertices = arg1_size/(Game.format_size*4);
repeat(no_of_vertices)
{
 for(var i = 0; i < 3; i++)
 {
  var position = buffer_read(argument1, buffer_f32);
  var normal = position/10.0;
  if(position < 0)
   normal = ceil(normal)*10.0;
  else
   normal = floor(normal)*10.0;
  position = position - normal + argument2[i];
  var s = sign(position);
  s += (s == 0);
  position += s*abs(normal);
   buffer_write(argument0, buffer_f32, position);
 }
 //Color 1x4 bytes
 buffer_write(argument0, buffer_f32, buffer_read(argument1, buffer_f32));
 //Texture Coordinates 2x4 bytes
 buffer_write(argument0, buffer_f32, buffer_read(argument1, buffer_f32));
 buffer_write(argument0, buffer_f32, buffer_read(argument1, buffer_f32));
}
