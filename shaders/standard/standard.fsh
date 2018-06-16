varying float depth;
varying vec4 out_Color;

uniform int draw_mode;
uniform int id;

#define COLOR_MODE 0
#define DEPTH_MODE 1
#define OCCLUSION_MODE 2
#define OCCLUSION_DEBUG_MODE 3

#define byte 256.0

void main()
{	
	if(draw_mode == COLOR_MODE || draw_mode == OCCLUSION_DEBUG_MODE)
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
	
	if(draw_mode == OCCLUSION_MODE)
	{
		gl_FragColor = vec4(id/(byte*byte) - id/byte, id/byte - id%byte, id%byte, 1.0);
		return;
	}
}
