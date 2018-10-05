

void main()
{
 if(vertex_mode == FLAT)
 {
gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
out_Color = in_Color;
out_TexCoord = in_TexCoord;
return;
 }
 else
 {
//optimize uniforms with textures
//local
vec3 local = in_Position*scale;
rotate(local.xy, angle.z);
rotate(local.xz, angle.y);
rotate(local.yz, angle.x);
//local to relative
local += offset - camera_position - camera_offset;
rotate(local.xy, -camera_angle.z-camera_angle_offset.z);
rotate(local.xz, -camera_angle.y-camera_angle_offset.y);
rotate(local.yz, -camera_angle.x-camera_angle_offset.x);
//project
gl_Position.z = length(local.xyz)/far_clip*local.x;
depth = gl_Position.z;
gl_Position.xy = local.yz*near_clip;
gl_Position.x *= -screen_ratio;
gl_Position.w = local.x;
 }
if(vertex_mode == OCCLUSION_DRAW)
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
   out_Color *= vec4(col, 1.0);
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
float packColor(vec3 color) {
    return color.r + color.g * 256.0 + color.b * 256.0 * 256.0;
}
vec3 unpackColor(float f) {
    vec3 color;
 color.b = floor(f/(256.0*256.0));
    color.g = mod(floor(f/256.0), 256.0);
    color.r = mod(f,256.0);
    // now we have a vec3 with the 3 components in range [0..255]. Let's normalize it!
    return color / 255.0;
}
