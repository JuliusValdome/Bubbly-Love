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
					AtackSpeed = baseAttackSpeed;
				}else{
					AtackSpeed D_ONE;
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
					AtackSpeed = baseAttackSpeed;
				}else{
					AtackSpeed D_ONE;
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
					AtackSpeed = baseAttackSpeed;
				}else{
					AtackSpeed D_ONE;
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
					AtackSpeed = baseAttackSpeed;
				}else{
					AtackSpeed D_ONE;
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
					AtackSpeed = baseAttackSpeed;
				}else{
					AtackSpeed D_ONE;
				}
			}else{	
				speed = MoveSpeed * SLOW;
			}
			break;
	}
}