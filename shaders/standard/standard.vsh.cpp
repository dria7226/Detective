#include "vertex_definitions.txt"

#include "vertex_declarations.txt"

void main()
{
	if(vertex_mode == VERTEX_FLAT)
	{
		#include "flat_projection.txt"
	}
	else
	{
		#include "perspective_projection.txt"
	}

	#include "normals.txt"

	#include "vertex_coloring_and_texturing.txt"
}

#include "implementations.txt"
