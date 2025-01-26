function Attacks_GetSprite(){
	sprite_index = asset_get_index("Sprite_Character_Attack_" + name);
	image_angle = attackDirection;
	image_speed = (image_speed) * SLOW;
	//image_index = image_index >= image_number ? image_number : image_index;
}

function Attack_General(){
	if (instance_exists(hitbox)){
		with(hitbox){
			var _x = creator.x + lengthdir_x(offset, attackDirection);
			var _y = creator.y + lengthdir_y(offset, attackDirection);
		
			x = _x;
			y = _y;
		}
	}
	
	if (x < -100 or x > room_width + 100 or y < -100 or y > room_height + 100)
		instance_destroy();
}

function Attack_Variables_A(){
	var _x = creator.x + lengthdir_x(info.offSet, attackDirection);
	var _y = creator.y + lengthdir_y(info.offSet, attackDirection);
	x = _x;
	y = _y;
	life = info.life;
}

function Attack_Step_A(){
	life -= 1 * SLOW;
	if (life <= 0){//instance_destroy();
		if (image_index >= image_number -2){
			if (instance_exists(hitbox))	instance_destroy(hitbox);
			image_index = image_number - 2;
			image_alpha -= (1 / (SECOND * 0.5)) * SLOW;
			if (image_alpha <= 0)	instance_destroy();
		}
	}
	//if (image_index >= (image_number - 1))	instance_destroy();
}

function Attack_Variables_B(){
	var _x = creator.x + lengthdir_x(info.offSet, attackDirection);
	var _y = creator.y + lengthdir_y(info.offSet, attackDirection);
	x = _x;
	y = _y;
	baseLife = info.life;
	life = baseLife;
}

function Attack_Step_B(){
	var level = SYS.girlsLevel[? name];
	var mvSpd = info.moveSpeed * SLOW;
	
	life -= 1 * SLOW;
	
	if (level >= 5){
		attackDirection += (360 / SECOND * 0.5) * SLOW;
		if (instance_exists(hitbox)){
			hitbox.attackDirection = attackDirection;	
		}
	}
	
	x += lengthdir_x(mvSpd, attackDirection);
	y += lengthdir_y(mvSpd, attackDirection);
	//var lifeP = (life / baseLife) * SLOW;
	
	//image_yscale = (1 + lifeP * 0.5) * SLOW;
	if (image_index >= image_number -1)	image_index = image_number -1;
	if (life <= 0)	instance_destroy();
}

function Attack_Variables_C(){
	var _x = creator.x + lengthdir_x(info.offSet, attackDirection);
	var _y = creator.y + lengthdir_y(info.offSet, attackDirection);
	x = _x;
	y = _y;
	baseLife = info.life;
	life = baseLife;
	contact = false;
}

function Attack_Step_C(){
	var level = SYS.girlsLevel[? name];
	var mvSpd = info.moveSpeed * SLOW;
	
	if (contact){
		if (level >= 6){
			if (bounce){
				bounce = false;	
				var nextTarget = instance_furthest(x, y, Object_Enemy);
				if (instance_exists(nextTarget)){
					if (distance_to_point(nextTarget.x, nextTarget.y) >= creator.attackRange){
						sprite_index = Sprite_Character_Attack_C_Explode;
						if (image_index >= (image_number - 2))	instance_destroy();
					}else{
						attackDirection = point_direction(x, y, nextTarget.x, nextTarget.y);
						life = SECOND;
						contact = false;
					}
				}
			}else{
				sprite_index = Sprite_Character_Attack_C_Explode;
				if (image_index >= (image_number - 2))	instance_destroy();
			}
		}else{
			sprite_index = Sprite_Character_Attack_C_Explode;
			if (image_index >= (image_number - 2))	instance_destroy();
		}
	}else{
		x += lengthdir_x(mvSpd, attackDirection);
		y += lengthdir_y(mvSpd, attackDirection);
	
		life -= 1 * SLOW;
		if (life <= 0)	instance_destroy();
	}
}

function Attack_Variables_D(){
	var _x = creator.x + lengthdir_x(info.offSet, attackDirection);
	var _y = creator.y + lengthdir_y(info.offSet, attackDirection);
	x = _x;
	y = _y;
	baseLife = info.life;
	life = baseLife;
	contact = false;
}

