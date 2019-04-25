
//change_color(identity, type, [value])
var identity = argument0;

var col = identity[Color];

if(col == -1)
{
    log(WARNING, "Inexistent Color tag.", debug_get_callstack());
    return;
}
if(identity[Cached_ID] == -1)
    set_tags(identity, [Cached_ID]);
identity[Cached_ID].cache[@3] -= identity[Cached_ID].cache[3]%255;
var position = 1000*1000*1000;
for(var i = 0; i < 3; i++)
{
    //change tag
    col.channels[@i] = col.channels[i]*argument1 + argument2[i];
    identity[Cached_ID].cache[@3] += floor(col.channels[i]*255.0)*position;
    position /= 1000;
}
