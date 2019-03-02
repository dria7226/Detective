
//turn_dynamic_to_static(identity)
var tag_combo = [Static, 0];
//add identity to new statics
ds_list_add(new_statics, [argument0, tag_combo]);
//add static index to tag list
ds_list_add(argument0.tag_list, tag_combo); // will get updated in update_uniform_buffer.txt
