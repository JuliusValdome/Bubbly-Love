sprite_index = asset_get_index("Sprite_" + name + "Bubble_" + state);

if (spawnMove){
	x = targetSpawn.pivotX + lengthdir_x(targetSpawn.midPoint, targetSpawn.angleStart);
	y = targetSpawn.pivotY + lengthdir_y(targetSpawn.midPoint, targetSpawn.angleStart);
	targetSpawn.angleStart += ((45 * targetSpawn.direct) / (SECOND * 0.15)) * SLOW;
	
	if (distance_to_point(targetSpawn.targetX, targetSpawn.targetY) <= 1)
		spawnMove = false;
}else{
	if (!moveFlag){
		with(Object_Character){
			if (distance_to_point(other.x, other.y) <= (magnet * other.range)){
				other.moveFlag = true;
				audio_play_sound(SFX_PickupBubble, 0, false, 0.3);
			}
		}
	}
	
	if (moveFlag){
		state = "Move";
		var targetPos = [TWR.x, TWR.y];
		var targetDir = point_direction(x, y, targetPos[0], targetPos[1]);
		var mvSpd = moveSpeed * SLOW;
	
		x += lengthdir_x(mvSpd, targetDir);
		y += lengthdir_y(mvSpd, targetDir);
	
		if (y <= targetPos[1])	activateFlag = true;
	}else{
		state = "Idle";
		var mvSpeed = floatSpeed * SLOW;

		y += (mvSpeed * dir) * SLOW;

		if (y >= (baseY + maxY)){
			dir = -dir;	
		}else if (y <= (baseY - maxY)){
			dir = -dir;	
		}	
	}
	
	if (place_meeting(x, y, TWR)){
		if (image_alpha == 1){
			switch(name){
				case "Love":
					SYS.love += value;
					break;
				case "Healing":
					TWR.Health += value;
					break;
				case "Magnet":
					with(Object_DropBubble){
						if (name == "Love"){
							moveFlag = true;	
						}
					}
					break;
				case "AntiPanic":
					with(Object_Enemy){
						Health -= 999;
						gotHit = true;
						gotHitTimer = gotHitTimerBase;
					};
					break;
			}
		}
		image_alpha -= 1 / (SECOND * 0.15);

		if (image_alpha <= 0)
			instance_destroy();	
	}
	
}