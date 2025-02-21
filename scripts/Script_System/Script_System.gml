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
	listedItemsDescriptions = ["Increases Movespeed", "Increases items collection radius", "Enhances the Attack Speed", "The size of the projectiles grows", "Increase the damage dealt", "Boosts the amount of attacks", "The chances of critical strikes increases", "Critical strikes are more powerful"];
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
	var lilyAttack = Characters_AttackSprites(Sprite_Character_Attack_Lily);
	var dulceAttack = Characters_AttackSprites(Sprite_Character_Attack_Dulce);
	var huaAttack = Characters_AttackSprites(Sprite_Character_Attack_Hua);
	var tanjaAttack = Characters_AttackSprites(Sprite_Character_Attack_Tanja);
	var miyukiAttack = Characters_AttackSprites(Sprite_Character_Attack_Miyuki);
	
	Characters = ds_map_create();
	var Lily = {
		moveSpeed: 5,
		magnet: 30,
		attacks: 1,	
		cadence: 0.5 * SECOND,
		attackInfo: {
			critical: 1,
			multiplier: 2.5,
			range: lilyAttack.size * 0.8,
			moveSpeed: 0,
			offset: lilyAttack.size * 0.7,
			life: lilyAttack.life * 0.75,
			damage: 5,
			size: 1,
			finite: false,
			sound: SFX_Swing
		}
	}
	var Dulce = {
		moveSpeed: 4,
		magnet: 50,
		attacks: 1,	
		cadence: 0.4 * SECOND,
		attackInfo: {
			critical: 1,
			multiplier: 3,
			range: dulceAttack.size * 0.8,
			moveSpeed: 1,
			offset: dulceAttack.size * 0.5,
			life: dulceAttack.life * 1.25,
			damage: 3,
			size: 1,
			finite: false,
			sound: SFX_Swing
		}
	}	
	var Hua = {
		moveSpeed: 2,
		magnet: 75,
		attacks: 1,	
		cadence: 0.75 * SECOND,
		attackInfo: {
			critical: 4,
			multiplier: 2,
			range: huaAttack.size * 10,
			moveSpeed: 30,
			offset: huaAttack.size * 0.05,
			life: huaAttack.life * 5,
			damage: 1.5,
			size: 1,
			finite: true,
			sound: SFX_Swing
		}
	}
	var Tanja = {
		moveSpeed: 3,
		magnet: 40,
		attacks: 1,	
		cadence: 0.15 * SECOND,
		attackInfo: {
			critical: 1,
			multiplier: 5,
			range: tanjaAttack.size * 7,
			moveSpeed: 15,
			offset: tanjaAttack.size * 0.1,
			life: tanjaAttack.life * 4,
			damage: 7,
			size: 1,
			finite: true,
			sound: SFX_Fireball
		}
	}
	var Miyuki = {
		moveSpeed: 7,
		magnet: 20,
		attacks: 2,	
		cadence: 0.7 * SECOND,
		attackInfo: {
			critical: 1,
			multiplier: 5,
			range: miyukiAttack.size * 2,
			moveSpeed: 50,
			offset: miyukiAttack.size * 0.1,
			life: miyukiAttack.life * 0.75,
			damage: 4,
			size: 1,
			finite: false,
			sound: SFX_Swing
		}
	}
	
	ds_map_add(Characters, "Lily", Lily);
	ds_map_add(Characters, "Dulce", Dulce);
	ds_map_add(Characters, "Hua", Hua);
	ds_map_add(Characters, "Tanja", Tanja);
	ds_map_add(Characters, "Miyuki", Miyuki);
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
		HP : 400,
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