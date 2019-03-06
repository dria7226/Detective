#include "vertex_definitions.c"

#include "vertex_declarations.c"

void main()
{
	if(vertex_mode == VERTEX_FLAT)
	{
		#include "flat_projection.c"
	}
	else
	{
		#include "perspective_projection.c"
	}

	#include "vertex_coloring_and_texturing.c"
}

#include "implementations.c"
