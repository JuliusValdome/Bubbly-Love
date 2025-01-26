function Script_SpawnEnemy(){
	System_CharacterEnemyInfo();
	if SpawnCont <= 0 and FlagStopEnemy == false{
		var Tipo = enemyList[| 0];
		ds_list_delete(enemyList, 0);
		switch(Tipo){
			case "Enemy1":					
				var Enemy = instance_create_depth(x, y, 0, Object_Enemy, {name: Tipo});
				with(Enemy){
					CharacterEnemy_GetInfo();
				}
				DestroyCont --;
				SpawnCont = SECOND * random_range(2.5, 4);
				break;
			case "Enemy2":									
				var Enemy = instance_create_depth(x, y, 0, Object_Enemy, {name: Tipo});
				with(Enemy){
					CharacterEnemy_GetInfo();
				}
				DestroyCont --;
				SpawnCont = SECOND * random_range(2.5, 4);
				break;
			case "Enemy3":									
				var Enemy = instance_create_depth(x, y, 0, Object_Enemy, {name: Tipo});
				with(Enemy){
					CharacterEnemy_GetInfo();
				}
				DestroyCont --;
				SpawnCont = SECOND * random_range(2.5, 4);
				break;
			case "Enemy4":									
				var Enemy = instance_create_depth(x, y, 0, Object_Enemy, {name: Tipo});
				with(Enemy){
					CharacterEnemy_GetInfo();
				}
				DestroyCont --;
				SpawnCont = SECOND * random_range(2.5, 4);
				break;
			case "Enemy5":									
				var Enemy = instance_create_depth(x, y, 0, Object_Enemy, {name: Tipo});
				with(Enemy){
					CharacterEnemy_GetInfo();
				}
				DestroyCont --;
				SpawnCont = SECOND * random_range(2.5, 4);
				break;
		}
	}else{
		SpawnCont D_ONE;
	}
	if DestroyCont <= 0{
		ds_list_destroy(enemyList);
		instance_destroy();
	}
	Object_System.DfTimer += 1 * SLOW;
}



function Script_SpawnBoss(){
	if FlagBossExists == false and !instance_exists(Object_Enemy){
		audio_stop_sound(Music_Stage);
		audio_play_sound(Music_Boss, 1, true, 0.7);
		sprite_index = Sprite_SpawnBoss;
		instance_create_depth(x, y, 0, Object_Enemy, {name : "EnemyBoss"});
		FlagBossExists = true;
		FlagStopEnemy = true;
	}
}