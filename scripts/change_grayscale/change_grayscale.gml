
//change_grayscale(identity, type, value)
var identity = argument0;

var gs = identity[Grayscale];

if(gs == -1)
{
    log(WARNING, "Inexistent Grayscale tag.", debug_get_callstack());
    return;
}

//change tag and encode in uniform buffer
gs.value = gs.value*argument1 + argument2;
if(identity[Cached_ID] == -1)
    set_tags(identity, [Cached_ID]);
identity[Cached_ID].cache[@3] = floor(identity[Cached_ID].cache[3]*1000*1000);
identity[Cached_ID].cache[@3] += floor(gs.value*255.0)/1000;
identity[Cached_ID].cache[@3] /= 1000*1000;
