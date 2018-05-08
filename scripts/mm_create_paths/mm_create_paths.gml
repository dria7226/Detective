main_menu_path = instance_create_depth(0,0,0,Path);

{
	var start = [-1.5,1.0,0.5];
	var middle = [0.0,-1.5,0.5];
	var finish = [0.0,1.0,1.5];
	
	var segment = [start,middle,finish,0];
	ds_list_add(main_menu_path.segments, segment);
}

{
	var start = [0.0,1.0,1.5];
	var middle = [0.0,-1.5,0.5];
	var finish = [-1.5,1.0,0.5];
	
	var segment = [start,middle,finish,0];
	ds_list_add(main_menu_path.segments, segment);
}

approximate_path_length(main_menu_path, 10);