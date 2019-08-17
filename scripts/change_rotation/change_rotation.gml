
//change_rotation(identity, type, [amount])
var identity = argument0;
var rotation = identity[Rotation];

if(rotation == -1)
{
    log(WARNING, "Inexistent Rotation tag.", debug_get_callstack());
    return;
}
for(var i = 0; i < 3; i++)
{
    //change tag
    rotation.axes[@i] = rotation.axes[i]*argument1 + argument2[i];
}
