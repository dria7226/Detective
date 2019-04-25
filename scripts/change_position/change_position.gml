
//change_position(identity, type, [amount])
var identity = argument0;

var position = identity[Position];

if(position == -1)
{
    log(WARNING, "Inexistent Position tag.", debug_get_callstack());
    return;
}


if(identity[Cached_ID] == -1)
    set_tags(identity, [Cached_ID]);







for(var i = 0; i < 3; i++)
{
    //change tag
    position.coordinates[@i] = position.coordinates[i]*argument1 + argument2[i];
    //compress and store in [Cached_ID]
    var angle = floor(abs(identity[Cached_ID].cache[i])/100000.0);
    var s = sign(position.coordinates[i]);
    s += (s==0);
    identity[Cached_ID].cache[@i] = position.coordinates[i] + angle*100000.0*s;
}
