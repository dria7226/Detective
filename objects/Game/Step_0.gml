
alpha += delta_time/5000000;
var camera = tags[Camera]; camera = camera[|0].back_reference;

var rotation = camera[Rotation];change_rotation(camera, 1, [0,

    (previous_y - mouse_y)/(delta_time/1000000)/4000,
    (previous_x - mouse_x)/(delta_time/1000000)/4000]);

if(rotation.angle[PITCH] > 3.1415926535897932384626433832795/2) change_rotation(camera, 0, [rotation.angle[ROLL], 3.1415926535897932384626433832795/2, rotation.angle[YAW]]);
if(rotation.angle[PITCH] < -3.1415926535897932384626433832795/2) change_rotation(camera, 0, [rotation.angle[ROLL], -3.1415926535897932384626433832795/2, rotation.angle[YAW]]);

//if(progress > 1.0)
//{
//	dir = -1;
//	progress = 1.0;
//}

//if(progress < 0.0)
//{
//	dir = 1;
//	progress = 0.0;
//}

//var point = get_point_on_path(main_menu_path, progress);

//main_menu_camera.position[0] = point[0];
//main_menu_camera.position[1] = point[1];
//main_menu_camera.position[2] = point[2];

//var track_rotation = point_direction_3d(main_menu_camera.position, [0.0,2.0,0.0]);

//progress += dir*delta_time/1000000/10;
