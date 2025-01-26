function Script_EnemyDamage(){
	if place_meeting(x, y, Object_Tower){
		instance_place(x, y, Object_Tower).Health -= Damage;
		FlagDamage = false;
	}
}