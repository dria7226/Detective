varying vec2 v_vTexcoord;

#define FRAG_WIDTH 0.00097656

#define THRESHOLD 0.0001

void main()
{	
	vec2 offsets[4];
	offsets[0] = vec2(0.0, 1.0);
	offsets[1] = vec2(1.0,-1.0);
	offsets[2] = vec2(1.0, 0.0);
	offsets[3] = vec2(1.0, 0.0);

	for(int i = 0; i < 4; i++)
	{
		vec3 delta = abs(
					texture2D(gm_BaseTexture, v_vTexcoord + FRAG_WIDTH*offsets[i])
					-
					texture2D(gm_BaseTexture, v_vTexcoord - FRAG_WIDTH*offsets[i])).rgb/4.0;
		
		if(delta.r > THRESHOLD) delta.rgb = vec3(0.25);
		
		gl_FragColor.rgb += delta;
	}
	
	gl_FragColor  = 1.0 - gl_FragColor;
}
