var camera_tag = tags[|Camera]; camera_tag = camera_tag[|0];
SET_UNIFORM_F("near_clip", camera_tag.near_clip)

var position = tags[|Position]; position = position[|0];
var rotation = tags[|Rotation]; rotation = rotation[|0];

SET_UNIFORM_F("camera_position", position.X, position.Y, position.Z)
SET_UNIFORM_F("camera_angle", rotation.roll, rotation.pitch, rotation.yaw+alpha)

#include "visibility_culling.txt"

#define FINAL_SURFACE surfaces[PLAYER_ONE]
ITERATE_VISIBLES
{
  #include "render_scene.txt"
}
if(IS_SPLITSCREEN)
{
  #define FINAL_SURFACE surfaces[PLAYER_TWO]
  ITERATE_VISIBLES
  {
    #include "render_scene.txt"
  }
}

#include "draw_to_screen.txt"
