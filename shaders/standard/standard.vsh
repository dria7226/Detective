attribute vec3 in_Position;                 // (x,y,z)
attribute vec4 in_Color;					// (r,g,b)

uniform int draw_mode;
#define COLOR_MODE 0
#define DEPTH_MODE 1
#define OCCLUSION_MODE 2
#define OCCLUSION_DEBUG_MODE 3
#define pi 3.1415926535897932384626433832795

varying float depth;
varying vec4 out_Color;

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
		if(draw_mode == OCCLUSION_DEBUG_MODE)
		{
			vec3 debug_offset = vec3(10.0, 0.0, 0.0);
			debug_offset.z = debug_offset.x/2.0;
			rotate(debug_offset.xy, camera_pitch - pi/2.0);
			local -= debug_offset;
		}
		local -= camera_position;
		
		rotate(local.xy, -camera_yaw);
		if(draw_mode == OCCLUSION_DEBUG_MODE)
			rotate(local.xy, -3.0*pi/8.0);
			
		rotate(local.xz, -camera_pitch);
		if(draw_mode == OCCLUSION_DEBUG_MODE)
			rotate(local.xz, 0.46);
		
		if(draw_mode != OCCLUSION_DEBUG_MODE)
			rotate(local.yz, -camera_roll);
		
		

		//project
		gl_Position.z = length(local.xyz)/far_clip;

		if(local.x <= 0.0)
		gl_Position.xy = local.yz*100.0;
		else
		gl_Position.xy = local.yz/local.x*near_clip;
	
		gl_Position.x *= -screen_ratio;

		gl_Position.w = 1.0;

		depth = gl_Position.z;
		if(grayscale == 1.0)
			out_Color = in_Color;
		else
		{
			vec3 intensity = (in_Color.rgb + in_Color.gbr + in_Color.bgr)/3.0;
			out_Color = vec4(intensity + (in_Color.rgb - intensity)*grayscale, 1.0) ;
		}
		
		if(out_Color == vec4(1.0))
		{
			out_Color *= vec4(color, 1.0);
		}
}

void rotate(inout vec2 point, float angle)
{
  float X = cos(angle)*point.x - sin(angle)*point.y;
  point.y = cos(angle)*point.y + sin(angle)*point.x;
  point.x = X;
}


