//point_direction_3d(point_a, point_b)

if(array_length_1d(argument0) != 3) return [0,0];
if(array_length_1d(argument1) != 3) return [0,0];

return [-point_direction(argument0[0], 
						argument0[1], 
						argument1[0], 
						argument1[1])/180*pi,
		point_direction(0,
						0, 
						point_distance(argument0[0], argument0[1], argument1[0], argument1[1]),
						argument1[2] - argument0[2])/180*pi];