camera = view_camera[0];
cameraStartingPos = [room_width / 2 - camera_get_view_width(camera) / 2, room_height / 2 - camera_get_view_height(camera) / 2];

camera_set_view_pos(camera, cameraStartingPos[0], cameraStartingPos[1]);

cameraPos = [camera_get_view_x(camera), camera_get_view_y(camera)];

clickPos = [0, 0];

camSpeed = 2;
camSpeedGain = 18 / SECOND;
camSpeedTop = 25;

cameraScaleMin = 0.7;
cameraScaleMax = 1.3;
cameraScale = 1;

cameraSize = [camera_get_view_width(camera), camera_get_view_height(camera)];
cameraScaleBase = cameraSize;