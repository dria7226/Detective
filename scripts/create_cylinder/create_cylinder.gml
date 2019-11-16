
//create_cylinder(radius, height, centering, detail, slice, side_cap, end_cap, color)
//sanitize input
if(argument0 == 0) argument0 = 1;
if(argument1 == 0) argument1 = 1;

if(abs(argument0) >= 10.0) argument0 = 10.0 - 0.001;
for(var coord = 0; coord < 2; coord++)
{
    var limit = (1 + !argument2[coord])*10.0;
    if(abs(argument1) >= limit) argument1 = limit - 0.001;
}


if(array_length_1d(argument2) != 3)
    argument2 = [0,0,0];

if(argument3 < 3) argument3 = 3;

if(argument4 <= 0 || argument4 > 1) argument4 = 1;

for(var side = 0; side < 2; side++)
{
    if(argument5[side] != 0 && argument5[side] != 1) argument5[side] = 0;
    if(argument6[side] != 0 && argument6[side] != 1) argument6[side] = 0;
}

for(var channel = 0; channel < 4; channel++)
{
    if(argument7[channel] < 0 || argument7[channel] > 255)
        argument7[channel] = 0;
    else
        argument7[channel] = floor(argument7[channel]);
}


var color_buffer = buffer_create(4,buffer_fixed,1);buffer_write(color_buffer, buffer_u8, argument7[0]);buffer_write(color_buffer, buffer_u8, argument7[1]);buffer_write(color_buffer, buffer_u8, argument7[2]);buffer_write(color_buffer, buffer_u8, argument7[3]);buffer_seek(color_buffer, buffer_seek_start,0);var encoded_white = buffer_read(color_buffer, buffer_f32);buffer_delete(color_buffer);

//generate array
var array = array_create((2*(argument5[0] + argument5[1]) + ceil(argument3*argument4)*(2 + argument6[0] + argument6[1]))*3*(Game.format_size+3));
var array_index = 0;

var bottom = -argument2[Z]*argument1;
var top = bottom + argument1;

var Start = [1 - argument2[X]*argument0,0 - argument2[Y]*argument0,0];
var end_angle = 0;
for(end_angle = 2*3.1415926/argument3; ; end_angle += 2*3.1415926/argument3)
{
    if(end_angle > 2*3.1415926*argument4)
        end_angle = 2*3.1415926*argument4;

    var End = [cos(end_angle), sin(end_angle), 0];

    //end caps
    for(var z = 0; z < 2; z++)
    if(argument6[z])
    {
        Start[2] = top*(z==1) + bottom*(z==0);
        End[2] = Start[2];
        //determine triangle indices
        var triangle = [0,0,Start[2]];
        if(z==0)
            triangle = [Start, End, triangle];
        else
            triangle = [End, Start, triangle];

        //loop over vertices
        for(var index = 0; index < 3; index++)
        {
            var vertex = triangle[index];

            for(var coord = X; coord <= Z; coord++)
            {
                array[array_index++ - coord] = vertex[coord]*(argument0*(coord!=Z) + (coord==Z)) - argument2[coord]*argument0*(coord!=Z);

                array[array_index++ - coord + 2] = (coord==Z)*(z==1);
            }
            array[array_index++] = encoded_white;//color

            array[array_index++] = 0;//UVX
            array[array_index++] = 0;//UVY
        }
    }

    //side
    //determine 4 points - 2 common first
    var points = [0,0,0,0];

    points[0] = [Start[0], Start[1], top];
    points[1] = [End[0], End[1], bottom];
    points[2] = [Start[0], Start[1], bottom];
    points[3] = [End[0], End[1], top];

    //determine triangles
    var triangles = [0,0];

    triangles[0] = [points[2], points[0], points[1]];
    triangles[1] = [points[3], points[1], points[0]];

    //loop over triangles,vertices
    for(var triangle = 0; triangle < 2; triangle++)
    for(var index = 0; index < 3; index++)
    {
        var vertex = triangles[triangle];
        vertex = vertex[index];

        for(var coord = X; coord <= Z; coord++)
        {
            array[array_index++ - coord] = vertex[coord]*(argument0*(coord!=Z) + (coord==Z)) - argument2[coord]*argument0*(coord!=Z);

            array[array_index++ - coord + 2] = vertex[coord]*(coord!=Z);
        }

        array[array_index++] = encoded_white;//color

        array[array_index++] = 0;//UVX
        array[array_index++] = 0;//UVY
    }

    Start[0] = End[0];
    Start[1] = End[1];

    if(end_angle == 2*3.1415926*argument4) break;
}

//side caps
if(argument4 != 1)
{
    var points = [0,0,0,0,0,0];
    points[0] = [0,0, top];
    points[1] = [0,0, bottom];
    points[2] = [argument0, 0, top];
    points[3] = [argument0, 0, bottom]
    points[4] = [(cos(end_angle) - argument2[X])*argument0, (sin(end_angle) - argument2[Y])*argument0, top];
    points[5] = [(cos(end_angle) - argument2[X])*argument0, (sin(end_angle) - argument2[Y])*argument0, bottom];

    var normals = [0,0];
    normals[0] = [0,1,0];
    normals[1] = [cos(end_angle - 3.1415926/2), sin(end_angle - 3.1415926/2),0];

    var triangles = [0,0,0,0];
    triangles[0] = [points[0], points[2], points[3]];
    triangles[2] = [points[0], points[3], points[1]];
    triangles[1] = [points[0], points[5], points[4]];
    triangles[3] = [points[0], points[1], points[5]];

    for(var triangle = 0; triangle < 4; triangle++)
    for(var index = 0; index < 3; index++)
    if(argument5[triangle%2])
    {
        var vertex = triangles[triangle];
        vertex = vertex[index];

        for(var coord = X; coord <= Z; coord++)
        {
            var normal = normals[triangle%2];
            normal = normal[coord];

            array[array_index++ - coord] = vertex[coord];
            array[array_index++ - coord + 2] = normal;
        }
        array[array_index++] = encoded_white;//color

        array[array_index++] = 0;//UVX
        array[array_index++] = 0;//UVY
    }
}

return array;
