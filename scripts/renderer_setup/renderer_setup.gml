format_size = 0;
vertex_format_begin();
vertex_format_add_position_3d(); format_size += 3;
vertex_format_add_color(); format_size += 1;
vertex_format_add_texcoord(); format_size += 2;
format = vertex_format_end();

gpu_set_blendenable(false);
gpu_set_tex_repeat(true);
gpu_set_ztestenable(true);
//gpu_set_tex_filter(true);
surfaces[8 - 1] = -1;
surface_texture_pointers[8 - 1] = -1;
surface_info[0] = [2,2];
surface_info[1] = [2,2];
surface_info[4] = [0.1,0.1];
surface_info[8 -1] = 0;
for(var i = 0; i < 8; i++)
{
 surfaces[i] = -1;
 if(surface_info[i] == 0) surface_info[i] = [1,1];
}
var occlusion_buffer = buffer_create(1, buffer_grow, 1);
shader_set(standard);
shader_set_uniform_f(shader_get_uniform(standard, "near_clip"), 1.0);
shader_set_uniform_f(shader_get_uniform(standard, "far_clip"), 300.0); shader_set_uniform_f(shader_get_uniform(standard, "screen_ratio"), window_get_height()/window_get_width());
var occlusion_info = surface_info[4];
shader_set_uniform_f(shader_get_uniform(standard, "a_pixel"), occlusion_info[0]/window_get_width(), occlusion_info[1]/window_get_height());
sampler_a = shader_get_sampler_index(standard, "sampler_a");
//load common texture
//common_texture = sprite_get_texture(spr_common, 0);
