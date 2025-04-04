if (global.LevelUpEvent)	return 0;

if (mouse_check_button_pressed(mb_middle)){
	clickPos = [device_mouse_x(0), device_mouse_y(0)];
	cameraPos = [camera_get_view_x(camera), camera_get_view_y(camera)];
}

if (mouse_check_button(mb_middle)){
	var mouseX = device_mouse_x(0);
	var mouseY = device_mouse_y(0);
	
	var dx = clickPos[0] - mouseX;
    var dy = clickPos[1] - mouseY;
	
	var _xCam = cameraPos[0] + dx;
    var _yCam = cameraPos[1] + dy;
	
	var _camHLeft = cameraSize[0] / 4;
	var _camHRight = room_width - cameraSize[0];
	var _camVTop = cameraSize[1] / 4;
	var _camHBottom = room_height - cameraSize[1];
	
	_xCam = _xCam <= _camHLeft ? _camHLeft : _xCam;
	_xCam = _xCam >= _camHRight ? _camHRight : _xCam;
	_yCam = _yCam <= _camVTop ? _camVTop : _yCam;
	_yCam = _yCam >= _camHBottom ? _camHBottom : _yCam;
	
	camera_set_view_pos(camera, _xCam, _yCam);
	cameraPos = [camera_get_view_x(camera), camera_get_view_y(camera)];
}

var camUp = keyboard_check(ord("W"));
var camDown = keyboard_check(ord("S"));
var camLeft = keyboard_check(ord("A"));
var camRight = keyboard_check(ord("D"));

if (camUp or camDown or camLeft or camRight){

vMove = (camUp ? -1 : (camDown ? 1 : 0));
hMove = (camLeft ? -1 : (camRight ? 1 : 0));

camDir = point_direction(0, 0, hMove, vMove);

if (vMove != 0 or hMove != 0){
	camSpeed += camSpeedGain;
	if (camSpeed >= camSpeedTop)	camSpeed = camSpeedTop;
	var _x = cameraPos[0] + lengthdir_x(camSpeed, camDir);
	var _y = cameraPos[1] + lengthdir_y(camSpeed, camDir);

	var _camHLeft = cameraSize[0] / 5;
	var _camHRight = room_width - cameraSize[0];
	var _camVTop = cameraSize[1] / 5;
	var _camHBottom = room_height - cameraSize[1];

	_x = _x >= _camHRight ? _camHRight : _x;
	_x = _x <= 1 ? 1 : _x;
	_y = _y >= _camHBottom ? _camHBottom : _y;
	_y = _y <= 1 ? 1 : _y;

	camera_set_view_pos(camera, _x, _y);
	cameraPos = [camera_get_view_x(camera), camera_get_view_y(camera)];
}
}else{
	camSpeed = 2;	
}

if (mouse_wheel_up()){
	//cameraScale -= 0.05;
}

if (mouse_wheel_down()){
	//cameraScale += 0.05;
	camera_set_view_size(camera, camera_get_view_width(camera) + 10, camera_get_view_height(camera) + 10)	
}

var camVW = cameraScaleBase[0] * cameraScale;
var camVH = cameraScaleBase[1] * cameraScale;
camera_set_view_size(camera, camVW, camVH);
cameraSize = [camera_get_view_width(camera), camera_get_view_height(camera)];