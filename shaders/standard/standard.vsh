attribute vec3 in_Position;                 // (x,y,z)
attribute vec4 in_Color;					// (r,g,b)

#define COLOR_MODE 1.0
#define DEPTH_MODE 2.0

varying float depth;
varying vec4 out_Color;

uniform vec3 offset;
uniform vec3 scale;
uniform vec3 camera_position;
uniform float camera_yaw, camera_pitch, camera_roll;
uniform float object_yaw, object_pitch;
uniform float grayscale;
uniform vec3  color;
uniform float near_clip;
uniform float far_clip;
uniform float screen_ratio;

void rotate(inout vec2 point, float angle);

void main()
{
		vec3 local = in_Position*scale;
		
		rotate(local.xy, object_pitch);
		rotate(local.xz, object_yaw);
		
		local += offset;

		//camera transformation
		local -= camera_position;

		rotate(local.xy, -camera_pitch);
		rotate(local.xz, -camera_yaw);
		rotate(local.yz, -camera_roll);

		//project
		gl_Position.z = length(local.xyz)/far_clip;

		if(local.x <= 0.0)
		gl_Position.xy = local.yz*100.0;
		else
		gl_Position.xy = local.yz/local.x*near_clip;
	
		gl_Position.x *= screen_ratio;

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
  float X = sin(angle)*point.y - cos(angle)*point.x;
  point.y = cos(angle)*point.y + sin(angle)*point.x;
  point.x = X;
}


