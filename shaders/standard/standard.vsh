
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
attribute vec3 in_Position; // (x,y,z)
attribute vec4 in_Color; // (r,g,b)
attribute vec2 in_TexCoord; // (u,v)
uniform vec3 id;
uniform sampler2D uniform_buffer;
uniform int vertex_mode;
varying highp float depth;
varying vec3 out_Normal;
varying vec4 out_Color;
varying vec2 out_TexCoord;
uniform vec3 camera_position;
uniform vec3 camera_angle;
uniform float near_clip;
uniform float far_clip;
uniform float screen_ratio;
uniform vec3 offset;
uniform vec3 angle;
uniform float grayscale;
uniform vec3 color;
varying float gs;
varying vec3 col;
float packColor(vec4 color);
vec4 unpackColor(float f);
void rotate(inout vec2 point, float angle);
float vec4_to_float(vec4 color);
void main()
{
 if(vertex_mode == 1)
 {
gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * vec4(in_Position, 1.0);
out_Color = in_Color;
out_TexCoord = in_TexCoord;
out_Normal = vec3(0.0);
return;
 }
 else
 {
vec3 final_offset = offset;
vec3 final_angle = angle;
//optimize uniforms with textures
float packed_id = dot(id, vec3(255.0, 255.0*256.0, 255.0*256.0*256.0));
if(packed_id < 10.0*10.0)
{
    vec2 a_pixel = vec2(1.0/10.0/3.0);
    vec2 coordinates = vec2(mod(packed_id, 10.0), 0.0);
    coordinates.y = packed_id/10.0 - coordinates.x;
    coordinates *= 3.0/10.0;
    //offset
    vec4 reading = texture2D(uniform_buffer, coordinates + a_pixel*vec2(0.0,0.0));
    final_offset.x = vec4_to_float(reading)*10560.0 + (-10560.0/2.0);
    reading = texture2D(uniform_buffer, coordinates + a_pixel*vec2(1.0,0.0));
    final_offset.y = vec4_to_float(reading)*10560.0 + (-10560.0/2.0);
    reading = texture2D(uniform_buffer, coordinates + a_pixel*vec2(2.0,0.0));
    final_offset.z = vec4_to_float(reading)*10560.0 + (-10560.0/2.0);
    final_offset = vec3(0.0);
    //color and grayscale
    reading = texture2D(uniform_buffer, coordinates + a_pixel*vec2(0.0,2.0));
    col.rgb = reading.rgb;
    gs = reading.a;
    //angle
    reading = texture2D(uniform_buffer, coordinates + a_pixel*vec2(1.0,2.0));
    final_angle.x = vec4_to_float(vec4(reading.rg, 0.0, 0.0))*2.0*3.1415926535897932384626433832795 + (-3.1415926535897932384626433832795);
    final_angle.y = vec4_to_float(vec4(reading.ba, 0.0, 0.0))*2.0*3.1415926535897932384626433832795 + (-3.1415926535897932384626433832795);
    reading = texture2D(uniform_buffer, coordinates + a_pixel*vec2(2.0,2.0));
    final_angle.z = vec4_to_float(vec4(reading.rg, 0.0, 0.0))*2.0*3.1415926535897932384626433832795 + (-3.1415926535897932384626433832795);
}
//local - extract normal and then proceed
vec3 local = abs(in_Position);
vec3 sign = in_Position/local;
sign += vec3(1.0) - abs(sign);
out_Normal = floor(local/10.0);
local = (local - 10.0*out_Normal)*sign;
out_Normal = out_Normal/128.0 - vec3(1.0);
//snap vertices
rotate(local.xy, final_angle.z);
rotate(local.xz, final_angle.y);
rotate(local.yz, final_angle.x);
rotate(out_Normal.xy, final_angle.z);
rotate(out_Normal.xz, final_angle.y);
rotate(out_Normal.yz, final_angle.x);
//local to relative
local += final_offset - camera_position;
rotate(local.xy, -camera_angle.z);
rotate(local.xz, -camera_angle.y);
rotate(local.yz, -camera_angle.x);
//project
depth = length(local.xyz);
gl_Position.z = depth/far_clip*local.x;
gl_Position.xy = local.yz*near_clip;
gl_Position.x *= -screen_ratio;
gl_Position.w = local.x;
 }
if(vertex_mode == 2)
{
 out_Color = vec4(id, 1.0);
 out_TexCoord = vec2(0.0);
}
else
{
 out_Color = in_Color;
 if(dot(id, vec3(255.0, 255.0*256.0, 255.0*256.0*256.0)) >= 10.0*10.0)
 {
  gs = grayscale;
  col = color;
 }
 if(in_TexCoord == vec2(0.0))
 {
  if(out_Color == vec4(1.0))
   out_Color = vec4(col, 1.0);
  if(grayscale != 1.0)
  {
   vec4 intensity = (out_Color.rgba + out_Color.gbra + out_Color.brga)/3.0;
   out_Color = mix(intensity, out_Color, gs);
  }
 }
 out_TexCoord = in_TexCoord;
}
}
void rotate(inout vec2 point, float angle)
{
  float X = cos(angle)*point.x - sin(angle)*point.y;
  point.y = cos(angle)*point.y + sin(angle)*point.x;
  point.x = X;
}
float packColor(vec4 color)
{
    return dot( color, vec4(1.0, 1.0/255.0, 1.0/(255.0*255.0), 1.0/(255.0*255.0*255.0)) );
}
vec4 unpackColor(float f)
{
  f /= 300.0;
  vec4 enc = f * vec4(1.0, 255.0, 255.0*255.0, 255.0*255.0*255.0);
  enc = fract(enc);
  enc.rgb -= enc.gba/vec3(255.0);
  return enc;
}
//pack_id() dot(id, vec3(byte, byte*256.0, byte*256.0*256.0))
//percentage to partial percentages
vec4 float_to_vec4(float f)
{
    float max_value = 255.0/256.0;
    float r = floor(f/max_value);
    f -= r*max_value;
    max_value /= 256.0;
    float g = floor(f/max_value);
    f -= g*max_value;
    max_value /= 256.0;
    float b = floor(f/max_value);
    f -= b*max_value;
    max_value /= 255.0;
    float a = floor(f/max_value);
    return vec4(r,g,b,a);
}
//partial percentages to percentage
float vec4_to_float(vec4 color)
{
    return dot(vec3(color.r*255.0, color.g*255.0, color.b*255.0 + color.a), vec3(1.0)/vec3(256.0, 256.0*256.0, 256.0*256.0*256.0));
}
