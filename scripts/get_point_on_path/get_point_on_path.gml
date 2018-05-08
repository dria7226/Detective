//get_point_on_path(path, progress)

if(!instance_exists(argument0))	return [0,0,0];
if(argument1 > 1.0 || argument1 < 0.0) return [0,0,0];
if(argument0.length == 0) approximate_path_length(argument0, 10);

var current_sum = 0;
var target_segment = 0;
for(;target_segment < ds_list_size(argument0.segments);)
{
	var segment = argument0.segments[|target_segment];
	current_sum += segment[3];
	
	if(current_sum >= argument1*argument0.length)
		break;
	else
		target_segment++;
}

var segment = argument0.segments[|target_segment];

return get_point_on_segment(argument0,
							target_segment, 
							(argument1*argument0.length - current_sum + segment[3])/segment[3]);