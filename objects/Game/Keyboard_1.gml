
//find camera
var camera = tags[Camera]; camera = camera[|0].back_reference;
var yaw = camera[Rotation].angle[YAW];

var change = delta_time/1000000*speed;
if keyboard_check(ord("W"))
{
    change_position(camera, 1, [change*cos(yaw), change*sin(yaw), 0]);
}

if keyboard_check(ord("S"))
{
    change_position(camera, 1, [-change*cos(yaw), -change*sin(yaw), 0]);
}

if keyboard_check(ord("A"))
{
 change_position(camera, 1, [change*cos(yaw + 3.1415926535897932384626433832795/2), change*sin(yaw + 3.1415926535897932384626433832795/2), 0]);
}

if keyboard_check(ord("D"))
{
 change_position(camera, 1, [change*cos(yaw - 3.1415926535897932384626433832795/2), change*sin(yaw - 3.1415926535897932384626433832795/2), 0]);
}

if keyboard_check(ord("M"))
{
 surface_save(surfaces[1], "MRT.png");
}
if keyboard_check(vk_space)
{
 change_position(camera, 1, [0,0,change/2]);
}
if keyboard_check(ord("C"))
{
 change_position(camera, 1, [0,0,-change/2]);
}
