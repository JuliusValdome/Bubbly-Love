function CharacterEnemy_GetInfo(){
	var info = Object_SpawnEnemy.EnemyCharacters[$ name];
	
	var baseSpeed = info.Speed;
	var hp = info.HP + info.HP * (SYS.LevelEnemy * 0.5);
	var AtSpd = info.AtackTime;
	
	MoveSpeed = baseSpeed;
	maxHealth = hp;
	Health = maxHealth;
	AtackSpeed = AtSpd;
	baseAttackSpeed = AtackSpeed;
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
	var healingChance = irandom_range(0, 100) <= 8;
	var antipanicButton = irandom_range(0, 100) <= 2;
	var magnet = irandom_range(0, 100) <= 5;
	
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
	if (name == "EnemyBoss" and SYS.LevelEnemy > 14){
		SYS.FlagYouWin = true;
	}
}

function CharacterEnemy_Sprite(){
	sprite_index = asset_get_index("Sprite_" + name);
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