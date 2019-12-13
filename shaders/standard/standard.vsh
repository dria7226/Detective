
attribute vec3 in_Position; // (x,y,z)
attribute vec4 in_Color; // (r,g,b)
attribute vec2 in_TexCoord; // (u,v)





uniform int vertex_mode;

uniform vec4 object_id;


uniform vec3 in_camera_position;
uniform vec3 in_camera_angle;
uniform float zoom;


uniform float screen_ratio;



uniform vec3 in_offset;
uniform vec3 in_angle;
uniform vec4 in_color;


varying vec4 color;

varying float depth;
varying vec3 out_Normal;
varying vec4 out_Color;
varying vec2 out_TexCoord;

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
vec3 s = vec3(1.0);
vec3 offset = in_offset;
vec3 angle = in_angle;
vec3 camera_position = in_camera_position;
vec3 camera_angle = in_camera_angle;
vec3 local = in_Position;
//local - extract normal and then proceed
local = abs(in_Position.xyz);
s = sign(in_Position.xyz);
s += vec3(1.0) - abs(s);
out_Normal = floor(local/10.0);
local = local - out_Normal*10.0;
out_Normal = out_Normal/128.0 - vec3(1.0);
//snap vertices
local = floor(local/0.00075)*0.00075;
//reapply sign
local *= s;
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
gl_Position.z = local.x - 0.16;
gl_Position.xy = local.yz*zoom;
gl_Position.x *= -screen_ratio;
gl_Position.w = local.x + 0.0;
depth = gl_Position.z;
 }
if(vertex_mode == 2)
{
out_Color = vec4(object_id.rgb/255.0, 1.0);
out_TexCoord = vec2(0.0);
}
else
{
out_Color = in_Color;
color = in_color;
//no texture
if(in_TexCoord == vec2(0.0))
{
    //perform vertex color setting
    if(out_Color == vec4(1.0))
        out_Color = vec4(color.rgb, 1.0);
    //and apply grayscale
    if(color.a != 1.0)
    {
        vec4 intensity = (out_Color.rgba + out_Color.gbra + out_Color.brga)/3.0;
        out_Color = mix(intensity, out_Color, color.a);
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
vec4 unpackColor(float f)
{
  f /= 300.0;
  vec4 enc = f * vec4(1.0, 255.0, 255.0*255.0, 255.0*255.0*255.0);
  enc = fract(enc);
  enc.rgb -= enc.gba/vec3(255.0);
  return enc;
 }
//pack_id() dot(object_id, vec3(byte, byte*256.0, byte*256.0*256.0))
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
