varying vec2 v_vTexcoord;

#define FRAG_WIDTH 0.00097656
#define byte 256.0

float unpack(vec2 offset);

void main()
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

float unpack(vec2 offset)
{
	vec4 depth = texture2D(gm_BaseTexture, v_vTexcoord + offset);
	
	return dot(depth, byte*byte*byte*byte/(byte*byte*byte*byte - 1.0)/vec4(1.0, byte, byte*byte, byte*byte*byte));
	
	//return depth.r*byte*byte*byte + depth.g*byte*byte + depth.b*byte + depth.a;
}