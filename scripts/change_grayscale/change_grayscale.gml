
//change_grayscale(identity, type, value)
var identity = argument0;
var gs = identity[Grayscale];
//track changed identities
set_tags(identity, [Changed_Uniform]);
//change tag and encode in uniform buffer
var is_added = (argument1 == 1);
gs = gs*is_added + argument2;
//derive buffer index from identity index
var buffer_index = argument0[INDEX]*6*4 + 4*3 + 2 + 3;
buffer_poke(uniform_buffer, buffer_index, buffer_u8, gs);
