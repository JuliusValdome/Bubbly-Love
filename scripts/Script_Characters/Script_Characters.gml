function Character_Sprite(){
	image_speed = (baseFrameSpeed * SLOW) / SECOND;
	sprite_index = asset_get_index("Sprite_Character_" + name + "_" + state);
	image_xscale = facingDirection;
	depth = -y;
}

function Character_Move(){
	if (!moveFlag){
		state = "Idle";
		return 0;
	}
	
	var dir = point_direction(x, y, targetPosition[0], targetPosition[1]);
	var mvSpd = moveSpeed * SLOW;
	
	x += lengthdir_x(mvSpd, dir);
	y += lengthdir_y(mvSpd, dir);
	
	if (point_distance(x, y, targetPosition[0], targetPosition[1]) <= 10)	moveFlag = false;
	facingDirection = (x >= xprevious) ? -1 : 1;
	
	state = "Move";
}

function Character_Attack(){
    if (moveFlag) return 0;

    attackTarget = Character_Select_Target();
    var canAttack = Character_Attack_Timer();

    if (attackTarget != -1 and canAttack and distance_to_point(attackTarget.x, attackTarget.y) <= attack.range){
        var dir = point_direction(x, y, attackTarget.x, attackTarget.y);
        var crit = (irandom(100) <= attack.critical);
        
        Character_AttackInstance(dir, crit);
        facingDirection = (attackTarget.x > x) ? -1 : 1;
        attackCooldown = true;
    }else{
        attackTarget = -1;
    }

    if (attackCooldown){
        if (attackCooldownTime <= 0){
            attackCooldown = false;
            attackCooldownTime = attackCooldownTimeBase * (1 - (cadence / 2));
        }else{
            state = "Attack";
            attackCooldownTime D_ONE;
        }
    }
}

function Character_AttackInstance(dir, crit){
	var amount = attacks;
	var mult = attack.multiplier;
	audio_play_sound(attack.sound, 0, false, 0.5);
	switch(name){
		case "Lily":
			var angleOffset = 360 / amount;
			for(var i = 0; i < amount; i ++)
				Characters_CreateAttackInstance(dir, crit, mult);
			break;
		case "Dulce":
		case "Tanja":
			Characters_CreateAttackInstance(dir, crit, mult);		
			if (amount > 1){
				var angles = [];
				var angleOffset = 30;
				var offsets = (360 - angleOffset) / angleOffset;
				for(var i = 0; i < offsets; i++){
					angles[i] = angleOffset * i;
				}
				array_shuffle(angles);
				for(var i = 1; i < amount; i++)
					Characters_CreateAttackInstance(dir + angles[i], crit, mult);
			}
			break;
		case "Hua":
			var fistDir = choose(-1, 1);
			var angleOffset = 25;
			for(var i = 0; i < amount; i++){
				var _i = ceil(i / 2);
				Characters_CreateAttackInstance(dir + angleOffset * _i * fistDir, crit, mult);
				fistDir *= -1;
			}
			break;
		case "Miyuki":
			Characters_CreateAttackInstance(dir, crit, mult);
			break;
	}
}

function Character_Select_Target(){
	var target = attackTarget;
	
    if (target != -1 and instance_exists(target))
        if (distance_to_point(attackTarget.x, attackTarget.y) <= attack.range)	return target;
	
	var newTarget = instance_nearest(x, y, Object_Enemy);
	if (newTarget != noone and distance_to_point(newTarget.x, newTarget.y) <= attack.range)	return newTarget;

    return -1;
}

function Character_Attack_Timer(){
    if (attackCooldown) return false;

    if (attackTarget == -1){
        attackTimer = baseAttackTimer;
        prepareAttack = false;
        return false;
    }

    if (attackTimer > 0){
        state = "Prepare";
        attackTimer D_ONE;
        return false;
    }

    attackTimer = baseAttackTimer;
    return true;
}