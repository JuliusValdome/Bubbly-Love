if (state == "Lose"){
	sprite_index = asset_get_index("Sprite_Character_" + name + "_" + state);
	if (instance_exists(Object_Character_Attack)){
		with(Object_Character_Attack){
			instance_destroy();	
		}
	}
}else{
	Stats_Update();
	Character_Move();
	Character_Attack();
	Character_Sprite();
}