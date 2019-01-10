//get_rotated_model(buffer, degrees)

buffer_seek(argument0, buffer_seek_start, 0);

var new_buffer = buffer_create(buffer_get_size(argument0), buffer_fixed, 1);

var no_of_vertices = buffer_get_size(new_buffer)/(Game.format_size*4);

repeat(no_of_vertices)
{
 //Position 3x4 bytes
 var XY = [0,0];
 var NXY = [0,0];
 for(i = 0; i < 2; i++)
 {
  XY[i] = buffer_read(argument0, buffer_f32);
  NXY[i] = XY[i]/10.0;
  if(XY[i] < 0)
   NXY[i] = ceil(NXY[i]);
  else
   NXY[i] = floor(NXY[i]);

  XY[i] -= NXY[i]*10.0;

  NXY[i] = abs(NXY[i])/128 - 1;
 }

 //rotate
 var X = sin(argument1*3.1415926535897932384626433832795/180)*XY[1] - cos(argument1*3.1415926535897932384626433832795/180)*XY[0];
 XY[1] = cos(argument1*3.1415926535897932384626433832795/180)*XY[1] + sin(argument1*3.1415926535897932384626433832795/180)*XY[0];
 XY[0] = X;

 var NX = sin(argument1*3.1415926535897932384626433832795/180)*NXY[1] - cos(argument1*3.1415926535897932384626433832795/180)*NXY[0];
 NXY[1] = cos(argument1*3.1415926535897932384626433832795/180)*NXY[1] + sin(argument1*3.1415926535897932384626433832795/180)*NXY[0];
 NXY[0] = NX;

 //write
 for(i = 0; i < 2; i++)
 {
  var s = sign(XY[i]);
  s += (s == 0);
  //clear and recompress normals
  XY[i] += s*floor((NXY[i] + 1)*128)*10.0;;
  buffer_write(new_buffer, buffer_f32, XY[i]);
 }

 //Z
 buffer_write(new_buffer, buffer_f32, buffer_read(argument0, buffer_f32));

 //Color 1x4 bytes
 buffer_write(new_buffer, buffer_f32, buffer_read(argument0, buffer_f32));

 //Texture Coordinates 2x4 bytes
 buffer_write(new_buffer, buffer_f32, buffer_read(argument0, buffer_f32));
 buffer_write(new_buffer, buffer_f32, buffer_read(argument0, buffer_f32));
}

return new_buffer;
