//get_point_on_segment(path, segment, progress)

if(!instance_exists(argument0)) return [0,0,0];
if(ds_list_size(argument0.segments) <= argument1) return [0,0,0];
if(argument2 > 1.0 || argument2 < 0.0) return;

var segment = argument0.segments[|argument1];

var point_a = segment[0];
var point_b = segment[1];
var point_c = segment[2];

var output_vertices = [0,0,0];
output_vertices[0] = [0,0,0];
output_vertices[1] = [0,0,0];
output_vertices[2] = [0,0,0];

var temporary_vertices = [0,0,0];
temporary_vertices[0] = [point_a, point_b];
temporary_vertices[1] = [point_b, point_c];
temporary_vertices[2] = [output_vertices[0], output_vertices[1]];

for(var i = 0; i < 3; i++)
{
	var output_vertex = output_vertices[i];
	var input_vertices = temporary_vertices[i];
	var input_a = input_vertices[0];
	var input_b = input_vertices[1];
	
	for(var coordinate = 0; coordinate < 3; coordinate++)
		output_vertex[@coordinate] = (input_b[coordinate] - input_a[coordinate])*argument2 + input_a[coordinate];
}

return output_vertices[2];
