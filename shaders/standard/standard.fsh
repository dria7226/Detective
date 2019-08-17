
varying float depth;
varying vec3 out_Normal;
varying vec4 out_Color;
varying vec2 out_TexCoord;
uniform vec2 a_pixel;

varying vec4 color;

uniform int fragment_mode;

float packColor(vec4 color);
vec4 unpackColor(float f);
void rotate(inout vec2 point, float angle);
vec4 float_to_vec4(float f);
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
    //textured
    if(out_TexCoord != vec2(0.0))
    {
      c = texture2D(gm_BaseTexture, out_TexCoord);
      //color
      if(c == vec4(1.0))
        c = vec4(color.rgb, 1.0);
      //grayscale
      if(color.a != 1.0)
      {
        vec4 intensity = (c.rgba + c.gbra + c.brga)/3.0;
        c = mix(intensity, c, color.a);
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
    gl_FragColor = vec4(normalize(out_Normal)/2.0+vec3(0.5), 1.0);
  }
  if(target_type == 3.0)
  {
      //EXTRA - LIGHT ACCUMULATION
      vec3 normal = normalize(out_Normal)/2.0 + vec3(0.5);
      //textured
      if(out_TexCoord != vec2(0.0))
      {
        c = texture2D(gm_BaseTexture, out_TexCoord);
        //color
        if(c == vec4(1.0))
          c = vec4(color.rgb, 1.0);
        //grayscale
        if(color.a != 1.0)
        {
          vec4 intensity = (c.rgba + c.gbra + c.brga)/3.0;
          c = mix(intensity, c, color.a);
        }
      }
      vec3 litup = c.rgb*dot(out_Normal,vec3(0.5,-0.25,0.25));
      gl_FragColor = vec4(mix(litup, c.rgb, 0.3), 1.0);
      //gl_FragColor = vec4(vec3(depth), 1.0);
      //gl_FragColor = vec4(normal, 1.0);
  }
  return;
}
  //#include "uniform_encoding.c"
  //#include "edge_detection.c"
  // #include "occlusion_first_pass.c"
  //
  // #include "occlusion_second_pass.c"
  //
  // #include "post_processing_fragment.c"
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
