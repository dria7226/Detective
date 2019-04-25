var identity = Game.tags[Camera]; identity = identity[|0].back_reference;

#define SET_CAMERA_UNIFORMS
#include "set_uniforms.c"

#define FINAL_SURFACE surfaces[PLAYER_ONE]
//#include "visibility_culling.c"
//#include "mirrors.c"
#include "render_scene.c"

//if(IS_SPLITSCREEN)
//{
//  #define FINAL_SURFACE surfaces[PLAYER_TWO]
  //#include "visibility_culling.c"
  //#include "mirrors.c"
  //#include "render_scene.c"
//}

#include "draw_to_screen.c"

#ifdef SHOW_USE
//uses_camera_tag, uses_position_tag, uses_rotation_tag, uses_splitscreen
#endif
