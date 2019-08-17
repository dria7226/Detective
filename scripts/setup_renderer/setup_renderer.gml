
format_size = 0;
vertex_format_begin();
vertex_format_add_position_3d(); format_size += 3;
vertex_format_add_color(); format_size += 1;
vertex_format_add_texcoord(); format_size += 2;
format = vertex_format_end();
gpu_set_blendenable(false);
gpu_set_tex_repeat(true);
gpu_set_ztestenable(true);
gpu_set_cullmode(cull_counterclockwise);
surfaces[9 - 1] = -1;
surface_texture_pointers[9 - 1] = -1;
surface_info[1] = [2,2];
surface_info[2] = [2,2];
surface_info[7] = [0.1,0.1];
surface_info[9 -1] = 0;
for(var i = 0; i < 9; i++)
{
 surfaces[i] = -1;
 if(surface_info[i] == 0) surface_info[i] = [1,1];
}
var occlusion_buffer = buffer_create(1, buffer_grow, 1);
visibles = array_create(0);
shader_set(standard);
in_camera_position = shader_get_uniform(standard, "in_camera_position");
in_camera_angle = shader_get_uniform(standard, "in_camera_angle");
zoom = shader_get_uniform(standard, "zoom");
vertex_mode = shader_get_uniform(standard, "vertex_mode");
fragment_mode = shader_get_uniform(standard, "fragment_mode");
a_pixel = shader_get_uniform(standard, "a_pixel");
screen_ratio = shader_get_uniform(standard, "screen_ratio");
object_id = shader_get_uniform(standard, "object_id");
in_offset = shader_get_uniform(standard, "in_offset");
in_angle = shader_get_uniform(standard, "in_angle");
in_color = shader_get_uniform(standard, "in_color");
shader_set_uniform_f(screen_ratio, window_get_height()/window_get_width());
var occlusion_info = surface_info[7];
shader_set_uniform_f(a_pixel, occlusion_info[0]/window_get_width(), occlusion_info[1]/window_get_height());
default_offset = [0,0,0];
default_angle = [0,0,0];
default_color = [0.5,0.5,0.5,1.0];
//load common texture
//common_texture = sprite_get_texture(spr_common, 0);
