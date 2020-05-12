//find camera
var camera = tags[Camera]; camera = camera[|0].back_reference;

var yaw = camera[Rotation].axes[YAW];

var change = delta_time/1000000*speed;
if keyboard_check(ord("W"))
{
    change_position(camera, CHANGE_ADD, [change*cos(yaw), change*sin(yaw), 0]);
}

if keyboard_check(ord("S"))
{
    change_position(camera, CHANGE_ADD, [-change*cos(yaw), -change*sin(yaw), 0]);
}

if keyboard_check(ord("A"))
{
	change_position(camera, CHANGE_ADD, [change*cos(yaw + pi/2), change*sin(yaw + pi/2), 0]);
}

if keyboard_check(ord("D"))
{
	change_position(camera, CHANGE_ADD, [change*cos(yaw - pi/2), change*sin(yaw - pi/2), 0]);
}

if keyboard_check(ord("M"))
{
	surface_save(surfaces[BOOLEAN_DEPTH_B], "Boolean_depth_B.png");
}

#ifdef UNIFORM_BUFFER
if keyboard_check(ord("U"))
{
	surface_save(surfaces[UNIFORM_BUFFER], "uniform_buffer.png");
}
#endif

if keyboard_check(vk_space)
{
	change_position(camera, CHANGE_ADD, [0,0,change/2]);
}

if keyboard_check(ord("C"))
{
	change_position(camera, CHANGE_ADD, [0,0,-change/2]);
}

#ifdef SHOW_USE
//uses_uniform_buffer, uses_position_tag, uses_rotation_tag
#endif
