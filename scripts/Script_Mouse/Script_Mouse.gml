function Mouse_Position(){
	x = mouse_x;
	y = mouse_y;
}

function Mouse_Characters_Move(){
	if (!global.GameOverEvent or global.LevelUpEvent)	return 0;
	
	if (MBRight){
		if (place_meeting(x, y, Object_Character) and selectedCharacter == -1){
			selectedCharacter = instance_place(x, y, Object_Character);
		}	
		if (selectedCharacter != -1){
			characterTargetPosition = [global.Mouse.x, global.Mouse.y];
		}
	}else{
		if (MBRightRel){
			with(selectedCharacter){
				moveFlag = true;
				targetPosition = other.characterTargetPosition;
				
				if (place_meeting(targetPosition[0], targetPosition[1], TWR)){
					var dir = point_direction(x, y, targetPosition[0], targetPosition[1]);
					var twrDist = -100;
					var _xNew = targetPosition[0] + lengthdir_x(twrDist, dir);
					var _yNew = targetPosition[1] + lengthdir_y(twrDist, dir);
					targetPosition = [_xNew, _yNew];
				}					
			}
		}
		characterTargetPosition = [0, 0];
		selectedCharacter = -1;	
	}	
}

function Mouse_CharactersToTower(){
	if (!global.GameOverEvent or global.LevelUpEvent)	return 0;
	if (selectedCharacter != -1 or !instance_exists(Object_Tower)) return 0;
	
	if (mouse_check_button_pressed(mb_left)){
		if (place_meeting(x, y, TWR)){
			with(Object_Character){
				var dist = 128;
				var dir = point_direction(global.Tower.x, global.Tower.y, x, y);
				var _x = TWR.x + lengthdir_x(dist, dir);
				var _y = TWR.y + lengthdir_y(dist, dir);
			
				targetPosition = [_x, _y];
				moveFlag = true;
			}
		}
	}	
}