var position = tags[|Position]; position = position[|0];
SET_UNIFORM_F("camera_position", position.X, position.Y, position.Z)
var rotation = tags[|Rotation]; rotation = rotation[|0];
SET_UNIFORM_F("camera_angle", rotation.roll, rotation.pitch, rotation.yaw)

#define FINAL_SURFACE surfaces[PLAYER_ONE]
//#include "visibility_culling.txt"
//#include "mirrors.txt"
#include "render_scene.txt"
//if(IS_SPLITSCREEN)
//{
//  #define FINAL_SURFACE surfaces[PLAYER_TWO]
  //#include "visibility_culling.txt"
  //#include "mirrors.txt"
  //#include "render_scene.txt"
//}

#include "draw_to_screen.txt"
