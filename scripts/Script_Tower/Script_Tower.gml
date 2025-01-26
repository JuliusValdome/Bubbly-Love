function Protagonist_Move(){
	if (!moveFlag){
		state = "Idle";
		return 0;
	}
	
	var dir = point_direction(x, y, targetPosition[0], targetPosition[1]);
	var mvSpd = moveSpeed * SLOW;
	
	x += lengthdir_x(mvSpd, dir);
	y += lengthdir_y(mvSpd, dir);
	
	if (point_distance(x, y, targetPosition[0], targetPosition[1]) <= 3){
		moveFlag = false;
	}
		
	facingDirection = (x >= xprevious) ? -1 : 1;
	baseY = y;
	state = "Move";
}

function Protagonist_GameOver(){
	if Health <= 0{
		with(Object_Character){
			state = "Lose";
		}
		gameOverTransition = true;
		sprite_index = Sprite_Character_Protagonist_Defeat;
		if (image_index >= image_number - 1){
			global.GameOverEvent = false;
		}
		image_index = image_index >= image_number -1 ? image_number - 1 : image_index;
	}
}