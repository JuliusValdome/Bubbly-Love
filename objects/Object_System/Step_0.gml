if (room == Room_Tes) {
	System_Create_Objects();
	System_GameOverEvent();
	System_SlowMotion();
	System_Spawn_Enemies();
	System_CharacterEnemyInfo();
	System_LoveLevelUp();
	LevelUpEnemy();
	System_StageCharacterSpawn();
	System_YouWin();
}else if room == Room_Menu{
	System_Menu();
}
DfTimer += 1 * SLOW;

if (keyboard_check(vk_space)){
	//SYS.FlagYouWin = true;
	//instance_create_depth(mouse_x, mouse_y, 0, Object_DropBubble, {name: "Love"});	
}