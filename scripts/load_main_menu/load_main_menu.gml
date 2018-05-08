//NOTE: EVERYTHING NEEDS TO BE TAGGED AS DELETE PROTECTED

mm_create_paths();

main_menu_camera = instance_create_depth(0,0,0,Camera);

//generate detective office

//compute occlusion for static objects

//build vbos for static occlusion groups and non-static objects
for(var i = 0; i < ds_list_size(Game.model_list); i++)
{
	var object = instance_create_layer(0,0,0,Object);
	object.model = Game.model_list[|i];
	object.static = false;
	object.vbo = ds_list_size(vbo_list);
	
	ds_list_add(Game.object_list, object)
	ds_list_add(Game.occlusion_list, i);
	var model = object.model;
	ds_list_add(Game.vbo_list, vertex_create_buffer_from_buffer(model.buffer, Game.format));
}

var lamp = Game.object_list[|4];
lamp.y = 2.0;