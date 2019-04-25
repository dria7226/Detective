//change_zoom(identity, type, value)
var identity = argument0;

var camera = identity[Camera];

if(camera == -1)
{
    log(WARNING, "Can't change zoom of something that's not a Camera.", debug_get_callstack());
    return;
}

//change tag and encode in uniform buffer
camera.zoom = camera.zoom*argument1 + argument2;

#ifdef UNIFORM_BUFFER
//derive buffer index from identity index
var buffer_index = identity[INDEX]*6*4 + 4*3 + 2*3 + 3;

buffer_poke(uniform_buffer, buffer_index, buffer_u8, floor(camera.zoom*byte));
#endif

#ifdef UNIFORM_COMPRESSION
if(identity[Cached_ID] == -1)
    set_tags(identity, [Cached_ID]);

identity[Cached_ID].cache[@3] = camera.zoom;
#endif

#ifdef SHOW_USE
//uses_identities, uses_camera_tag, uses_uniform_buffer, uses_uniform_compression
#endif
