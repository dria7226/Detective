
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
//find camera
var camera = tags[Camera]; camera = camera[|0].back_reference;
var position = camera[Position];
var yaw = camera[Rotation].angle[YAW];
var change = delta_time/1000000*speed;
if keyboard_check(ord("W"))
{
    change_position(camera, 1, [change*cos(yaw), change*sin(yaw), 0]);
}
if keyboard_check(ord("S"))
{
    change_position(camera, 1, [-change*cos(yaw), -change*sin(yaw), 0]);
}
if keyboard_check(ord("A"))
{
 change_position(camera, 1, [change*cos(yaw + 3.1415926535897932384626433832795/2), change*sin(yaw + 3.1415926535897932384626433832795/2), 0]);
}
if keyboard_check(ord("D"))
{
 change_position(camera, 1, [change*cos(yaw - 3.1415926535897932384626433832795/2), change*sin(yaw - 3.1415926535897932384626433832795/2), 0]);
}
if keyboard_check(ord("M"))
{
 surface_save(surfaces[1], "MRT.png");
}
if keyboard_check(ord("U"))
{
 surface_save(surfaces[0], "uniform_buffer.png");
}
if keyboard_check(vk_space)
{
 position.coordinates[Z] += change/2;
}
if keyboard_check(ord("C"))
{
 position.coordinates[Z] -= change/2;
}
