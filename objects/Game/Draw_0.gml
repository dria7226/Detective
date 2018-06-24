surface_set_target(surfaces[RGB]);
draw_clear(c_gray);
surface_reset_target();
surface_set_target(surfaces[OCCLUSION_DEBUG]);
draw_clear(c_gray);
surface_reset_target();
surface_set_target(surfaces[DEPTH]);
draw_clear(c_white);
surface_reset_target();

gpu_set_ztestenable(true);

shader_set(standard);
var camera_tag = tags[|Camera]; camera_tag = camera_tag[|0];
shader_set_uniform_f(shader_get_uniform(standard, "near_clip"), camera_tag.near_clip);
shader_set_uniform_f(shader_get_uniform(standard, "far_clip"), 100.0);
shader_set_uniform_f(shader_get_uniform(standard, "screen_ratio"), window_get_height()/window_get_width());

var position = tags[|Position]; position = position[|0];
var rotation = tags[|Rotation]; rotation = rotation[|0];
shader_set_uniform_f(shader_get_uniform(standard, "camera_position"), position.X, position.Y, position.Z);
shader_set_uniform_f(shader_get_uniform(standard, "camera_yaw"), rotation.yaw + alpha);
shader_set_uniform_f(shader_get_uniform(standard, "camera_pitch"), rotation.pitch);
shader_set_uniform_f(shader_get_uniform(standard, "camera_roll"), rotation.roll);


////occlusion
//var to_draw = ds_list_create();
//var occlusion_groups = tags[|Occlusion_Group]; occlusion_groups = [|0];
//occlusion_groups = tags[|List]; occlusion_groups = occlusion_groups[|combo[0]];
//surface_set_target(surfaces[OCCLUSION]);

//while(!ds_list_empty(occlusion_groups))
//{
//	//draw occlusion groups
//	draw_clear(c_white);

//	for(var i = 0; i < ds_list_size(occlusion_groups); i++)
//	{
//		var id_tags =  identities[|occlusion_groups[|i]];
//		var query = [VBO, Position, Rotation, Scale];
//		id_tags = search_tags(id_tags, query);

//		if(id_tags[0] == -1)
//			continue;
//		else
//			vbo_tag = tags[|VBO]; vbo_tag = vbo_tag[|id_tags[0]];

//		if(id_tags[1] == -1)
//			continue;
//		else
//		{
//			var position_tag = tags[|Position]; position_tag = position_tag[|id_tags[1]];
//			shader_set_uniform_f(shader_get_uniform(standard, “offset”), position_tag.X, position_tag.Y, position_tag.Z);
//		}

//		if(id_tags[2] == -1)
//		{
//			shader_set_uniform_f(shader_get_uniform(standard, “yaw”), 0.0);
//			shader_set_uniform_f(shader_get_uniform(standard, “pitch”), 0.0);
//			shader_set_uniform_f(shader_get_uniform(standard, “roll”), 0.0);
//		}
//		else
//		{
//			var rotation_tag = tags[|Rotation]; rotation_tag = rotation_tag[|id_tags[2]];
//			shader_set_uniform_f(shader_get_uniform(standard, “yaw”), rotation_tag.yaw);
//			shader_set_uniform_f(shader_get_uniform(standard, “pitch”), rotation_tag.pitch);
//			shader_set_uniform_f(shader_get_uniform(standard, “roll”), rotation_tag.roll);
//		}

//		if(id_tags[3] == -1)
//			shader_set_uniform_f(shader_get_uniform(standard, “scale”), 1.0, 1.0, 1.0);
//		else
//		{
//			scale_tag = tags[|Scale]; scale_tag = scale_tag[|id_tags[3]];
//			shader_set_uniform_f(shader_get_uniform(standard, “scale”), scale_tag.X, scale_tag.Y, scale_tag.Z);
//		}

//      //pass index and render
//      shader_set_uniform_f(shader_get_uniform(standard, “id”), i);
//		vertex_submit(vbo_tag, pr_trianglelist, -1);
//	}
	
