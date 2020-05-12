#include "gpu_settings.c"

#include "surface_preparation.c"

visibles = array_create(0);

shader_set(standard);

#ifdef CACHE_UNIFORMS
#include "uniform_cache.c"
#endif

window_size = [window_get_width(), window_get_height()];
SET_UNIFORM_F(screen_ratio, window_size[1]/window_size[0])
SET_UNIFORM_F(a_pixel, 1/window_size[0], 1/window_size[1])

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
