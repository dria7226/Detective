var camera = Game.tags[Camera]; camera = camera[|0].back_reference;

var position = camera[Position];
SET_UNIFORM_F("camera_position", position.coordinates[X], position.coordinates[Y], position.coordinates[Z])
var rotation = camera[Rotation];
SET_UNIFORM_F("camera_angle", rotation.angle[ROLL], rotation.angle[PITCH], rotation.angle[YAW])

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
