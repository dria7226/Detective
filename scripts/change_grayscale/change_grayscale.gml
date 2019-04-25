
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
