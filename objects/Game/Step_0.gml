
alpha += delta_time/5000000;
var camera = tags[Camera]; camera = camera[|0].back_reference;

var rotation = camera[Rotation];change_rotation(camera, 1, [0,

    (previous_y - mouse_y)/(delta_time/1000000)/4000,
    (previous_x - mouse_x)/(delta_time/1000000)/4000]);

if(rotation.angle[PITCH] > 3.1415926535897932384626433832795/2) change_rotation(camera, 0, [rotation.angle[ROLL], 3.1415926535897932384626433832795/2, rotation.angle[YAW]]);
if(rotation.angle[PITCH] < -3.1415926535897932384626433832795/2) change_rotation(camera, 0, [rotation.angle[ROLL], -3.1415926535897932384626433832795/2, rotation.angle[YAW]]);
