
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
//get_rotated_model(buffer, degrees)
buffer_seek(argument0, buffer_seek_start, 0);
var new_buffer = buffer_create(buffer_get_size(argument0), buffer_fixed, 1);
var no_of_vertices = buffer_get_size(new_buffer)/(Game.format_size*4);
repeat(no_of_vertices)
{
 //Position 3x4 bytes
 var XY = [0,0];
 var NXY = [0,0];
 for(i = 0; i < 2; i++)
 {
  XY[i] = buffer_read(argument0, buffer_f32);
  NXY[i] = XY[i]/10.0;
  if(XY[i] < 0)
   NXY[i] = ceil(NXY[i]);
  else
   NXY[i] = floor(NXY[i]);
  XY[i] -= NXY[i]*10.0;
  NXY[i] = abs(NXY[i])/128 - 1;
 }
 //rotate
 var temp = sin(argument1*3.1415926535897932384626433832795/180)*XY[1] - cos(argument1*3.1415926535897932384626433832795/180)*XY[0];
 XY[1] = cos(argument1*3.1415926535897932384626433832795/180)*XY[1] + sin(argument1*3.1415926535897932384626433832795/180)*XY[0];
 XY[0] = temp;
 var Ntemp = sin(argument1*3.1415926535897932384626433832795/180)*NXY[1] - cos(argument1*3.1415926535897932384626433832795/180)*NXY[0];
 NXY[1] = cos(argument1*3.1415926535897932384626433832795/180)*NXY[1] + sin(argument1*3.1415926535897932384626433832795/180)*NXY[0];
 NXY[0] = Ntemp;
 //write
 for(i = 0; i < 2; i++)
 {
  var s = sign(XY[i]);
  s += (s == 0);
  //clear and recompress normals
  XY[i] += s*floor((NXY[i] + 1)*128)*10.0;;
  buffer_write(new_buffer, buffer_f32, XY[i]);
 }
 //Z
 buffer_write(new_buffer, buffer_f32, buffer_read(argument0, buffer_f32));
 //Color 1x4 bytes
 buffer_write(new_buffer, buffer_f32, buffer_read(argument0, buffer_f32));
 //Texture Coordinates 2x4 bytes
 buffer_write(new_buffer, buffer_f32, buffer_read(argument0, buffer_f32));
 buffer_write(new_buffer, buffer_f32, buffer_read(argument0, buffer_f32));
}
return new_buffer;
