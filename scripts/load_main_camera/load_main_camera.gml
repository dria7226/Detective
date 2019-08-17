
var camera = create_identity([Camera, Position, Rotation]);
camera[Camera].back_reference = camera;

change_position(camera, 0, [4.5, -9, 5.5]);
