function System_Create_Config(){
	window_set_cursor(cr_none);	
}

function System_GameOver_VariablesReset(){
	stageCreateFlag = true;
	menuCreateFlag = true;
	ButtomFlag = true;
	BossFlag = false;
	FlagYouWin = false;
	TimerWin = SECOND;
	NumPortal = 0;
	LevelEnemy = 1;	
	
	global.GameOverEvent = true;
	global.LevelUpEvent = true;
	global.StartLevelUp = true;
	
	ds_list_clear(availableGirls);
	ds_list_clear(availablePassives);
	ds_list_clear(availableBoosts);
	ds_list_add(availableGirls, "Lily", "Dulce", "Hua", "Tanja", "Miyuki");
	for(var i = 0; i < array_length(listedItems); i++){
		ds_list_add(availablePassives, listedItems[i]);
	}
	ds_list_add(availableBoosts, "Soda", "Wallet", "Cookies");
	
	recruitedGirls = [];
	passiveItems = [];
	playerTeam = [];
	
	DfTimer = 0;
	loveLevel = 1;
	loveNextLevel = 5;
	love = 0;
	
	for(var i = 0; i < ds_map_size(girlsLevel); i++){
		ds_map_replace(girlsLevel, listedGirls[i], 0);	
	}
	for(var i = 0; i < ds_map_size(itemsLevel); i++){
		ds_map_replace(itemsLevel, listedItems[i], 0);	
	}
}

function System_Create_Variables(){
	global.Mouse = instance_create_depth(x, y, -100, Object_Mouse);	
	
	listedGirls = ["Lily", "Dulce", "Hua", "Tanja", "Miyuki"];
	listedItems =  ["Letter", "Ring", "BubbleTea", "Button", "Flower", "StuffedAnimal", "Magazine", "Socks"];
	listedItemsDescriptions = 
	["Increases Movespeed", "Increases items collection radius", "Enhances the Attack Speed",
	 "The size of the projectiles grows", "Increase the damage dealt", "Boosts the amount of attacks",
	 "The chances of critical strikes increases", "Critical strikes are more powerful"];
	availableGirls = ds_list_create();
	availablePassives = ds_list_create();
	availableBoosts = ds_list_create();
	ds_list_add(availableBoosts, "Soda", "Wallet", "Cookies");
	recruitedGirls = [];
	passiveItems = [];
	playerTeam = [];
	girlsLevel = ds_map_create();
	itemsLevel = ds_map_create();
	for(var i = 0; i < array_length(listedGirls); i++){
		ds_list_add(availableGirls, listedGirls[i]);
		ds_map_add(girlsLevel, listedGirls[i], 0);
	}
	for(var i = 0; i < array_length(listedItems); i++){
		ds_list_add(availablePassives, listedItems[i]);
		ds_map_add(itemsLevel, listedItems[i], 0);
	}
	
	DfTimer = 0;
	
	loveLevel = 1;
	loveNextLevel = 5;
	love = 0;
	stageCreateFlag = true;
	menuCreateFlag = true;	
}

function System_Create_Globals(){
	global.nGameSpeed = 1;
	global.sGameSpeed = 0.1;
	global.pGameSpeed = 0;
	global.slowMotion = false;
	global.slowMoTimer = 0;
	global.slowMoMax = global.nGameSpeed - global.sGameSpeed;
	global.LevelUpEvent = true;
	global.StartLevelUp = true;
	global.GameOverEvent = true;
}

function System_Create_CharacterInfo(){
	var lilySize = sprite_get_width(Sprite_Character_Attack_Lily);
	var lilyNumber = sprite_get_number(Sprite_Character_Attack_Lily) - 1;
	var lilySpeed = sprite_get_speed(Sprite_Character_Attack_Lily);
	
	var DulceSize = sprite_get_width(Sprite_Character_Attack_Dulce);
	var DulceNumber = sprite_get_number(Sprite_Character_Attack_Dulce) - 1;
	var DulceSpeed = sprite_get_speed(Sprite_Character_Attack_Dulce);
	
	Characters = {
		Lily: {
			attackCritical: 1,
			attackCriticalMultiplier: 2.5,
			attackRange: lilySize * 0.9,
			attackSpeed: 0.5,
			moveSpeed: 5,
			magnet: 30,
			offset: lilySize * 0.7,
			attackInfo: {
				attack: 5,
				life: (lilyNumber / lilySpeed) * SECOND,
				amount: 1,
				moveSpeed: 0,
				oneContact: false,
				size: 1
			},
		},
		Dulce: {
			attackCritical: 1,
			attackCriticalMultiplier: 3,
			attackRange: DulceSize * 0.9,
			attackSpeed: 0.4,
			moveSpeed: 4,
			magnet: 50,
			offset: DulceSize * 0.05,
			attackInfo: {
				attack: 3,
				life: (DulceNumber / DulceSpeed) * SECOND,
				amount: 1,
				moveSpeed: 1,
				oneContact: false,
				size: 1
			},
		},
		Hua: {
			attackCritical: 4,
			attackCriticalMultiplier: 2,
			attackRange: 600,
			attackSpeed: 0.7,
			moveSpeed: 2,
			magnet: 75,
			offset: 0,
			attackInfo: {
				attack: 1.5,
				life: SECOND * 5,
				amount: 1,
				moveSpeed: 30,
				oneContact: true,
				size: 1
			},
		},
		Tanja: {
			attackCritical: 1,
			attackCriticalMultiplier: 5,
			attackRange: 425,
			attackSpeed: -0.5,
			moveSpeed: 3,
			magnet: 30,
			offset: -15,
			attackInfo: {
				attack: 10,
				life: SECOND * 1.75,
				offset: 0,
				amount: 1,
				moveSpeed: 15,
				oneContact: true,
				size: 1
			},
		},
		Miyuki: {
			attackCritical: 0.5,
			attackCriticalMultiplier: 6,
			attackRange: 175,
			attackSpeed: 0.001,
			moveSpeed: 7,
			magnet: 20,
			offset: 0,
			attackInfo: {
				attack: 3,
				life: SECOND * 0.15,
				offset: 0,
				amount: 3,
				moveSpeed: 50,
				oneContact: false,
				size: 1
			},
		},
	}
}

