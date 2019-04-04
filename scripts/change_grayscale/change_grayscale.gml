
//change_grayscale(identity, type, value)
var identity = argument0;

var gs = identity[Grayscale];

//track changed identities
set_tags(identity, [Changed_Uniform]);

//change tag and encode in uniform buffer
gs.value = gs.value*argument1 + argument2;

//derive buffer index from identity index
var buffer_index = identity[INDEX]*6*4 + 4*3 + 2*3 + 3;

buffer_poke(uniform_buffer, buffer_index, buffer_u8, floor(gs.value*255.0));
