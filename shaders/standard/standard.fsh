varying float depth;
varying vec4 out_Color;
varying vec2 out_TexCoord;

uniform float grayscale;
uniform vec3 color;

uniform int mode;

#define COLOR_MODE 0
#define DEPTH_MODE 1
#define OCCLUSION_FIRST_PASS 1
#define OCCLUSION_SECOND_PASS 2
#define NORMAL_DETECTION 3
#define EDGE_DETECTION 4
#define COMPOSITING 5

#define OCCLUSION_DEBUG_MODE 20

#define byte 256.0
#define THRESHOLD 0.5
#define FRAG_WIDTH 1.0/1024.0

float unpack(vec2 offset);

void main()
{	
	//vigilant eye fix
	if(depth < 0.0)
		discard;
	
	if(mode == COLOR_MODE || mode == OCCLUSION_DEBUG_MODE )
	{
		vec4 c = out_Color;
		
		if(out_TexCoord != vec2(0.0))
		{
			c = texture2D(gm_BaseTexture, out_TexCoord);
			
			//color
			if(c == vec4(1.0))
				c *= vec4(color, 1.0);
			
			//grayscale
			if(grayscale != 1.0)
			{
				vec3 intensity = (c.rgb + c.gbr + c.brg)/3.0;
				c = vec4(intensity + (c.rgb - intensity)*grayscale, 1.0);
			}
		}
		
		gl_FragColor = c;
		return;
	}
	
	if(mode == DEPTH_MODE)
	{
		//alternative
		//return vec3( floor( depth * 255.0 ) / 255.0,
	    //         fract( depth * 255.0 ),
		//		 fract( depth * 255.0 * 255.0 ) );
		
		vec4 d = fract(depth*(byte*byte*byte*byte - 1.0)/(byte*byte*byte*byte)*vec4(1.0, byte, byte*byte, byte*byte*byte));
	
		gl_FragColor = d;
		return;
	}
	
	if(mode == OCCLUSION_FIRST_PASS)
	{
		//if(current color already exists)
		//	search for a new color
		//	if no new colors, return white
		//  if new color found, return it
		//else
		//	return it
		
		return;
	}
	
	if(mode == OCCLUSION_SECOND_PASS)
	{
		//if(current color is not white)
		//	if( it already exists)
		//		set to white
		//	else
		//		return
		//else
		//	return
		
		return;
	}
	
	if(mode == NORMAL_DETECTION)
	{
		vec3 normal = vec3(	unpack(vec2(0.0, 0.0)) -
							unpack(vec2(FRAG_WIDTH, 0.0)),
					
							unpack(vec2(0.0, 0.0)) -
							unpack(vec2(0.0, FRAG_WIDTH)),
						
							0.0);
	
		normal.xy /= FRAG_WIDTH;
		normal.z = pow(1.0 - pow(length(normal), 2.0), 0.5);
		normal.xy = normal.xy/2.0 + vec2(0.5);
	
	    gl_FragColor = vec4(normal, 1.0);
		//float depth = unpack(vec2(0.0,0.0));
		//gl_FragColor = vec4(vec3(depth*10.0),1.0);
	}
	
	if(mode == EDGE_DETECTION)
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
		
			if(delta.r > THRESHOLD) delta.rgb = vec3(0.25);
		
			gl_FragColor.rgb += delta;
		}
	
		gl_FragColor  = 1.0 - gl_FragColor;
	}
	
	if(mode == COMPOSITING)
	{
		
	}
}

float unpack(vec2 offset)
{
	vec4 depth = texture2D(gm_BaseTexture, out_TexCoord + offset);
	
	return dot(depth, byte*byte*byte*byte/(byte*byte*byte*byte - 1.0)/vec4(1.0, byte, byte*byte, byte*byte*byte));
	
	//return depth.r*byte*byte*byte + depth.g*byte*byte + depth.b*byte + depth.a;
}