function System_Create_Objects(){
	if (!stageCreateFlag)	return 0;

	if (room == Room_Tes){
		instance_create_depth(x, y, -9999, Object_GUI);
		global.Tower = instance_create_depth(room_width / 2, room_height / 2, 0, Object_Tower); 
	}
	
	stageCreateFlag = false;
}

function System_SlowMotion(){
	if (global.Mouse.selectedCharacter != -1){
		global.slowMotion = true;
		global.slowMoTimer += global.slowMoMax / (SECOND * 2);
		global.slowMoTimer = global.slowMoTimer >= global.slowMoMax ? global.slowMoMax : global.slowMoTimer;
	}	
	
	if (mouse_check_button_released(mb_right)){
		global.slowMotion = false;
		global.slowMoTimer = 0;
	}
	
}

function System_Spawn_Enemies(){
	if (!instance_exists(TWR))	return 0; 
    if !instance_exists(Object_SpawnEnemy) and BossFlag == false{
        for(var i = 0; i <= NumPortal + 1; i++){
			var maxDistance = 2300;
	        var minDistance = 1000;
	        var Spawn_Direction = random(360);
	        var dist = random_range(minDistance, maxDistance);
	        instance_create_depth(Object_Tower.x + lengthdir_x(dist, Spawn_Direction), Object_Tower.y + lengthdir_y(dist, Spawn_Direction), 0, Object_SpawnEnemy);
		}
	}else if !instance_exists(Object_SpawnEnemy) and BossFlag == true{
			var maxDistance = 2300;
	        var minDistance = 1000;
	        var Spawn_Direction = random(360);
	        var dist = random_range(minDistance, maxDistance);
			var BossPortal = instance_create_depth(Object_Tower.x + lengthdir_x(dist, Spawn_Direction), Object_Tower.y + lengthdir_y(dist, Spawn_Direction), 0, Object_SpawnEnemy);
			BossPortal.FlagBossExists = false;
	}
}

function System_CharacterEnemyInfo(){
	EnemyCharacters = {
		Enemy1: {
		Speed : 2,
		HP : 4,
		AtackTime : SECOND * 1.5
		},
		Enemy2: {
		Speed : 4,
		HP : 3,
		AtackTime : SECOND 
		},
		Enemy3: {
		Speed : 3,
		HP : 2,
		AtackTime : SECOND * 2
		},
		Enemy4: {
		Speed : 2,
		HP : 5,
		AtackTime : SECOND * 3
		},
		Enemy5: {
		Direction : 0,// point_direction(Object_SpawnEnemy.x, Object_SpawnEnemy.y, Object_Tower.x, Object_Tower.y) + (irandom(30) * irandom_range(-1,1)),
		Speed : 2,
		HP : 2,
		AtackTime : SECOND * 3
		},
		EnemyBoss: {
		Speed : 2,
		HP : 100,
		AtackTime : SECOND * 4
		}
	}
}

function System_SpawnCharacter(girl){
	var teamSize = array_length(playerTeam);
	var dir = random(360);
	var lgth = random_range(150, 200);
	
	var _x = TWR.x + lengthdir_x(lgth, dir);
	var _y = TWR.y + lengthdir_y(lgth, dir);
	var char = instance_create_depth(TWR.x, TWR.y, depth - 1, Object_Character, {name: girl});
	char.moveFlag = true;
	char.targetPosition = [_x, _y];
	playerCharacters[teamSize] = char;
	playerTeam[teamSize] = girl;
}

function System_Menu(){
	if (!menuCreateFlag)	return 0;
	audio_stop_all();
	audio_play_sound(Music_MainMenu, 1, true);
	if ButtomFlag == true{
		var Options = ["Start", "Prologo", "Manual", "Creditos", "Exit"];
		for(var i = 0; i < array_length(Options); i ++){
			instance_create_depth(200, 200 + (100 * i), 0, Object_Buttom, {name : Options[i]});
		}
		ButtomFlag = false;
	}	
	menuCreateFlag = false;
}

function System_LoveLevelUp(){
	if (love >= loveNextLevel){
		love -= loveNextLevel;
		loveNextLevel = floor(loveNextLevel + 5 * random_range(0.6, 1.2));
		loveLevel ++;
		global.LevelUpEvent = true;
	}
}

function LevelUpEnemy(){
	var time = SECOND * 60 * LevelEnemy;
	if (DfTimer >= time){
		LevelEnemy ++;
		if (LevelEnemy % 3 == 0)	NumPortal ++;
		if (LevelEnemy == 15 or LevelEnemy == 5 or LevelEnemy == 10)	BossFlag = true;
	}
}

function System_StageCharacterSpawn(){
	if (array_length(recruitedGirls) > array_length(playerTeam)){
		System_SpawnCharacter(recruitedGirls[array_length(recruitedGirls) - 1]);
	}
}

function System_GameOverEvent(){
	if (global.GameOverEvent)	return 0;
	room_goto(Room_GameOver);	
}

function System_YouWin(){
	if FlagYouWin == true{
		if TimerWin <= 0{
			instance_destroy();
			room_goto(Room_YouWin);
		}else{
			TimerWin --;
		}
	}
}