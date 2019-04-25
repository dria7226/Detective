
//change_rotation(identity, type, [amount])
var identity = argument0;
var rotation = identity[Rotation];

if(rotation == -1)
{
    log(WARNING, "Inexistent Rotation tag.", debug_get_callstack());
    return;
}


if(identity[Cached_ID] == -1)
    set_tags(identity, [Cached_ID]);







for(var i = 0; i < 3; i++)
{
    //change tag
    rotation.angle[@i] = rotation.angle[i]*argument1 + argument2[i];

    var no_of_circles = rotation.angle[i]/2/3.1415926535897932384626433832795;
    var is_negative = (no_of_circles < 0);

    no_of_circles += (is_negative*2 - 1)*floor(no_of_circles*(1 - is_negative*2)) + is_negative;

    rotation.angle[@i] = no_of_circles*2*3.1415926535897932384626433832795;
    //compress and store in [Cached_ID]
    var current = abs(identity[Cached_ID].cache[i]);
    var s = sign(identity[Cached_ID].cache[i]);
    s += (s==0);
    var angle = floor(current/100000.0);
    current = current - angle*100000.0;
    current += floor(no_of_circles*999)*100000.0;
    identity[Cached_ID].cache[@i] = current*s;
}
