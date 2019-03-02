
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
//change_position(identity, type, [amount])
var identity = argument0;
var position = identity[Position];
//track changed identities
set_tags(identity, [Changed_Uniform]);
//derive buffer index from identity index
var buffer_index = identity[INDEX]*6*4;
var is_added = (argument1 == 1);
for(var i = 0; i < 3; i++)
{
    //change tag
    position.coordinates[i] = position.coordinates[i]*is_added + argument2[i];
    //encode in uniform buffer
    if(position.coordinates[i] > 10560.0/2.0)
    {
        write_normal_value_to_uniform_buffer(buffer_index + i, 1, 4); continue;
    }
    if(position.coordinates[i] < -10560.0/2.0)
    {
        write_normal_value_to_uniform_buffer(buffer_index + i, 0, 4); continue;
    }
    write_normal_value_to_uniform_buffer(buffer_index + i, (position.coordinates[i] - (-10560.0/2.0))/10560.0, 4);
}
