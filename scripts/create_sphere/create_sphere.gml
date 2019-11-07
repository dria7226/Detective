
//create_sphere(radius, detail, slice, centering)
//sanitize inputs
if(array_length_1d(argument3) != 3)
    argument3 = [0,0,0];
else for(var coord = 0; coord < 3; coord++)
    if(argument3[coord] != 0 || argument3[coord] != 1)
        argument3[coord] = 0;

if(argument0 == 0) argument0 = 1;


if(argument0 >= 10.0) argument0 = 10.0 - 0.01;


if(argument1 < 3) argument1 = 3;

//for(var coord = 0; coord < 3; coord++)
//    if(argument0[coord] >= limit) argument0[coord] = limit - 0.01;//slice

//generate buffer
var buffer = buffer_create(4, buffer_fixed, 4);

argument2 = 0;

return buffer;
