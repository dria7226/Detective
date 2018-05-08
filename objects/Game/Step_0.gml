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
	
//main_menu_camera.pitch = track_rotation[0];
//main_menu_camera.yaw = track_rotation[1];
//main_menu_camera.roll = (1 - progress) * pi/3;

//progress += dir*delta_time/1000000/10;