//	//search occlusion map for visibility
//	shader_set_uniform_i(shader_get_uniform(standard, “mode”), 2);

//	draw_primitive_begin(pr_trianglelist);
//	draw_vertex(0.0, 0.0);
//	draw_vertex(2.0, 0.0);
//	draw_vertex(0.0, 2.0);
//	draw_primitive_end();

//	buffer_get_surface(occlusion_buffer, surfaces[OCCLUSION], 0, 0, 0); //formatted as BGRA
//	var occlusion_buffer_size = buffer_get_size(occlusion_buffer)/4;
//	ds_list_clear(occlusion_groups);

//	for(var i = 0; i < occlusion_buffer_size; i++)
//	{
//		var visible_index[0] = buffer_read(occlusion_buffer, buffer_f8);
//		visible_index[1] = buffer_read(occlusion_buffer, buffer_f8);
//		visible_index[2] = buffer_read(occlusion_buffer, buffer_f8);	//formatted as BGRA

//		if(	visible_index[0] == 1.0 &&
//			visible_index[1] == 1.0 &&
//			visible_index[2] == 1.0)
//			break;
//		else
//		{
//			//decode visible index
//			var index = visible_index[0] + visible_index[1]*256 + visible_index[2]*256*256;

//			//add leaves and prepare next occlusion group
//			var group = tags[|Occlusion_Group]; group = group[|index];
//			group = search_tags(identities[|group], [VBO, List]);
//			if(group[1] == -1)
//			{
//				var vbo = tags[|VBO]; vbo = vbo[|group[0]];
//				ds_list_add(to_draw, vbo);
//			}
//			else
//				for(var j = 0; j < ds_list_size(tags[List, group[1]]); j++)
//				{ var list = tags[|List]; list = list[|group[1]]; ds_list_add(occlusion_groups, list[|j]); }
//		}
//	}
//}
//surface_reset_target();

//color
surface_set_target(surfaces[RGB]);
shader_set_uniform_i(shader_get_uniform(standard, "draw_mode"), 0);

var query = [Position, Rotation, Scale, Grayscale, Color, VBO];

for(var i = 0; i < ds_list_size(tags[|Visible]); i++)
{
	var identity = tags[|Visible]; identity = identity[|i];
	var index = search_tags(identity, query);
	
	var id_tag = tags[|query[0]]; id_tag = id_tag[|index[0]]; 
	shader_set_uniform_f(shader_get_uniform(standard, "offset"), id_tag.X, id_tag.Y, id_tag.Z);
	
	id_tag = tags[|query[1]]; id_tag = id_tag[|index[1]];
	shader_set_uniform_f(shader_get_uniform(standard, "yaw"), id_tag.yaw);
	shader_set_uniform_f(shader_get_uniform(standard, "pitch"), id_tag.pitch);
	shader_set_uniform_f(shader_get_uniform(standard, "roll"), id_tag.roll);
	
	if(index[2] == -1)
		shader_set_uniform_f(shader_get_uniform(standard, "scale"), 1.0, 1.0, 1.0);
	else
	{
		id_tag = tags[|query[2]]; id_tag = id_tag[|index[2]];
	}
	
	if(index[3] == -1)
		shader_set_uniform_f(shader_get_uniform(standard, "grayscale"), 1.0);
	else
	{
		id_tag = tags[|query[3]]; id_tag = id_tag[|index[3]];
		shader_set_uniform_f(shader_get_uniform(standard, "grayscale"), id_tag);
	}
	
	id_tag = tags[|query[4]]; id_tag = id_tag[|index[4]];
	shader_set_uniform_f(shader_get_uniform(standard, "color"), id_tag.r, id_tag.g, id_tag.b);
	
	if(index[5] != -1)
	{
		id_tag = tags[|query[5]]; id_tag = id_tag[|index[5]];
		vertex_submit(id_tag, pr_trianglelist, -1);
	}
}
surface_reset_target();


