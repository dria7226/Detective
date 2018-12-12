attribute vec3 in_Position; // (x,y,z)
attribute vec4 in_Color; // (r,g,b)
attribute vec2 in_TexCoord; // (u,v)

uniform vec3 id;

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
uniform vec3 scale;

uniform float grayscale;
uniform vec3 color;
varying float gs;
varying vec3 col;

float packColor(vec4 color);
vec4 unpackColor(float f);
void rotate(inout vec2 point, float angle);
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
//optimize uniforms with textures
//local - extract normal and then proceed
vec3 local = abs(in_Position);
vec3 sign = in_Position/local;
out_Normal = floor(local/100.0);
local = (local - 100.0*out_Normal)*sign;
out_Normal = out_Normal/128.0 - vec3(1.0);
local *= scale;
rotate(local.xy, angle.z);
rotate(local.xz, angle.y);
rotate(local.yz, angle.x);
rotate(out_Normal.xy, angle.z);
rotate(out_Normal.xz, angle.y);
rotate(out_Normal.yz, angle.x);
//local to relative
local += offset - camera_position;
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
 gs = grayscale;
 col = color;
 if(in_TexCoord == vec2(0.0))
 {
  if(out_Color == vec4(1.0))
   out_Color = vec4(col, 1.0);
  if(grayscale != 1.0)
  {
   vec4 intensity = (out_Color.rgba + out_Color.gbra + out_Color.brga)/3.0;
   out_Color = mix(intensity, out_Color, grayscale);
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
