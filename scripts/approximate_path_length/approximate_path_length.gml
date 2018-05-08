//approximate_path_length(path, approximation_factor)

if(!instance_exists(argument0)) return -1;
if(ds_list_size(argument0.segments) < 1) return -1;

for(var i = 0; i < ds_list_size(argument0.segments); i++)
{
	var segment = argument0.segments[|i];
	segment[@3] = 0;
	
	var previous_point = segment[0];
	
	for(var j = 1.0/argument1; j <= 1.0; j += 1.0/argument1)
	{
		var next_point = get_point_on_segment(argument0, i, j);
		
		var distance = point_distance_3d(previous_point[0], previous_point[1], previous_point[2], next_point[0], next_point[1], next_point[2]);
		
		segment[@3] += distance;
		
		previous_point = next_point;
	}
	
	argument0.length += segment[3];	
}