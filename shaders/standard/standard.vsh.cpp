#include "vertex_definitions.txt"

void main()
{
	if(vertex_mode == FLAT)
	{
		#include "flat_projection.txt"
	}
	else
	{
		#include "perspective_projection.txt"
	}

	#include "vertex_coloring_and_texturing.txt"
}

#include "implementations.txt"
