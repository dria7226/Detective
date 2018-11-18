varying highp float depth;
varying vec4 out_Color;
varying vec2 out_TexCoord;

uniform vec2 a_pixel;
uniform sampler2D sampler_a;

varying float gs;
varying vec3 col;

uniform int fragment_mode;

float packColor(vec4 color);
vec4 unpackColor(float f);
void rotate(inout vec2 point, float angle);
void main()
{
if(fragment_mode == 1)
{
  gl_FragColor = out_Color * texture2D( gm_BaseTexture, out_TexCoord);
  return;
}
if(fragment_mode == 0)
{
  vec4 c = out_Color;
  if(mod(gl_FragCoord.x - 0.5, 2.0) == 0.0)
  {
    //DIFFUSE
    if(out_TexCoord != vec2(0.0))
    {
      c = texture2D(gm_BaseTexture, out_TexCoord);
      //color
      if(c == vec4(1.0))
        c = vec4(col, 1.0);
      //grayscale
      if(gs != 1.0)
      {
        vec4 intensity = (c.rgba + c.gbra + c.brga)/3.0;
        c = mix(intensity, c, gs);
      }
    }
  }
  else
  {
    //DEPTH
    c = unpackColor(depth);
  }
  gl_FragColor = c;
  return;
}
if(fragment_mode == 4)
{
  vec2 offsets[2];
  offsets[0] = vec2(2.0 * a_pixel.x,0.0);
  offsets[1] = vec2(0.0,a_pixel.y);
  float result[2];
  float current_depth = packColor(texture2D(gm_BaseTexture, out_TexCoord));
  for(int i = 0; i < 2; i++)
  {
    result[i] = packColor(texture2D(gm_BaseTexture, out_TexCoord + offsets[i])) - current_depth;
    float other = current_depth - packColor(texture2D(gm_BaseTexture, out_TexCoord - offsets[i]));
    if(abs(other) < abs(result[i])) result[i] = other;
  }
  vec3 normal = vec3(result[0], 0.0, 0.0);
  //normal *= MAXIMUM_VIEW_DISTANCE;
  //normal.xy /= a_pixel.xy;
  //normal.z = pow(1.0 - pow(length(normal), 2.0), 0.5);
  //normal.x = 0.5 + normal.x/2.0;
  //gl_FragColor = texture2D(gm_BaseTexture, out_TexCoord - vec2(a_pixel.x,0));
  gl_FragColor = vec4(normal, 1.0);
}
  // #include "occlusion_first_pass.txt"
  //
  // #include "occlusion_second_pass.txt"
  //
  // #include "post_processing_fragment.txt"
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
