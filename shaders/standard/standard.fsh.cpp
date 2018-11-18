#include "fragment_definitions.txt"

#include "fragment_declarations.txt"

void main()
{
  #include "flat_fragment.txt"

  #include "diffuse_and_depth_fragment.txt"

  #include "normal_detection.txt"

  // #include "occlusion_first_pass.txt"
  //
  // #include "occlusion_second_pass.txt"
  //
  // #include "post_processing_fragment.txt"
}

#include "implementations.txt"
