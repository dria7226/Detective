surface_set_target(surfaces[RGB]);
draw_clear(c_gray);
surface_reset_target();
surface_set_target(surfaces[DEPTH]);
draw_clear(c_white);
surface_reset_target();

gpu_set_ztestenable(true);

shader_set(standard);
var camera_tag = tags[Camera, 0];
shader_set_uniform_f(shader_get_uniform(standard, "near_clip"), camera_tag.near_clip);
shader_set_uniform_f(shader_get_uniform(standard, "far_clip"), 100.0);
shader_set_uniform_f(shader_get_uniform(standard, "screen_ratio"), window_get_height()/window_get_width());

var position = tags[Position, 0];
var rotation = tags[Rotation, 0];
shader_set_uniform_f(shader_get_uniform(standard, "camera_position"), position.X, position.Y, position.Z);
shader_set_uniform_f(shader_get_uniform(standard, "camera_pitch"), rotation.pitch + alpha);
shader_set_uniform_f(shader_get_uniform(standard, "camera_yaw"), rotation.yaw);
shader_set_uniform_f(shader_get_uniform(standard, "camera_roll"), rotation.roll);


////occlusion
//var occlusion_groups = tags[Occlusion_Group, 0];
//for(;occlusion_groups != 0;)
//{
//	//draw occlusion groups
//	surface_set_target(surfaces[OCCLUSION]);
//draw_clear(c_white);

//	for(var i = 0; i < array_length_1d(occlusion_groups); i++)
//	{
//		var vbo_tag =  identities[|occlusion_groups[i]];
//		vbo_tag = vbo_tag.tag_list[|0];
//		vbo_tag =  tags[VBO, vbo_tag[1]];
//        //encode index into color
//        shader_set_uniform_f(shader_get_uniform(standard, “color”), i);
//		vertex_submit(vbo_tag, pr_trianglelist, -1);
//	}
//	surface_reset_target();
	
//	//search occlusion map for visibility
//shader_set_uniform_i(shader_get_uniform(standard, “mode”), 2);

//vertex_submit(fullscreen_mesh, pr_trianglelist, -1);

//var visible_indices = 0;
//var occlusion_witdh = surfaces_get_width(surfaces[OCCLUSION]);
//var occlusion_height = surfaces_get_height(surfaces[OCCLUSION]);
//for(var i = 0; i < occlusion_width*occlusion_height; i++)
//{
//    visible_indices[i] = surface_getpixel(surfaces[OCCLUSION], i % occlusion_width, i / occlusion_width);

//}
	
//	//add leaves and prepare next occlusion group
//	occlusion_groups = 0;
	
//}

////color
surface_set_target(surfaces[RGB]);
shader_set_uniform_i(shader_get_uniform(standard, "draw_mode"), 0);

var query = [Position, Rotation, Grayscale, Color, VBO];

for(var i = 0; i < array_length_2d(tags, Visible); i++)
{
	var identity = tags[Visible, i];
	var index = search_tags(identity, query);
	shader_set_uniform_f(shader_get_uniform(standard, "offset"), tags[query[0], index[0]].X, tags[query[0], index[0]].Y, tags[query[0], index[0]].Z);
	shader_set_uniform_f(shader_get_uniform(standard, "scale"), 1.0, 1.0, 1.0);
	shader_set_uniform_f(shader_get_uniform(standard, "object_pitch"), tags[query[1], index[1]].pitch);
	shader_set_uniform_f(shader_get_uniform(standard, "object_yaw"), tags[query[1], index[1]].yaw);
	shader_set_uniform_f(shader_get_uniform(standard, "color"), tags[query[3], index[3]].r, tags[query[3], index[3]].g, tags[query[3], index[3]].b);
	shader_set_uniform_f(shader_get_uniform(standard, "grayscale"), 1.0);
	if(tags[query[4], index[4]] != -1)
	{
		vertex_submit(tags[query[4], index[4]], pr_trianglelist, -1);
	}
}
surface_reset_target();

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
draw_surface_part(surfaces[RGB], 0,0, width, height, 0,0);
//draw_surface_part(surfaces[NORMAL],  width/2,0, width/2, height, width/2,0);

