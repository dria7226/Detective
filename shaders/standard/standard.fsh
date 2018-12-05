varying highp float depth;
varying vec3 out_Normal;
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
  //calculate target type
  float target_type = mod(gl_FragCoord.x - 0.5, 2.0) + mod(gl_FragCoord.y - 0.5, 2.0)*2.0;
  if(target_type == 0.0)
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
    gl_FragColor = c;
  }
  if(target_type == 1.0)
  {
    //DEPTH
    gl_FragColor = unpackColor(depth);
  }
  if(target_type == 2.0)
  {
    //NORMAL
    gl_FragColor = vec4(normalize(out_Normal-vec3(1.0)), 1.0);
  }
  if(target_type == 3.0)
  {
    //EXTRA - LIGHT ACCUMULATION
    gl_FragColor = vec4(normalize(out_Normal-vec3(1.0)), 1.0);
  }
  return;
}
  //#include "edge_detection.txt"
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
