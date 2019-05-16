
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
if(identity[Cached_ID] == -1)
    set_tags(identity, [Cached_ID]);
identity[Cached_ID].cache[@3] = camera.zoom;
shader_set_uniform_f(shader_get_uniform(standard, "zoom"), 1);
