

void main()
{
if(fragment_mode == FLAT)
{
  gl_FragColor = out_Color * texture2D( gm_BaseTexture, out_TexCoord);
  return;
}
if(fragment_mode == DIFFUSE)
{
  vec4 c = out_Color;
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
  //gl_FragColor = vec4(vec3(depth), 1.0);
  return;
}
if(fragment_mode == DEPTH_MODE)
{
  //alternative
  //return vec3( floor( depth * 255.0 ) / 255.0,
    //         fract( depth * 255.0 ),
  //		 fract( depth * 255.0 * 255.0 ) );
  vec4 d = fract(gl_FragCoord.z*(255.0*255.0*255.0*255.0 - 1.0)/(255.0*255.0*255.0*255.0)*vec4(1.0, 255.0, 255.0*255.0, 255.0*255.0*255.0));
  gl_FragColor = d;
  return;
}
if(fragment_mode == OCCLUSION_FIRST_PASS)
{
  gl_FragColor = texture2D(gm_BaseTexture, out_TexCoord);
  if(gl_FragColor != vec4(1.0))
  for(vec2 leading_coord = out_TexCoord + vec2(a_pixel.x,0.0); leading_coord.y <= 1.0;)
  {
    if(texture2D(gm_BaseTexture, leading_coord) == gl_FragColor)
    {
      gl_FragColor = vec4(1.0);
      return;
    }
    leading_coord.x += a_pixel.x;
    if(leading_coord.x > 1.0) leading_coord = vec2(0.0, leading_coord.y + a_pixel.y);
  }
  return;
}
if(fragment_mode == OCCLUSION_SECOND_PASS)
{
  gl_FragColor = vec4(1.0);
  vec2 pixel = a_pixel*2.0;
  //float target_index = (out_TexCoord.y/pixel.y - 0.5 + pixel.x + out_TexCoord.x)/pixel.x;
  float target_index = (gl_FragCoord.y - 0.5) * 32.0 + gl_FragCoord.x + 0.5;
  //target_index = floor(target_index);
  if(target_index >= 20.0*20.0) return;
  float current_index = 0.0;
  for(vec2 leading_coord = vec2(1.0); leading_coord.y >= 0.0;)
  {
    vec4 leading_color = texture2D(gm_BaseTexture, leading_coord);
    if(leading_color != vec4(1.0))
    {
      current_index += 1.0;
      if(current_index == target_index)
      {
        gl_FragColor = leading_color; return;
      }
    }
    //next leading coord
    leading_coord.x -= a_pixel.x;
    if(leading_coord.x < 0.0) leading_coord = vec2(1.0, leading_coord.y - a_pixel.y);
  }
}
if(fragment_mode == NORMAL_DETECTION)
{
  //vec3 normal = vec3(	unpack(vec2(0.0, 0.0)) -
  //					unpack(vec2(FRAG_WIDTH, 0.0)),
  //					unpack(vec2(0.0, 0.0)) -
  //					unpack(vec2(0.0, FRAG_WIDTH)),
  //					0.0);
  //normal.xy /= FRAG_WIDTH;
  //normal.z = pow(1.0 - pow(length(normal), 2.0), 0.5);
  //normal.xy = normal.xy/2.0 + vec2(0.5);
    //gl_FragColor = vec4(normal, 1.0);
  //float depth = unpack(vec2(0.0,0.0));
  //gl_FragColor = vec4(vec3(depth*10.0),1.0);
}
if(fragment_mode == EDGE_DETECTION)
{
  vec2 offsets[4];
  offsets[0] = vec2(0.0, 1.0);
  offsets[1] = vec2(1.0,-1.0);
  offsets[2] = vec2(1.0, 0.0);
  offsets[3] = vec2(1.0, 0.0);
  for(int i = 0; i < 4; i++)
  {
    vec3 delta = abs(
          texture2D(gm_BaseTexture, out_TexCoord + FRAG_WIDTH*offsets[i])
          -
          texture2D(gm_BaseTexture, out_TexCoord - FRAG_WIDTH*offsets[i])).rgb/4.0;
    if(delta.r > 0.5) delta.rgb = vec3(0.25);
    gl_FragColor.rgb += delta;
  }
  gl_FragColor = 1.0 - gl_FragColor;
}
if(fragment_mode == COMPOSITING)
{
}
}