function Attack_Step_D(){
	if (contact){
		image_angle = 0;
		sprite_index = Sprite_Character_Attack_D_Explode;
		
		life -= 1 * SLOW;
		
		if (life % 12 == 0){
			instance_destroy(hitbox);
			HitList = [];
			hitbox = instance_create_depth(x, y, depth + 1, Object_AttackHitbox, {creator: id, offset: 0, attackDirection: 0});
		}
		if (life <= 0)	instance_destroy()
	}else{
		x += lengthdir_x(info.moveSpeed, attackDirection);
		y += lengthdir_y(info.moveSpeed, attackDirection);
	
		life -= 1 * SLOW;
		if (life <= 0){
			image_angle = 0;
			instance_destroy(hitbox);
			HitList = [];
			hitbox = instance_create_depth(x, y, depth + 1, Object_AttackHitbox, {creator: id});
			life = baseLife;
			contact = true;
			info.oneContact = false;
		}
	}
}

function Attack_Variables_E(){
	var _x = creator.x + lengthdir_x(info.offSet, attackDirection);
	var _y = creator.y + lengthdir_y(info.offSet, attackDirection);
	x = _x;
	y = _y;
	
	baseLife = info.life;
	life = baseLife;
	contact = false;
}

function Attack_Step_E(){	
	var level = SYS.girlsLevel[? name];
	var mvSpd = info.moveSpeed * SLOW;
	
	
	x += lengthdir_x(mvSpd, attackDirection);
	y += lengthdir_y(mvSpd, attackDirection);
	
	if (contact){
		if (level >= 5){
			var dir = irandom(360);
			for(var i = 0; i < 8; i++){
				instance_create_depth(x, y, depth + 1, Object_Character_Attack, {creator: creator.id, name: "E_B", attackDirection: dir + 45 * i, info: info, isCrit: 0, critMult: 1});		
			}
		}		
		creator.x = x + lengthdir_x(75, attackDirection);
		creator.y = y + lengthdir_y(75, attackDirection);
		
		instance_destroy();
	}
}

function Attack_Variables_EB(){
	var _x = creator.x + lengthdir_x(15, attackDirection);
	var _y = creator.y + lengthdir_y(15, attackDirection);
	x = _x;
	y = _y;
	image_angle = attackDirection;
	
	baseLife = SECOND * 2.5;
	life = baseLife;
	contact = false;
	info = {};
	info.oneContact = true;
	isCrit = false;
	damage = choose(2, 3);
}

function Attack_Step_EB(){	
	var mvSpd = 12;
	
	x += lengthdir_x(mvSpd, attackDirection);
	y += lengthdir_y(mvSpd, attackDirection);
	
	if (contact){
		image_alpha -= (1 / (SECOND * 0.25)) * SLOW;
		if (image_alpha <= 0)		
			instance_destroy();
	}
}

function Attack_DealDamage(){
	if (!instance_exists(creator))	return 0;
	
	with(hitbox){
		if (other.info.oneContact){
			if (place_meeting(x, y, Object_Enemy_HitBox) and instance_exists(creator)){
				other.contact = true;
				var enemy = instance_place(x, y, Object_Enemy_HitBox);
				enemy = enemy.creator;
				if (instance_exists(enemy)){
					instance_create_depth(enemy.x, enemy.y - 10, enemy.depth - 1, Object_Enemy_DamageReceived, {damage: creator.damage, crit: other.isCrit});
					enemy.Health -= creator.damage;
					enemy.gotHit = true;
					enemy.gotHitTimer = enemy.gotHitTimerBase;
				}
				instance_destroy();
			}
		}else{
			if (place_meeting(x, y, Object_Enemy_HitBox) and instance_exists(creator)){
				other.contact = true;
				var list = creator.HitList;
				var size = array_length(list);
				var enemy = instance_place(x, y, Object_Enemy_HitBox);
				enemy = enemy.creator;
				var notFound = true;
			
				for(var i = 0; i < size; i++){
					if (list[i] == enemy.id){
						notFound = false;
						break;
					}
				}
			
				if (notFound){	
					if (instance_exists(enemy)){
						audio_stop_sound(SFX_Attack);
						audio_play_sound(SFX_Attack, 2, false);
						creator.HitList[size] = enemy;
						enemy.Health -= creator.damage;
						enemy.gotHit = true;
						enemy.gotHitTimer = enemy.gotHitTimerBase;
						instance_create_depth(enemy.x, enemy.y - 10, enemy.depth - 1, Object_Enemy_DamageReceived, {damage: creator.damage, crit: other.isCrit});
					}
				}
			}
		}
	}
}