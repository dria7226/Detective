
//change_position(identity, type, [amount])
var identity = argument0;

var position = identity[Position];

if(position == -1)
{
    log(WARNING, "Inexistent Position tag.", debug_get_callstack());
    return;
}
for(var i = 0; i < 3; i++)
{
    //change tag
    position.coordinates[@i] = position.coordinates[i]*argument1 + argument2[i];
}
