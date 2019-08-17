
//change_color(identity, type, [value])
var identity = argument0;

var col = identity[Color];

if(col == -1)
{
    log(WARNING, "Inexistent Color tag.", debug_get_callstack());
    return;
}
for(var i = B; i >= R; i--)
{
    //change tag
    col.channels[@i] = col.channels[i]*argument1 + argument2[i];
}