//occlusion_debug
if(occlusion_debug)
{
	surface_set_target(surfaces[OCCLUSION_DEBUG]);
	shader_set_uniform_i(shader_get_uniform(standard, "draw_mode"), 3);

	var query = [Position, Rotation, Scale, Grayscale, Color, VBO];

	for(var i = 0; i < ds_list_size(tags[|Visible]); i++)
	{
		var identity = tags[|Visible]; identity = identity[|i];
		var index = search_tags(identity, query);
		
		var id_tag = tags[|query[0]]; id_tag = id_tag[|index[0]]; 
		shader_set_uniform_f(shader_get_uniform(standard, "offset"), id_tag.X, id_tag.Y, id_tag.Z);
	
		id_tag = tags[|query[1]]; id_tag = id_tag[|index[1]];
		shader_set_uniform_f(shader_get_uniform(standard, "yaw"), id_tag.yaw);
		shader_set_uniform_f(shader_get_uniform(standard, "pitch"), id_tag.pitch);
		shader_set_uniform_f(shader_get_uniform(standard, "roll"), id_tag.roll);
	
		if(index[2] == -1)
			shader_set_uniform_f(shader_get_uniform(standard, "scale"), 1.0, 1.0, 1.0);
		else
		{
			id_tag = tags[|query[2]]; id_tag = id_tag[|index[2]];
		}
	
		if(index[3] == -1)
			shader_set_uniform_f(shader_get_uniform(standard, "grayscale"), 1.0);
		else
		{
			id_tag = tags[|query[3]]; id_tag = id_tag[|index[3]];
			shader_set_uniform_f(shader_get_uniform(standard, "grayscale"), id_tag);
		}
	
		id_tag = tags[|query[4]]; id_tag = id_tag[|index[4]];
		shader_set_uniform_f(shader_get_uniform(standard, "color"), id_tag.r, id_tag.g, id_tag.b);
	
		if(index[5] != -1)
		{
			id_tag = tags[|query[5]]; id_tag = id_tag[|index[5]];
			vertex_submit(id_tag, pr_trianglelist, -1);
		}
	}
	
	//draw camera and frustrum
	shader_set_uniform_f(shader_get_uniform(standard, "offset"), position.X, position.Y, position.Z);
	shader_set_uniform_f(shader_get_uniform(standard, "scale"), 1.0, 1.0, 1.0);
	shader_set_uniform_f(shader_get_uniform(standard, "yaw"), rotation.yaw);
	shader_set_uniform_f(shader_get_uniform(standard, "pitch"), rotation.pitch);
	shader_set_uniform_f(shader_get_uniform(standard, "color"), 0.9, 0.9, 0.9);
	shader_set_uniform_f(shader_get_uniform(standard, "grayscale"), 1.0);
	var cube = tags[|VBO];
	vertex_submit(cube[|0], pr_trianglelist, -1);
	
	surface_reset_target();
}

gpu_set_ztestenable(false);

//normals from depth buffer
surface_set_target(surfaces[NORMAL]);
shader_set(normal_detection);
draw_surface(surfaces[DEPTH],0,0);
surface_reset_target();

//edges from normal buffer
surface_set_target(surfaces[EDGE]);
shader_set(edge_detection);
draw_surface(surfaces[DEPTH],0,0);
surface_reset_target();
shader_reset();

//shadow map


//black map
//gray map
//color map

//final compositing
//shader_set(compositing);
var width = surface_get_width(surfaces[NORMAL]);
var height = surface_get_height(surfaces[NORMAL]);
draw_surface_part(surfaces[RGB], 0, height/4, width, height/2, 0, 0);
draw_surface_part(surfaces[OCCLUSION_DEBUG], 0, height/4, width, height/2, 0, height/2);

draw_line(0, height/2, width, height/2);
draw_line(width/4, 5*height/8, width/4, 7*height/8);
draw_line(3*width/4, 5*height/8, 3*width/4, 7*height/8);