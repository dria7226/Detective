#include "check_surfaces.txt"

#include "update_uniform_buffer.txt"

alpha += delta_time/5000000;

var rotation = tags[|Rotation]; rotation = rotation[|0];
rotation.yaw += (previous_x - mouse_x)/(delta_time/1000000)/4000;
rotation.pitch += (previous_y - mouse_y)/(delta_time/1000000)/4000;
if(rotation.pitch > pi/2) rotation.pitch = pi/2;
if(rotation.pitch < -pi/2) rotation.pitch = -pi/2;

//var index = tags[|Rotation]; index = index[|6];
//index.yaw = alpha*2;
