attribute vec2 in_TexCoord;		// (u,v)
attribute vec3 in_Position;		// (x,y,z)
attribute vec4 in_Color;		// (r,g,b)

uniform int mode;
#define COLOR_MODE 0
#define DEPTH_MODE 1

#define OCCLUSION_DEBUG_MODE 20
#define pi 3.1415926535897932384626433832795

varying float depth;
varying vec4 out_Color;
varying vec2 out_TexCoord;

uniform int id;

uniform vec3 offset;
uniform vec3 scale;
uniform vec3 camera_position;
uniform float camera_yaw, camera_pitch, camera_roll;
uniform float yaw, pitch, roll;
uniform float grayscale;
uniform vec3  color;
uniform float near_clip;
uniform float far_clip;
uniform float screen_ratio;

void rotate(inout vec2 point, float angle);

void main()
{
	vec3 local = in_Position*scale;
		
	rotate(local.xy, yaw);
	rotate(local.xz, pitch);
	rotate(local.yz, roll);
		
	local += offset;

	//camera transformation
	if(mode == OCCLUSION_DEBUG_MODE)
	{
		vec3 debug_offset = vec3(10.0, 0.0, 0.0);
		debug_offset.z = debug_offset.x/2.0;
		rotate(debug_offset.xy, camera_yaw - pi/2.0);
		local -= debug_offset;
	}
	local -= camera_position;
		
	rotate(local.xy, -camera_yaw);
	if(mode == OCCLUSION_DEBUG_MODE)
		rotate(local.xy, -3.0*pi/8.0);
			
	rotate(local.xz, -camera_pitch);
	if(mode == OCCLUSION_DEBUG_MODE)
		rotate(local.xz, 0.46);
		
	if(mode != OCCLUSION_DEBUG_MODE)
		rotate(local.yz, -camera_roll);

	//project
	gl_Position.z = length(local.xyz)/far_clip;

	gl_Position.xy = local.yz;

	if(local.x <= 0.0)
		gl_Position.z = -1.0;
	else
		gl_Position.xy = gl_Position.xy/local.x*near_clip;
	
	gl_Position.x *= -screen_ratio;

	gl_Position.w = 1.0;

	depth = gl_Position.z;
		
	out_Color = in_Color;
	
	if(in_TexCoord == vec2(0.0))
	{
		if(out_Color == vec4(1.0))
			out_Color *= vec4(color, 1.0);
		
		if(grayscale != 1.0)
		{
			vec3 intensity = (out_Color.rgb + out_Color.gbr + out_Color.brg)/3.0;
			out_Color = vec4(intensity + (out_Color.rgb - intensity)*grayscale, 1.0);
		}
	}
	
	out_TexCoord = in_TexCoord;
}

void rotate(inout vec2 point, float angle)
{
  float X = cos(angle)*point.x - sin(angle)*point.y;
  point.y = cos(angle)*point.y + sin(angle)*point.x;
  point.x = X;
}


