
//change_grayscale(identity, type, value)
var identity = argument0;

var color = identity[Color];

if(color == -1)
{
    log(WARNING, "Inexistent Color tag.", debug_get_callstack());
    return;
}

//change tag and encode in uniform buffer
color.channels[GS] = color.channels[GS]*argument1 + argument2;
