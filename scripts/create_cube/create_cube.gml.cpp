//create_cube(size, centering, color)
#ifdef SANITIZE_PROCEDURAL_INPUT
//sanitize inputs
if(array_length_1d(argument0) != 3)
{
    argument0 = [1,1,1];
    argument1 = [0,0,0];
}
#ifdef NORMAL_COMPRESSION
else
{
    for(var coord = 0; coord < 3; coord++)
    {
        var limit = (1 + !argument1[coord])*COMPRESSED_NORMAL_POSITION;
        if(argument0[coord] >= limit) argument0[coord] = limit - 0.01;
    }
}
#endif

for(var channel = 0; channel < 4; channel++)
{
    if(argument2[channel] < 0 || argument2[channel] > 255)
        argument2[channel] = 0;
    else
        argument2[channel] = floor(argument2[channel]);
}
#endif

ENCODE_COLOR(encoded_color, argument2[0], argument2[1], argument2[2], argument2[3])

//generate array
var array = array_create(6*2*3*(Game.format_size + 3));

var points = array_create(8);
points[0] = [0,0,0];
points[1] = [argument0[0],0,0];
points[2] = [0,argument0[1],0];
points[3] = [argument0[0],argument0[1],0];
for(var i = 0; i < 4; i++)
{
    var point = points[i];
    points[4+i] = [point[0], point[1], argument0[2]];
}

//center points
for(var i = 0; i < 8; i++)
{
    var point = points[i];
    for(var axis = X; axis <= Z; axis++)
    point[@axis] -= argument0[axis]*argument1[axis];
}

var triangles = array_create(12);
triangles[0] = [0,2,4];
triangles[1] = [2,6,4];
triangles[2] = [1,5,3];
triangles[3] = [3,5,7];
triangles[4] = [0,4,1];
triangles[5] = [1,4,5];
triangles[6] = [2,3,6];
triangles[7] = [3,7,6];
triangles[8] = [0,1,2];
triangles[9] = [1,3,2];
triangles[10] = [4,6,5];
triangles[11] = [5,6,7];

var array_index = 0;

//loop over triangles
for(var axis = 0; axis < 3; axis++)
{
    for(var side = 0; side < 2; side++)
    for(var pair = 0; pair < 2; pair++)
    {
        var triangle = triangles[axis*4 + pair + 2*side];
        //loop over vertices
        for(var index = 0; index < 3; index++)
        {
            var vertex = points[triangle[index]];
            for(var coord = X; coord <= Z; coord++)
            {
                array[array_index++ - coord] = vertex[coord];

                array[array_index++ - coord + 2] =  (coord==axis)*(2*side - 1);
            }

            array[array_index++] = encoded_color;//color

            array[array_index++] = 0;//UVX
            array[array_index++] = 0;//UVY
        }
    }
}
return array;
