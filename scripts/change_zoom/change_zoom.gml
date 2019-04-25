
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
