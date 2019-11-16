
//create_sphere(radius, detail, slice, centering, color)
//sanitize inputs
if(array_length_1d(argument3) != 3)
    argument3 = [0,0,0];
else for(var coord = 0; coord < 3; coord++)
    if(argument3[coord] != 0 || argument3[coord] != 1)
        argument3[coord] = 0;

if(argument0 == 0) argument0 = 1;


if(argument0 >= 10.0) argument0 = 10.0 - 0.01;


if(argument1 < 3) argument1 = 3;

argument2 = 0;

for(var channel = 0; channel < 4; channel++)
{
    if(argument4[channel] < 0 || argument4[channel] > 255)
        argument4[channel] = 0;
    else
        argument4[channel] = floor(argument4[channel]);
}


//generate buffer
var array = array_create((argument1*(argument1-2) + 2)*(Game.format_size + 3));
var array_index = 0;

var yaw_increment = 3.1415926/argument1;
var pitch_increment = 2*3.1415926/argument1;

var Start = [0,0];
Start[0] = [1 - argument3[X]*argument0,0 - argument3[Y]*argument0,0];
var start_angle = [0,0];
var end_angle = [0,0];
end_angle[0] = yaw_increment;
for(;; end_angle[0] += yaw_increment)
{
    if(start_angle[0] > 2*3.1415926*argument2[0])
        start_angle[0] = 2*3.1415926*argument2[0];

    var End = [0,0];
    End[0] = [cos(end_angle[0]), sin(end_angle[0]), 0];

    // start[1] = ???;
    start_angle[1] = 0;
    end_angle[1] = 3.1415926/argument1;

    for(;; end_angle[1] += 3.1415926/argument1)
    {
        if(start_angle[1] > 2*3.1415926*argument2[1])
            start_angle[1] = 2*3.1415926*argument2[1];

        // end[1] = [cos(end_angle[1]), sin(end_angle[1])];???

        //bottom
        if(end_angle[1] <= 3.1415926/argument1)
        {

            continue;
        }

        //top
        if(end_angle[1] > 3.1415926*(1 - 1/argument1))
        {

            continue;
        }

        //middle


        var pitch_end = End[1];
        Start[@1] = [pitch_end[0], pitch_end[1]];

        if(end_angle == 2*3.1415926*argument2[1]) break;
    }

    var yaw_end = End[0];
    Start[@0] = [yaw_end[0], yaw_end[1]];

    if(end_angle == 2*3.1415926*argument2[0]) break;
}


return array;
