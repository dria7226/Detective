//decompress_model(buffer)
var buffer_size = buffer_get_size(argument0);
var array = array_create(buffer_size + buffer_size/Game.format_size*3);

//go over every vertex
var no_of_vertices = buffer_size/(Game.format_size*4);

for(var index = 0; index < no_of_vertices; index += Game.format_size)
{
    //decompress position
    for(var coord = X; coord <= Z; coord++)
    {
        var position = buffer_read(argument0, buffer_f32);
        var normal = position/COMPRESSED_NORMAL_POSITION;
		normal = (ceil(normal)*(position<0) + floor(normal)*(position>=0))*COMPRESSED_NORMAL_POSITION;

        array[index*(Game.format_size + 3) + coord] = position - normal;
        array[index*(Game.format_size + 3) + coord + 3] = abs(normal);
    }

    //copy color and uv
    array[vertex*(Game.format_size + 3) + 6] = buffer_read(argument0, buffer_f32);

    array[vertex*(Game.format_size + 3) + 7] = buffer_read(argument0, buffer_f32);
    array[vertex*(Game.format_size + 3) + 8] = buffer_read(argument0, buffer_f32);
}

return array;
