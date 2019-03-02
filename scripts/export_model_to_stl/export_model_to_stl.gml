
//export_model_to_stl(model, filename)
//BUG: last vertex is always zero
var model_size = buffer_get_size(argument0)/Game.format_size/4/3; //# of triangles
buffer_seek(argument0, buffer_seek_start, 0);
var stl_buffer = buffer_create(84 + model_size*(2 + 4*3*4), buffer_fixed, 1);
//write header
repeat(80) buffer_write(stl_buffer, buffer_u8, 0);
buffer_write(stl_buffer, buffer_u32, model_size);
//write triangles
for(var triangle = 0; triangle < model_size; triangle++)
{
 var normal = [0,0,0];
 var vertices = [[0,0,0], [0,0,0], [0,0,0]];
 for(var vertex = 0; vertex < 3; vertex++)
 {
  var current_normal = [0,0,0];
  for(var coord = 0; coord < 3; coord++)
  {
   var position = buffer_read(argument0, buffer_f32);
   current_normal[coord] = position/10.0;
   if(position < 0)
    current_normal[coord] = ceil(current_normal[coord])*10.0;
   else
    current_normal[coord] = floor(current_normal[coord])*10.0;
   position -= current_normal[coord];
   current_normal[coord] /= 128*10.0;
   normal[coord] += current_normal[coord] - 1;
   var v = vertices[vertex];
   v[@coord] = position;
  }
  //skip color x1 and texture coordinates x2 == x3
  repeat(3)
   buffer_read(argument0, buffer_f32);
 }
 //average and normalize normal
 for(var coord = 0; coord < 3; coord++)
  normal[coord] /= 3;
 var scale = 1/sqrt(normal[0]*normal[0] + normal[1]*normal[1] + normal[2]*normal[2]);
 //--------------------------------------------------
 //write normal
 for(var coord = 0; coord < 3; coord++)
  buffer_write(stl_buffer, buffer_f32, normal[coord]*scale);
 //write vertices
 for(var vertex = 0; vertex < 3; vertex++)
 {
  var v = vertices[vertex];
  for(var coord = 0; coord < 3; coord++)
   buffer_write(stl_buffer, buffer_f32, v[coord]);
 }
 //write attribute byte count - empty
 buffer_write(stl_buffer, buffer_u16, 0);
}
buffer_save(stl_buffer, argument1);
buffer_delete(stl_buffer);
show_debug_message(argument1 + " exported.");
