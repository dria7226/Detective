
//add_buffer_to_vbo(buffer, model_buffer, offset)
buffer_seek(argument1, buffer_seek_start, 0);
for(var i = 0; i < buffer_get_size(argument1)/Game.format_size; i+=Game.format_size)
{
 var vertex = [0,0,0];
 for(i = 0; i < 3; i++)
 {
  var position = buffer_read(argument1, buffer_f32);
  var normal = position/1000;
  if(position < 0)
   normal = 1000*ceil(normal);
  else
   normal = 1000*floor(normal);
  position = position - normal + argument2[i];
  var s = sign(position);
  s += (s == 0);
  position += s*abs(normal);
  vertex[i] = position;
 }
 vertex_position_3d(argument0, vertex[0], vertex[1], vertex[2]);
 vertex_color(argument0,
     make_color_rgb(buffer_read(argument1, buffer_f32),
        buffer_read(argument1, buffer_f32),
        buffer_read(argument1, buffer_f32)),
        buffer_read(argument1, buffer_f32));
 vertex_texcoord(argument0, buffer_read(argument1, buffer_f32),
        buffer_read(argument1, buffer_f32));
}
