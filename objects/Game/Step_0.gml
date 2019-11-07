
alpha += delta_time/5000000;
var camera = tags[Camera]; camera = camera[|0].back_reference;

var rotation = camera[Rotation];change_rotation(camera, 1, [0,

    (previous_y - mouse_y)/(delta_time/1000000)/4000,
    (previous_x - mouse_x)/(delta_time/1000000)/4000]);

if(rotation.axes[PITCH] > 3.1415926/2) change_rotation(camera, 0, [rotation.axes[ROLL], 3.1415926/2, rotation.axes[YAW]]);
if(rotation.axes[PITCH] < -3.1415926/2) change_rotation(camera, 0, [rotation.axes[ROLL], -3.1415926/2, rotation.axes[YAW]]);
