//add_buffer_to_buffer(buffer, model_buffer, offset)

buffer_seek(argument1, buffer_seek_start,0);

var no_of_vertices = buffer_get_size(argument1)/(Game.format_size*4);

repeat(no_of_vertices)
{
 //Position 3x4 bytes
 for(i = 0; i < 3; i++)
 {
  var position = buffer_read(argument1, buffer_f32);
  var normal = position/1000.0;
  if(position < 0)
   normal = 1000.0*ceil(normal);
  else
   normal = 1000.0*floor(normal);

  position = position - normal + argument2[i];

  position = position*(abs(normal/position) + 1);

  buffer_write(argument0, buffer_f32, position);
 }

 //Color 1x4 bytes
 buffer_write(argument0, buffer_f32, buffer_read(argument1, buffer_f32));

 //Texture Coordinates 2x4 bytes
 buffer_write(argument0, buffer_f32, buffer_read(argument1, buffer_f32));
 buffer_write(argument0, buffer_f32, buffer_read(argument1, buffer_f32));
}
