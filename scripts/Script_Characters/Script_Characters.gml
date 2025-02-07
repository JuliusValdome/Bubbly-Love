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
	if (moveFlag)	return 0;
	
    attackTarget = Character_Select_Target();
	var canAttack = Character_Attack_Timer();
	
    if (attackTarget != -1 and instance_exists(attackTarget) and canAttack){
        if (distance_to_point(attackTarget.x, attackTarget.y) <= attackRange){
			var dir = point_direction(x, y, attackTarget.x, attackTarget.y);
			var crit = (irandom(100) <= attackCritical);
			
			Character_AttackInstance(dir, crit);
			facingDirection = attackTarget.x > x ? -1 : 1;
			attackCooldown = true;
		}else{
			attackTarget = -1;
        }
    }else{
		attackTarget = -1;
    }
	
	if (attackCooldown){
		if (attackCooldownTime <= 0){
			attackCooldown = false;
			attackCooldownTime = attackCooldownTimeBase * (1 - (attackSpeed / 2));	
		}else{
			state = "Attack";
			attackCooldownTime --;
		}
	}
}

function Character_AttackInstance(dir, crit){
	var level = SYS.girlsLevel[? name];
	var amount = attackInfo.amount;
	switch(name){
		case "Lily":
			audio_play_sound(SFX_Swing, 0, false, 0.5);
			var angleOffset = 360 / amount;
			for(var i = 0; i < amount; i ++){
				instance_create_depth(x, y, depth + 1, Object_Character_Attack, {creator: id, name: name, attackDirection: dir + angleOffset * i, info: attackInfo, isCrit: crit, critMult: attackCriticalMultiplier});	
			}
			break;
		case "Dulce":
			audio_play_sound(SFX_Swing, 0, false, 0.5);
			instance_create_depth(x, y, depth + 1, Object_Character_Attack, {creator: id, name: name, attackDirection: dir, info: attackInfo, isCrit: crit, critMult: attackCriticalMultiplier});	
			if (amount > 1){
				var angleOffset = 60 * choose(-1, 1);
				for(var i = 1; i < amount; i++){
					var upDown = (i % 2 == 0) ? 1 : -1;
					instance_create_depth(x, y, depth + 1, Object_Character_Attack, {creator: id, name: name, attackDirection: dir + (angleOffset * i * upDown), info: attackInfo, isCrit: crit, critMult: attackCriticalMultiplier});	
				}
			}
			break;
		case "Hua":
			audio_play_sound(SFX_Swing, 0, false, 0.5);
			if (level >= 4){
				instance_create_depth(x, y, depth + 1, Object_Character_Attack, {creator: id, name: name, attackDirection: dir - 25, info: attackInfo, isCrit: crit, critMult: attackCriticalMultiplier});		
				instance_create_depth(x, y, depth + 1, Object_Character_Attack, {creator: id, name: name, attackDirection: dir, info: attackInfo, isCrit: crit, critMult: attackCriticalMultiplier});		
				instance_create_depth(x, y, depth + 1, Object_Character_Attack, {creator: id, name: name, attackDirection: dir + 25, info: attackInfo, isCrit: crit, critMult: attackCriticalMultiplier});		
			}else{
				instance_create_depth(x, y, depth + 1, Object_Character_Attack, {creator: id, name: name, attackDirection: dir, info: attackInfo, isCrit: crit, critMult: attackCriticalMultiplier});	
			}
			break;
		case "Tanja":
			audio_play_sound(SFX_Fireball, 0, false, 0.5);
			if (level >= 4){
				instance_create_depth(x, y, depth + 1, Object_Character_Attack, {creator: id, name: name, attackDirection: dir, info: attackInfo, isCrit: crit, critMult: attackCriticalMultiplier});		
				instance_create_depth(x, y, depth + 1, Object_Character_Attack, {creator: id, name: name, attackDirection: random_range(dir - 20, dir + 20), info: attackInfo, isCrit: crit, critMult: attackCriticalMultiplier});		
			}else{
				instance_create_depth(x, y, depth + 1, Object_Character_Attack, {creator: id, name: name, attackDirection: dir, info: attackInfo, isCrit: crit, critMult: attackCriticalMultiplier});	
			}
			break;
		case "Miyuki":
			audio_play_sound(SFX_Swing, 0, false, 0.5);
			instance_create_depth(x, y, depth + 1, Object_Character_Attack, {creator: id, name: name, attackDirection: dir, info: attackInfo, isCrit: crit, critMult: attackCriticalMultiplier});	
			break;
	}
	//instance_create_depth(x, y, depth + 1, Object_Character_Attack, {creator: id, name: name, attackDirection: dir, info: attackInfo, isCrit: crit, critMult: attackCriticalMultiplier});
}


function Character_Select_Target(){
    if (attackTarget != -1 and instance_exists(attackTarget)){
        if (distance_to_point(attackTarget.x, attackTarget.y) <= attackRange){
            return attackTarget;
        }
    }

    if (instance_exists(Object_Enemy)){
        var trgtAux = instance_nearest(x, y, Object_Enemy);
        if (distance_to_point(trgtAux.x, trgtAux.y) <= attackRange){
            return trgtAux;
        }
    }

    return -1;
}

function Character_Attack_Timer(){
	if (attackCooldown)	return false;
	
	if (attackTarget == -1){
		attackTimer = baseAttackTimer;
		prepareAttack = false
		return false;
	}else if (attackTimer <= 0){
		attackTimer = baseAttackTimer;
		return true;
	}else{
		state = "Prepare";
		attackTimer -= 1 * SLOW;
		return false;
	}
}