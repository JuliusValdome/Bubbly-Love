Script_SpawnEnemy();

depth = -y;

if FlagBossExists == false{
	audio_stop_sound(Music_Stage);
	audio_play_sound(Music_Boss, 1, true, 0.4);
	sprite_index = Sprite_SpawnBoss;
	instance_create_depth(x, y, 0, Object_Enemy, {name : "EnemyBoss"});
	FlagBossExists = true;
	FlagStopEnemy = true;
}