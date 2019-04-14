
attribute vec3 in_Position; // (x,y,z)
attribute vec4 in_Color; // (r,g,b)
attribute vec2 in_TexCoord; // (u,v)
uniform sampler2D uniform_buffer;

uniform int vertex_mode;

uniform vec3 camera_position;
uniform vec3 camera_angle;
uniform float zoom;
uniform float screen_ratio;

uniform vec3 id;
uniform vec3 offset;
uniform vec3 angle;

uniform float grayscale;
uniform vec3 color;
varying float gs;
varying vec3 col;

varying float depth;
varying vec3 out_Normal;
varying vec4 out_Color;
varying vec2 out_TexCoord;

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
    vec2 coordinates = vec2(0.0, floor(packed_id/ 10.0));
    coordinates.x = packed_id - coordinates.y*10.0;
    coordinates /= 10.0;
    coordinates.x /= 6.0;
    //offset
    vec4 reading = texture2D(uniform_buffer, coordinates);
    final_offset.x = vec4_to_float(reading)*10560.0 + (-10560.0/2.0);
    coordinates.x += 1.0/(10.0*6.0);
    reading = texture2D(uniform_buffer, coordinates);
    final_offset.y = vec4_to_float(reading)*10560.0 + (-10560.0/2.0);
    coordinates.x += 1.0/(10.0*6.0);
    reading = texture2D(uniform_buffer, coordinates);
    final_offset.z = vec4_to_float(reading)*10560.0 + (-10560.0/2.0);
    final_offset = vec3(0.0);
    //angle
    coordinates.x += 1.0/(10.0*6.0);
    reading = texture2D(uniform_buffer, coordinates);
    final_angle.x = vec4_to_float(vec4(reading.rg, 0.0, 0.0))*2.0*3.1415926535897932384626433832795 + (-3.1415926535897932384626433832795);
    final_angle.y = vec4_to_float(vec4(reading.ba, 0.0, 0.0))*2.0*3.1415926535897932384626433832795 + (-3.1415926535897932384626433832795);
    coordinates.x += 1.0/(10.0*6.0);
    reading = texture2D(uniform_buffer, coordinates);
    final_angle.z = vec4_to_float(vec4(reading.rg, 0.0, 0.0))*2.0*3.1415926535897932384626433832795 + (-3.1415926535897932384626433832795);
    //color and grayscale
    coordinates.x += 1.0/(10.0*6.0);
    reading = texture2D(uniform_buffer, coordinates);
    col.rgb = reading.rgb;
    gs = reading.a;
}
//local - extract normal and then proceed
vec3 local = abs(in_Position);
vec3 sign = in_Position/local;
sign += vec3(1.0) - abs(sign);
out_Normal = floor(local/10.0);
local = (local - 10.0*out_Normal);
out_Normal = out_Normal/128.0 - vec3(1.0);
//snap vertices
local = floor(local/0.0005)*0.0005;
//reapply sign
local *= sign;
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
depth = local.x - 0.35;
gl_Position.z = depth;
depth /= local.x + 0.0;
gl_Position.xy = local.yz*zoom;
gl_Position.x *= -screen_ratio;
gl_Position.w = local.x + 0.0;
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
