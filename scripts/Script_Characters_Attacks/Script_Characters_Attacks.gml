function Attack_HitBox(){	
	attackDirection = creator.attackDirection;	
	image_angle = attackDirection;	
	x = creator.x + lengthdir_x(offset, attackDirection);
	y = creator.y + lengthdir_y(offset, attackDirection);
	image_xscale = creator.sprite_width / 2.5;
	image_yscale = creator.sprite_height / 2.5;
}

function Attack_GetSprite(){
	sprite_index = asset_get_index("Sprite_Character_Attack_" + name);
	image_angle = attackDirection;
	image_speed = (image_speed) * SLOW;
}

function Attack_General(){	
	if (x < -100 or x > room_width + 100 or y < -100 or y > room_height + 100)	instance_destroy();
}

function Attack_Variables(){
	HitList = [];
		
	x = creator.x + lengthdir_x(info.offset, attackDirection);	
	y = creator.y + lengthdir_y(info.offset, attackDirection);	
	image_xscale = info.size;
	image_yscale = info.size;
	
	hitbox = instance_create_depth(x, y, depth + 1, Object_AttackHitbox, {creator: id});
	damage = floor(info.attack * (isCrit ? critMult : 1));
	damage = damage < 1 ? 1 : damage;
	life = info.life;
	
	bounce = true;	
	contact = false;
	
	switch(name){
		case "Tanja_Burn":
			Attack_Variables_TanjaBurn();
			break;
		case "Miyuki_Wave":
			Attack_Variables_MiyukiWave();
			break;
	}	
}

function Attack_Move(){
	var mvSpd = info.moveSpeed * SLOW;
	
	x += lengthdir_x(mvSpd, attackDirection);	
	y += lengthdir_y(mvSpd, attackDirection);	
}

function Attack_Step_Lily(){
	life -= SLOW;
	if (life <= 0){
		instance_destroy(hitbox);	
		if (image_index >= (image_number - 2)){
			image_index = (image_number - 1);
			image_alpha -= (4 / SECOND) * SLOW;
		}
	}
	if (image_alpha <= 0)	instance_destroy();
}

function Attack_Step_Dulce(){
	var level = SYS.girlsLevel[? name];
	
	life -= SLOW;
	Attack_Move();
	hitbox.offset = sprite_get_width(sprite_index) / 2;
	
	if (level >= 5)	attackDirection += (720 / SECOND) * SLOW;
	
	if (image_index >= image_number -1)	image_index = image_number -1;
	if (life <= 0)	instance_destroy();
}

function Attack_Step_Hua(){
	var level = SYS.girlsLevel[? name];
	
	Attack_Move();
	
	if (contact){
		if (level >= 6){
			if (bounce){
				bounce = false;
				contact = false;
				var hitWho = instance_place(x, y, Object_Enemy);
				var nextTarget = Attack_GetFurthestTarget(hitWho);
		
				if (nextTarget != noone){
					if (distance_to_point(nextTarget.x, nextTarget.y) < (creator.attackRange * 1.25)){
						attackDirection = point_direction(x, y, nextTarget.x, nextTarget.y);
						life += SECOND * 2;
						hitbox = instance_create_depth(x, y, depth + 1, Object_AttackHitbox, {creator: id});
					}else{
						instance_destroy();	
					}
				}else{
					instance_destroy();		
				}
			}else{
				instance_destroy();	
			}
		}else{
			instance_destroy();	
		}
	}
}

function Attack_GetFurthestTarget(hitWho){
	if (instance_number(Object_Enemy) < 2)	return noone;
	
	var trgt = noone;
	var minDist = 999999;
	
	with (Object_Enemy){
		var distToCheck = point_distance(x, y, other.x, other.y);
		if (hitWho != id){ 
			if (minDist > distToCheck){
				minDist = distToCheck;
				trgt = id;
			}
		}
	}	
	return trgt;
}

function Attack_Step_Tanja(){
	if (contact){
		if (name == "Tanja"){
			var mvSpd = info.moveSpeed * SLOW;
			x += lengthdir_x(mvSpd, attackDirection);
			y += lengthdir_y(mvSpd, attackDirection);
			image_xscale -= (4 / SECOND) * SLOW;
			image_yscale -= (4 / SECOND) * SLOW;
		}
		//image_angle = 0;
		image_alpha -= (4 / SECOND) * SLOW;
		//sprite_index = Sprite_Character_Attack_D_Explode;
		
		life -= 1 * SLOW;
		
		if (life % 12 == 0){
			//instance_destroy(hitbox);
			HitList = [];
			//hitbox = instance_create_depth(x, y, depth + 1, Object_AttackHitbox, {creator: id, offset: 0, attackDirection: 0});
		}
		if (image_alpha <= 0)	instance_destroy();
		if (life <= 0)	instance_destroy()
	}else{
		x += lengthdir_x(info.moveSpeed, attackDirection);
		y += lengthdir_y(info.moveSpeed, attackDirection);
	
		life -= 1 * SLOW;
		if (life <= 0){
			image_angle = 0;
			//instance_destroy(hitbox);
			HitList = [];
			//hitbox = instance_create_depth(x, y, depth + 1, Object_AttackHitbox, {creator: id});
			life = baseLife;
			contact = true;
			info.oneContact = false;
		}
	}
}

function Attack_Variables_TanjaBurn(){
	var _x = creator.x + lengthdir_x(info.offset, attackDirection);
	var _y = creator.y + lengthdir_y(info.offset, attackDirection);
	x = _x;
	y = _y;
	baseLife = info.life;
	life = baseLife;
	contact = false;
}

function Attack_Step_TanjaBurn(){
	var _x = creator.x + lengthdir_x(info.offset, attackDirection);
	var _y = creator.y + lengthdir_y(info.offset, attackDirection);
	x = _x;
	y = _y;
	baseLife = info.life;
	life = baseLife;
	contact = false;
}

function Attack_Step_Miyuki(){	
	var level = SYS.girlsLevel[? name];
	var mvSpd = info.moveSpeed * SLOW;
	
	
	x += lengthdir_x(mvSpd, attackDirection);
	y += lengthdir_y(mvSpd, attackDirection);
	
	if (contact){
		if (level >= 5){
			var dir = irandom(360);
			for(var i = 0; i < 8; i++){
				instance_create_depth(x, y, depth + 1, Object_Character_Attack, {creator: creator.id, name: "Miyuki_Wave", attackDirection: dir + 45 * i, info: info, isCrit: 0, critMult: 1});		
			}
		}		
		creator.x = x + lengthdir_x(75, attackDirection);
		creator.y = y + lengthdir_y(75, attackDirection);
		
		instance_destroy();
	}
}

function Attack_Variables_MiyukiWave(){
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

function Attack_Step_MiyukiWave(){	
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