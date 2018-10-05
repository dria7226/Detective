#include "fragment_definitions.txt"

void main()
{
  #include "flat_fragment.txt"

  #include "diffuse_fragment.txt"

  #include "depth_fragment.txt"

  #include "occlusion_first_pass.txt"

  #include "occlusion_second_pass.txt"

  #include "normal_detection.txt"

  #include "edge_detection.txt"

  #include "compositing.txt"
}
