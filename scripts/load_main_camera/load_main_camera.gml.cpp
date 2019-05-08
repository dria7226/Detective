var camera = create_identity([Camera, Position, Rotation]);

camera[Camera].back_reference = camera;

change_position(camera, CHANGE_SET, [4.5, -9, 5.5]);

#ifdef UNIFORM_COMPRESSION
change_zoom(camera, CHANGE_SET, camera[Camera].zoom)
#endif
