
//compress_model_array(array)
var array_size = array_length_1d(argument0);
if(!(array_size%(Game.format_size + 3) == 0))
{
    log(ERROR, "The model array provided has the wrong amount of elements.", debug_get_callstack()); return 0;
}
var no_of_vertices = array_size/(Game.format_size + 3);

var buffer = buffer_create(no_of_vertices*Game.format_size*4, buffer_fixed, 4);

for(var index = 0; index < no_of_vertices*(Game.format_size+3); index+=Game.format_size + 3)
{
    for(var coord = X; coord <= Z; coord++)
    {
        var vertex = argument0[index + coord];
        var s = 0;
        s = sign(vertex); s += (s==0);
        buffer_write(buffer, buffer_f32, s*(floor((argument0[index + coord + 3] + 1)/2*255.0)*10.0 + abs(vertex)));
    }

    //write color and uv
    buffer_write(buffer, buffer_f32, argument0[index + 6]);

    buffer_write(buffer, buffer_f32, argument0[index + 7]);
    buffer_write(buffer, buffer_f32, argument0[index + 8]);
}

return buffer;
