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
	hitList = ds_list_create();
		
	x = creator.x + lengthdir_x(info.offset, attackDirection);	
	y = creator.y + lengthdir_y(info.offset, attackDirection);	
	image_xscale = info.size;
	image_yscale = info.size;
	
	hitbox = instance_create_depth(x, y, depth + 1, Object_AttackHitbox, {creator: id});
	damage = floor(info.damage * (isCrit ? critMult : 1));
	damage = damage < 1 ? 1 : damage;
	life = info.life;
	
	bounce = true;	
	contact = false;
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
	if (image_alpha <= 0)	Attack_Despawn_And_Destroy();
}

function Attack_Step_Dulce(){
	var level = SYS.girlsLevel[? name];
	
	life -= SLOW;
	Attack_Move();
	hitbox.offset = sprite_get_width(sprite_index) / 2;
	
	if (level >= 5)	attackDirection += (720 / SECOND) * SLOW;
	
	if (image_index >= image_number -1)	image_index = image_number -1;
	if (life <= 0)	Attack_Despawn_And_Destroy();
}

function Attack_Step_Hua(){
	var level = SYS.girlsLevel[? name];
	
	life -= SLOW;
	Attack_Move();
	
	if (!contact)	return 0;
	if (level < 6 or !bounce)	Attack_Despawn_And_Destroy();
	
	bounce = false;
	contact = false;
	var hitWho = instance_place(x, y, Object_Enemy);
	var nextTarget = Attack_GetFurthestTarget(hitWho, creator.attack.range * 1.5);
	if (nextTarget != noone){
		attackDirection = point_direction(x, y, nextTarget.x, nextTarget.y);
		life += SECOND * 2;
		hitbox = instance_create_depth(x, y, depth + 1, Object_AttackHitbox, {creator: id});
	}else{
		Attack_Despawn_And_Destroy();
	}
}

function Attack_Step_Tanja_Burn(){
	instance_destroy(hitbox);
	name = "Tanja_Burn";
	attackDirection = 0;
	life += SECOND * 2;
	hitbox = instance_create_depth(x, y, depth + 1, Object_AttackHitbox, {creator: id});
	info.finite = false;
	info.moveSpeed = 0;
}

function Attack_Step_Tanja(){
	var burn = (name == "Tanja_Burn");
	life -= SLOW;
	Attack_Move();
	
	if (!burn and (contact or life <= 0)){
		Attack_Step_Tanja_Burn();	
	}
	
	if (burn){
		if (life <= 0){
			image_alpha -= (4 / (SECOND)) * SLOW;
			if (image_alpha <= 0)	Attack_Despawn_And_Destroy();
		}
	}
	
	if (floor(life) % 25 == 0){
		ds_list_clear(hitList);
	}
}

function Attack_Step_Miyuki(){
	var wave = (name == "Miyuki_Wave");
	var mvSpd = info.moveSpeed * (!wave ? 2 : 1) * SLOW;
	var level = SYS.girlsLevel[? name];
	var attacks = creator.attacks;
	
	life -= SLOW;	
	if (life <= 0)	Attack_Despawn_And_Destroy();
	
	x += lengthdir_x(mvSpd * 2, attackDirection);
	y += lengthdir_y(mvSpd * 2, attackDirection);
	
	if (!wave and contact){
		if (level >= 5){
			var startingAngle = attackDirection + irandom(45) * choose(-1, 1);
			var angleOffset = 360 / attacks;
			for(var i = 0; i < attacks; i++){
				var createAngle = startingAngle + angleOffset * i;
				var waveBullet = instance_create_depth(x, y, depth + 1, Object_Character_Attack, {creator: creator.id, name: "Miyuki", attackDirection: createAngle, info: info, isCrit: 0, critMult: 1});
				waveBullet.life = life * 2;
				waveBullet.damage = floor(creator.attack.damage * 0.3 * (isCrit ? critMult : 1));
				waveBullet.damage = waveBullet.damage < 1 ? 1 : waveBullet.damage;
				waveBullet.name = "Miyuki_Wave";
			}
		}
		with(creator){
			x = attackTarget.x + lengthdir_x(150, other.attackDirection);	
			y = attackTarget.y + lengthdir_y(150, other.attackDirection);	
		}
		Attack_Despawn_And_Destroy();
	}
}

function Attack_DealDamage(){
	if (!instance_exists(creator))	return 0;
	
	with(hitbox){
		var enemyHitBox = instance_place(x, y, Object_Enemy_HitBox);
		if (!instance_exists(enemyHitBox))	return;
		
		var enemy = enemyHitBox.creator;
		if (!instance_exists(enemy))	return;
		
		other.contact = true;
		
		if (ds_list_find_index(creator.hitList, enemy.id) == -1) {
            ds_list_add(creator.hitList, enemy.id);
            Attack_DealDamage_Decrease(enemy);
        }
		
		if (other.info.finite) {
            instance_destroy();
        }
	}
}

function Attack_DealDamage_Decrease(enemy){
	audio_stop_sound(SFX_Attack);
    audio_play_sound(SFX_Attack, 2, false);

    enemy.Health -= creator.damage;
    enemy.gotHit = true;
    enemy.gotHitTimer = enemy.gotHitTimerBase;

    instance_create_depth(enemy.x, enemy.y - 10, enemy.depth - 1, Object_Enemy_DamageReceived, {damage: creator.damage, crit: other.isCrit});	
}

function Attack_GetFurthestTarget(hitWho, maxDistance){
	if (instance_number(Object_Enemy) < 2)	return noone;
	
	var trgt = noone;
	var minDist = maxDistance;
	
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