
varying highp float depth;
varying vec3 out_Normal;
varying vec4 out_Color;
varying vec2 out_TexCoord;
uniform vec3 pass_offset;
uniform vec3 pass_angle;
uniform vec3 pass_scale;
uniform vec2 a_pixel;
uniform sampler2D uniform_buffer;
varying float gs;
varying vec3 col;
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
    gl_FragColor = vec4(normalize(out_Normal)/2.0+vec3(0.5), 1.0);
  }
  if(target_type == 3.0)
  {
      //EXTRA - LIGHT ACCUMULATION
      vec3 normal = normalize(out_Normal)/2.0 + vec3(0.5);
      vec3 litup = out_Color.rgb*dot(out_Normal,vec3(0.5,-0.25,0.25));
      gl_FragColor = vec4(litup, 1.0);
      // gl_FragColor = unpackColor(depth);
  }
  return;
}
if(fragment_mode == 6)
{
    //calculate target type
    float target_type = mod(gl_FragCoord.x - 0.5, 3.0) + mod(gl_FragCoord.y - 0.5, 3.0)*3.0;
    //offset
    if(target_type == 0.0)
    {
        if(pass_offset.x > 10560.0/2.0)
        {
            gl_FragColor = float_to_vec4(1.0); return;
        }
        if(pass_offset.x < -10560.0/2.0)
        {
            gl_FragColor = float_to_vec4(0.0); return;
        }
        gl_FragColor = float_to_vec4((pass_offset.x - (-10560.0/2.0))/10560.0);
        return;
    }
    if(target_type == 1.0)
    {
        if(pass_offset.y > 10560.0/2.0)
        {
            gl_FragColor = float_to_vec4(1.0); return;
        }
        if(pass_offset.y < -10560.0/2.0)
        {
            gl_FragColor = float_to_vec4(0.0); return;
        }
        gl_FragColor = float_to_vec4((pass_offset.y - (-10560.0/2.0))/10560.0);
        return;
    }
    if(target_type == 2.0)
    {
        if(pass_offset.z > 10560.0/2.0)
        {
            gl_FragColor = float_to_vec4(1.0); return;
        }
        if(pass_offset.z < -10560.0/2.0)
        {
            gl_FragColor = float_to_vec4(0.0); return;
        }
        gl_FragColor = float_to_vec4((pass_offset.y - (-10560.0/2.0))/10560.0);
        return;
    }
    //color and grayscale
    if(target_type == 6.0)
    {
        gl_FragColor = vec4(col, gs);
        return;
    }
    //angle
    if(target_type == 7.0)
    {
        if(pass_angle.x > 3.1415926535897932384626433832795)
        {
            gl_FragColor = float_to_vec4(1.0); return;
        }
        if(pass_angle.x < -3.1415926535897932384626433832795)
        {
            gl_FragColor = float_to_vec4(0.0); return;
        }
        vec4 result = float_to_vec4((pass_angle.x - (-3.1415926535897932384626433832795))/(2.0*3.1415926535897932384626433832795));
        gl_FragColor.rg = result.rg;
        if(pass_angle.y > 3.1415926535897932384626433832795)
        {
            gl_FragColor = float_to_vec4(1.0); return;
        }
        if(pass_angle.y < -3.1415926535897932384626433832795)
        {
            gl_FragColor = float_to_vec4(0.0); return;
        }
        result = float_to_vec4((pass_angle.y - (-3.1415926535897932384626433832795))/(2.0*3.1415926535897932384626433832795));
        gl_FragColor.ba = result.rg;
        return;
    }
    if(target_type == 8.0)
    {
        if(pass_angle.z > 3.1415926535897932384626433832795)
        {
            gl_FragColor = float_to_vec4(1.0); return;
        }
        if(pass_angle.x < -3.1415926535897932384626433832795)
        {
            gl_FragColor = float_to_vec4(0.0); return;
        }
        gl_FragColor.rg = float_to_vec4((pass_angle.x - (-3.1415926535897932384626433832795))/(2.0*3.1415926535897932384626433832795)).rg;
        gl_FragColor.ba = vec2(0.0);
        return;
    }
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
