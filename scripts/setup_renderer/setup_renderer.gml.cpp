#include "gpu_settings.c"

#include "surface_preparation.c"

visibles = array_create(0);

shader_set(standard);

#ifdef CACHE_UNIFORMS
#include "uniform_cache.c"
#endif

SET_UNIFORM_F(screen_ratio, window_get_height()/window_get_width())
var occlusion_info = surface_info[OCCLUSION];
SET_UNIFORM_F(a_pixel, occlusion_info[0]/window_get_width(), occlusion_info[1]/window_get_height())

#ifdef UNIFORM_BUFFER
uniform_buffer = buffer_create(UNIFORM_BUFFER_WIDTH*UNIFORM_BUFFER_WIDTH*6*4 ,buffer_fast, 1);
#endif

#ifndef UNIFORM_BUFFER
#ifndef UNIFORM_COMPRESSION
default_offset = [0,0,0];
default_angle = [0,0,0];
default_color = [0.5,0.5,0.5,1.0];
#endif
#endif

//load common texture
//common_texture = sprite_get_texture(spr_common, 0);

#ifdef SHOW_USE
//uses_uniform_buffer, uses_uniform_compression
#endif
