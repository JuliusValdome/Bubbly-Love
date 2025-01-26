function CharacterEnemy_GetInfo(){
	var info = Object_SpawnEnemy.EnemyCharacters[$ name];
	
	var baseSpeed = info.Speed;
	var hp = info.HP + info.HP * (SYS.LevelEnemy * 0.25);
	var AtSpd = info.AtackTime;
	
	MoveSpeed = baseSpeed;
	maxHealth = hp;
	Health = maxHealth;
	AtackSpeed = AtSpd;
	if (name != "Enemy5"){
		Direction = point_direction(x, y, Object_Tower.x, Object_Tower.y);
		direction = Direction;
	}else{
		Direction = point_direction(x, y, Object_Tower.x, Object_Tower.y) + random_range(-15, 15);
		direction = Direction;
		baseSPD = 2;	
	}
}

function CharacterEnemy_Variables(){
	gotHitTimerBase = SECOND / 6;
	gotHitTimer = gotHitTimerBase;
	gotHit = false;	
	defeatFlag = false;
}

function Enemy_Control(){		
	if Health <= 0{
		defeatFlag = true;
	}
}

function Enemy_Defeat(){
	if (!defeatFlag)	return 0;
	var healingChance = irandom(100) <= 8 ? true : false;
	var antipanicButton = irandom(100) <= 2 ? true : false;
	var magnet = irandom(100) <= 5 ? true : false;
	
	speed = 0;
	image_yscale -= (1 / (SECOND / 2)) * SLOW;
	if (image_yscale <= 0){
		instance_create_depth(x, y, depth - 1, Object_DropBubble, {name: "Love"});
		if (healingChance)
			instance_create_depth(x, y, depth - 1, Object_DropBubble, {name: "Healing"});
		if (antipanicButton)
			instance_create_depth(x, y, depth - 1, Object_DropBubble, {name: "AntiPanic"});
		if (magnet)
			instance_create_depth(x, y, depth - 1, Object_DropBubble, {name: "Magnet"});
		instance_destroy();
	}
	if name == "EnemyBoss"{
		SYS.FlagYouWin = true;
	}
}

function CharacterEnemy_Sprite(){
	sprite_index = asset_get_index("Sprite_" + name);
}

function Enemy_atack(){
	if x < Object_Tower.x{
		image_xscale = -1;
	}
	switch(name){
		case "Enemy1":
			if distance_to_point( Object_Tower.x,  Object_Tower.y) <= 32{
				speed = 0;
			    if AtackSpeed <= 0{
					var Spawn_Direction = point_direction(x, y, Object_Tower.x, Object_Tower.y);
			        var dist = 40;
			        instance_create_depth(Object_Enemy.x + lengthdir_x(dist, Spawn_Direction), Object_Enemy.y + lengthdir_y(dist, Spawn_Direction), 0, Object_AtackMele);
					AtackSpeed = SECOND;
				}else{
					AtackSpeed -= 1 * SLOW;
				}
			}else{				
				speed = MoveSpeed * SLOW;
			}
			break;
		case "Enemy2":
			if distance_to_point( Object_Tower.x,  Object_Tower.y) <= 32{
				speed = 0;
			    if AtackSpeed <= 0{
					var Spawn_Direction = point_direction(x, y, Object_Tower.x, Object_Tower.y);
			        var dist = 40;
			        instance_create_depth(Object_Enemy.x + lengthdir_x(dist, Spawn_Direction), Object_Enemy.y + lengthdir_y(dist, Spawn_Direction), 0, Object_AtackMele);
					AtackSpeed = SECOND / 2;
				}else{
					AtackSpeed -= 1 * SLOW;
				}
			}else{				
				speed = MoveSpeed * SLOW;
			}
			break;
		case "Enemy3":
			if point_distance(x, y, Object_Tower.x, Object_Tower.y) < 400{
				speed = 0;
				if AtackSpeed <= 0{
					var bllt = instance_create_depth(x, y, 0, Object_BulletEnemy);
					bllt.direction = point_direction(x, y, Object_Tower.x, Object_Tower.y);
					bllt.speed = 8;
					bllt.BaseSPD = 8;
					AtackSpeed = SECOND / 2;
				}else{
					AtackSpeed -= 1 * SLOW;
				}
			}else{
				speed = MoveSpeed * SLOW;
			}
			break;
		case "Enemy4":
			if distance_to_point( Object_Tower.x,  Object_Tower.y) <= 32{
				speed = 0;
				if AtackSpeed <= 0{
			        instance_create_depth(x, y, 0, Object_AtackExpansive);
					AtackSpeed = room_speed * 2;
				}else{
					AtackSpeed -= 1 * SLOW;
				}
			}else{
				speed = MoveSpeed * SLOW;
			}
			break;
		case "Enemy5":
			speed = baseSPD * SLOW;
			if direction < 270 and direction > 90{
				image_xscale = 1;
			}else{
				image_xscale = -1;
			}
					
			if FlagMove <= 0{
				speed = 0;
				var Aura = instance_create_depth(x, y, 0, Object_Aura, {creator : id});	
				if Health <= 0{
					instance_destroy(Aura);
					instance_destroy();
				}
			}else{
				FlagMove -= 1 * SLOW;
			}
			break;
		case "EnemyBoss":
			if distance_to_point( Object_Tower.x,  Object_Tower.y) <= 32{
				speed = 0;
			    if AtackSpeed <= 0{
					var Spawn_Direction = point_direction(x, y, Object_Tower.x, Object_Tower.y);
			        var dist = 40;
			        var BossAtack = instance_create_depth(Object_Enemy.x + lengthdir_x(dist, Spawn_Direction), Object_Enemy.y + lengthdir_y(dist, Spawn_Direction), 0, Object_AtackMeleBoss);
					BossAtack.Damage = 6;
					AtackSpeed = SECOND * 3;
				}else{
					AtackSpeed -= 1 * SLOW;
				}
			}else{	
				speed = MoveSpeed * SLOW;
			}
			break;
	}
}

function Enemy_GotHit(){
	if (gotHit){
		if (gotHitTimer > 0){
			gotHitTimer -= 1 * SLOW;
		}else{
			gotHitTimer = SECOND / 2;
			gotHit = false;	
		}
	}	
}