#include "fragment_definitions.c"

#include "fragment_declarations.c"

void main()
{
  #include "flat_fragment.c"

  #include "mrt_fragment.c"

  //#include "uniform_encoding.c"

  //#include "edge_detection.c"

  // #include "occlusion_first_pass.c"

  // #include "occlusion_second_pass.c"
  
  // #include "post_processing_fragment.c"
}

#include "implementations.c"
