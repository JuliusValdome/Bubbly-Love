function Character_Variables(){
	/// Flags ///
	moveFlag = false;
	facingDirection = 1;
	prepareAttack = false;
	attackCooldown = false;
	
	/// Variables ///
	level = 1;
	targetPosition = [0, 0];
	attackTarget = -1;
	state = "Idle";
	
	/// Timers ///
	baseAttackTimer = SECOND - attackSpeed * SECOND;
	attackTimer = baseAttackTimer;
	attackCooldownTimeBase = baseAttackTimer / 2;
	attackCooldownTime = attackCooldownTimeBase;
	
	/// Constants ///
	baseFrameSpeed = sprite_get_speed(Sprite_Character_A_Move);
}

function Character_GetInfo(){
	var info = Object_System.Characters[$ name];
	
	var baseMoveSpeed = info.moveSpeed;		
	var baseMagnet = info.magnet;		
	var baseAttackRange = info.attackRange;			
	var baseAttackCritical = info.attackCritical;		
	var baseAttackCriticalMultiplier = info.attackCriticalMultiplier;		
	var baseAttackSpeed = info.attackSpeed;			
	
	moveSpeed = baseMoveSpeed;
	magnet = baseMagnet;
	attackRange = baseAttackRange;
	attackCritical = baseAttackCritical;
	attackCriticalMultiplier = baseAttackCriticalMultiplier;
	attackSpeed = baseAttackSpeed;
	skillRecharge = 0;
	skillRechargeTop = info.specialSkillRechargeBase;
	
	var attackInfoAux = {};
	attackInfoAux.type = info.attackInfo.type;
	attackInfoAux.level = info.attackInfo.level;
	attackInfoAux.attack = info.attackInfo.attack;
	attackInfoAux.moveSpeed = info.attackInfo.moveSpeed;
	attackInfoAux.life = info.attackInfo.life;
	attackInfoAux.offSet = info.attackInfo.offSet;
	attackInfoAux.amount = info.attackInfo.amount;
	attackInfoAux.oneContact = info.attackInfo.oneContact;
	attackInfoAux.size = info.attackInfo.size;
	attackInfoAux.hitBoxOffset = info.attackInfo.hitBoxOffset;
		
	attackInfo = attackInfoAux;
}

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
	
	if (point_distance(x, y, targetPosition[0], targetPosition[1]) <= 5){
		moveFlag = false;
	}
		
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
			skillRecharge += random_range(0.1, 1.5);
			skillRecharge = skillRecharge >= skillRechargeTop ? skillRechargeTop : skillRecharge;
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
	switch(name){
		case "A":
			audio_play_sound(SFX_Swing, 0, false, 0.5);
			if (level >= 3){
				instance_create_depth(x, y, depth + 1, Object_Character_Attack, {creator: id, name: name, attackDirection: dir + 180, info: attackInfo, isCrit: crit, critMult: attackCriticalMultiplier});	
				instance_create_depth(x, y, depth + 1, Object_Character_Attack, {creator: id, name: name, attackDirection: dir, info: attackInfo, isCrit: crit, critMult: attackCriticalMultiplier});	
			}else{
				instance_create_depth(x, y, depth + 1, Object_Character_Attack, {creator: id, name: name, attackDirection: dir, info: attackInfo, isCrit: crit, critMult: attackCriticalMultiplier});	
			}
			break;
		case "B":
			audio_play_sound(SFX_Swing, 0, false, 0.5);
			if (level >= 5){
				instance_create_depth(x, y, depth + 1, Object_Character_Attack, {creator: id, name: name, attackDirection: dir, info: attackInfo, isCrit: crit, critMult: attackCriticalMultiplier});	
			}else{
				instance_create_depth(x, y, depth + 1, Object_Character_Attack, {creator: id, name: name, attackDirection: dir, info: attackInfo, isCrit: crit, critMult: attackCriticalMultiplier});	
			}
			break;
		case "C":
			audio_play_sound(SFX_Swing, 0, false, 0.5);
			if (level >= 4){
				instance_create_depth(x, y, depth + 1, Object_Character_Attack, {creator: id, name: name, attackDirection: dir - 25, info: attackInfo, isCrit: crit, critMult: attackCriticalMultiplier});		
				instance_create_depth(x, y, depth + 1, Object_Character_Attack, {creator: id, name: name, attackDirection: dir, info: attackInfo, isCrit: crit, critMult: attackCriticalMultiplier});		
				instance_create_depth(x, y, depth + 1, Object_Character_Attack, {creator: id, name: name, attackDirection: dir + 25, info: attackInfo, isCrit: crit, critMult: attackCriticalMultiplier});		
			}else{
				instance_create_depth(x, y, depth + 1, Object_Character_Attack, {creator: id, name: name, attackDirection: dir, info: attackInfo, isCrit: crit, critMult: attackCriticalMultiplier});	
			}
			break;
		case "D":
			audio_play_sound(SFX_Fireball, 0, false, 0.5);
			if (level >= 4){
				instance_create_depth(x, y, depth + 1, Object_Character_Attack, {creator: id, name: name, attackDirection: dir, info: attackInfo, isCrit: crit, critMult: attackCriticalMultiplier});		
				instance_create_depth(x, y, depth + 1, Object_Character_Attack, {creator: id, name: name, attackDirection: random_range(dir - 20, dir + 20), info: attackInfo, isCrit: crit, critMult: attackCriticalMultiplier});		
			}else{
				instance_create_depth(x, y, depth + 1, Object_Character_Attack, {creator: id, name: name, attackDirection: dir, info: attackInfo, isCrit: crit, critMult: attackCriticalMultiplier});	
			}
			break;
		case "E":
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

function Stats_Update(){
	var info = Object_System.Characters[$ name];
	var level = SYS.girlsLevel[? name];
	
	var baseMoveSpeed = info.moveSpeed;		
	var baseMagnet = info.magnet;				
	var baseAttackCritical = info.attackCritical;	
	var baseAttackCriticalMultiplier = info.attackCriticalMultiplier;		
	var baseAttackSpeed = info.attackSpeed;				
	var baseAttackRange = info.attackRange;				
	
	moveSpeed = baseMoveSpeed + baseMoveSpeed * (SYS.itemsLevel[? "Letter"] * 0.1);
	magnet = baseMagnet + baseMagnet * (SYS.itemsLevel[? "Ring"] * 0.15);
	attackSpeed = baseAttackSpeed + baseAttackSpeed * (SYS.itemsLevel[? "BubbleTea"] * 0.05);
	attackInfo.attack = info.attackInfo.attack + info.attackInfo.attack * (SYS.itemsLevel[? "Flower"] * 0.1);
	attackCritical = baseAttackCritical + baseAttackCritical * (SYS.itemsLevel[? "Magazine"] * 0.05);
	attackCriticalMultiplier = baseAttackCriticalMultiplier + baseAttackCriticalMultiplier * (SYS.itemsLevel[? "Socks"] * 0.5);
	attackInfo.size = info.attackInfo.size + info.attackInfo.size * (SYS.itemsLevel[? "Button"] * 0.1);
	attackInfo.life = info.attackInfo.life + info.attackInfo.life * (SYS.itemsLevel[? "StuffedAnimal"] * 0.05);
	attackRange = baseAttackRange;
	
	var bulletSpeed = info.attackInfo.moveSpeed + info.attackInfo.moveSpeed
	
	switch(name){
		case "A":{
			switch(level){
				case 6:
					moveSpeed += moveSpeed * 0.15;
					magnet += magnet * 0.15;
					attackSpeed += attackSpeed * 0.15;
					attackInfo.attack += attackInfo.attack * 0.15;
					attackCritical += attackCritical * 0.15;
					attackCriticalMultiplier += attackCriticalMultiplier * 0.15;
					attackInfo.size += attackInfo.size * 0.15;
					attackInfo.life += attackInfo.life * 0.15;
				case 5:
					attackInfo.size += attackInfo.size * 0.35;
				case 4:
					attackCriticalMultiplier += attackCriticalMultiplier * 1;
				case 3:
					info.attackInfo.amount = 2;
				case 2:
					attackInfo.attack += attackInfo.attack * 0.5;
			}
		}
		break;
		case "B":{
			switch(level){
				case 6:
					attackSpeed += attackSpeed * 0.4;
				case 5:
				case 4:
					attackInfo.size += attackInfo.size * 0.2;
				case 3:
					attackInfo.life += attackInfo.life * 0.5;
				case 2:
					attackCritical += attackCritical * 0.15;
			}
		}
		break;
		case "C":{
			switch(level){
				case 6:
				case 5:
					attackCritical += attackCritical * 0.15;
				case 4:
				case 3:
					attackInfo.moveSpeed = bulletSpeed * 1.35;
				case 2:
					attackRange += attackRange * 0.25;
			}
		}
		break;
		case "D":{
			switch(level){
				case 6:
					attackCriticalMultiplier += attackCriticalMultiplier * 0.25;
				case 5:
					attackInfo.size += attackInfo.size * 0.2;
				case 4:
				case 3:
					attackInfo.moveSpeed = bulletSpeed * 1.05;
				case 2:
					attackInfo.life += attackInfo.life * 0.4;
			}
		}
		break;
		case "E":{
			switch(level){
				case 6:
					attackInfo.attack += attackInfo.attack * 0.35;
				case 5:
				case 4:
					attackCriticalMultiplier += attackCriticalMultiplier * 0.5;
				case 3:
					moveSpeed += moveSpeed * 0.5;
				case 2:
					attackSpeed += attackSpeed * 0.3;
			}
		}
		break;
	}
}