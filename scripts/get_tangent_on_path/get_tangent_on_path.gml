//get_tangent_on_path(path, progress)

if(!instance_exists(argument0))	return [0,0,0];
if(argument1 > 1.0 || argument1 < 0.0) return [0,0,0];

var tangent = [0,0,0];

var delta = 0.000000001;

var point_a = get_point_on_path(argument0, argument1 - delta);
var point_b = get_point_on_path(argument0, argument1 + delta);

var distance = point_distance_3d(point_a[0], point_a[1], point_a[2], point_b[0], point_b[1], point_b[2]);

for(var coordinate = 0; coordinate < 3; coordinate++)
{
	tangent[coordinate] = (point_b[coordinate] - point_a[coordinate])/distance;
}

return [point_direction(0,0,tangent[0], tangent[1]), point_direction(0,0,point_distance(0,0,tangent[0], tangent[1]),tangent[2])];