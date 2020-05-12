alpha += delta_time/5000000;

var camera = tags[Camera]; camera = camera[|0].back_reference;

var rotation = camera[Rotation];\
change_rotation(camera, CHANGE_ADD, [0,
    (previous_y - mouse_y)/(delta_time/1000000)/4000,
    (previous_x - mouse_x)/(delta_time/1000000)/4000]);

if(rotation.axes[PITCH] > pi/2) change_rotation(camera, CHANGE_SET, [rotation.axes[ROLL], pi/2, rotation.axes[YAW]]);
if(rotation.axes[PITCH] < -pi/2) change_rotation(camera, CHANGE_SET, [rotation.axes[ROLL], -pi/2, rotation.axes[YAW]]);

//change_rotation(boolean_volume, CHANGE_SET, [alpha,alpha,alpha]);

#ifdef SHOW_USE
//uses_rotation_tag
#endif
