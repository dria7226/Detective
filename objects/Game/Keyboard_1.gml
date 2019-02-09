
var position = tags[|Position]; position = position[|0];
var yaw = tags[|Rotation]; yaw = yaw[|0]; yaw = yaw.yaw;
if keyboard_check(ord("W"))
{
 position.X += delta_time/1000000*speed*cos(yaw);
 position.Y += delta_time/1000000*speed*sin(yaw);
}

if keyboard_check(ord("S"))
{
 position.X -= delta_time/1000000*speed*cos(yaw);
 position.Y -= delta_time/1000000*speed*sin(yaw);
}

if keyboard_check(ord("A"))
{
 position.X += delta_time/1000000*speed*cos(yaw + 3.1415926535897932384626433832795/2);
 position.Y += delta_time/1000000*speed*sin(yaw + 3.1415926535897932384626433832795/2);
}

if keyboard_check(ord("D"))
{
 position.X += delta_time/1000000*speed*cos(yaw - 3.1415926535897932384626433832795/2);
 position.Y += delta_time/1000000*speed*sin(yaw - 3.1415926535897932384626433832795/2);
}

if keyboard_check(ord("M"))
{
 surface_save(surfaces[1], "MRT.png");
}

if keyboard_check(ord("U"))
{
 surface_save(surfaces[0], "uniform_buffer.png");
}

if keyboard_check(vk_space)
{
 position.Z += delta_time/1000000*speed/2;
}

if keyboard_check(ord("C"))
{
 position.Z -= delta_time/1000000*speed/2;
}
