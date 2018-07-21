///load_model(filepath)
/// @desc loads file into buffer, creates Model tag
/// @arg filepath
/// @return Model index

if(!file_exists(argument0))
{
	show_debug_message("File not Found: " + string(argument0));
	return -1;
}

var model = buffer_load(argument0);


//bounding box
//var rightmost, leftmost, deepest, shallowest, highest, lowest  = 0;

//for(var i = 0; i < array_length_1d(argument0); i += 6)
//{
//	if(rightmost < argument0[i]) rightmost = argument0[i];
//	if(leftmost > argument0[i]) leftmost = argument0[i];

//	if(deepest < argument0[i+1]) deepest = argument0[i+1];
//	if(shallowest > argument0[i+1]) shallowest = argument0[i+1];
	
//	if(highest < argument0[i+2]) highest = argument0[i+2];
//	if(lowest > argument0[i+2]) lowest = argument0[i+2];
//}

//model.bounding_box = [rightmost, leftmost, deepest, shallowest, highest, lowest];

//load animations 

var index = ds_list_size(Game.tags[|Model]);

ds_list_add(Game.tags[|Model], model);

return index;