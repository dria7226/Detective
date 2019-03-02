var camera = create_identity([Camera, Position, Rotation]);

camera[Camera].back_reference = camera;

change_position(camera, CHANGE_SET, [4.5, -9, 5.5]);
