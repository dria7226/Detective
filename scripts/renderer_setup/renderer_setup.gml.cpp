#include "gpu_settings.txt"

#include "surface_preparation.txt"

shader_set(standard);

SET_UNIFORM_F("near_clip", 1.0)
SET_UNIFORM_F("far_clip", MAXIMUM_VIEW_DISTANCE) SET_UNIFORM_F("screen_ratio", window_get_height()/window_get_width())
var occlusion_info = surface_info[OCCLUSION];
SET_UNIFORM_F("a_pixel", occlusion_info[0]/window_get_width(), occlusion_info[1]/window_get_height())

sampler_a = shader_get_sampler_index(standard, "sampler_a");

//load common texture
//common_texture = sprite_get_texture(spr_common, 0);
