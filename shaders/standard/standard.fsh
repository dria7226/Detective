varying float depth;
varying vec4 out_Color;

uniform int draw_mode;

#define COLOR_MODE 0
#define DEPTH_MODE 1

#define byte 256.0

void main()
{	
	if(draw_mode == COLOR_MODE)
	{
		gl_FragColor = out_Color;
		return;
	}
	
	if(draw_mode == DEPTH_MODE)
	{
		vec4 d = fract(depth*(byte*byte*byte*byte - 1.0)/(byte*byte*byte*byte)*vec4(1.0, byte, byte*byte, byte*byte*byte));
	
		gl_FragColor = d;
		return;
	}
}
