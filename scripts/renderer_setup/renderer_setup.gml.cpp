#include "gpu_settings.c"

#include "surface_preparation.c"

visibles = array_create(0);

shader_set(standard);
SET_UNIFORM_F("screen_ratio", window_get_height()/window_get_width())
var occlusion_info = surface_info[OCCLUSION];
SET_UNIFORM_F("a_pixel", occlusion_info[0]/window_get_width(), occlusion_info[1]/window_get_height())

uniform_sampler = shader_get_sampler_index(standard, "uniform_buffer");
uniform_buffer = buffer_create(UNIFORM_BUFFER_WIDTH*UNIFORM_BUFFER_WIDTH*6*4 ,buffer_fast, 1);

//load common texture
//common_texture = sprite_get_texture(spr_common, 0);

#ifdef SHOW_USE
//uses_uniform_buffer
#endif
