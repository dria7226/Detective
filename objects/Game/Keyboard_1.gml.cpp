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
	position.X += delta_time/1000000*speed*cos(yaw + pi/2);
	position.Y += delta_time/1000000*speed*sin(yaw + pi/2);
}

if keyboard_check(ord("D"))
{
	position.X += delta_time/1000000*speed*cos(yaw - pi/2);
	position.Y += delta_time/1000000*speed*sin(yaw - pi/2);
}

if keyboard_check(ord("M"))
{
	surface_save(surfaces[MRT], "MRT.png");
}

if keyboard_check(ord("U"))
{
	surface_save(surfaces[UNIFORM_BUFFER], "uniform_buffer.png");
}

if keyboard_check(vk_space)
{
	position.Z += delta_time/1000000*speed/2;
}

if keyboard_check(ord("C"))
{
	position.Z -= delta_time/1000000*speed/2;
}
