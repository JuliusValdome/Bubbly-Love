function Characters_AttackSprites(sprite){
	var dataStruct = {};
	dataStruct.size = sprite_get_width(sprite);
	dataStruct.life = (sprite_get_number(sprite) - 1) / sprite_get_speed(sprite) * SECOND;
	
	return dataStruct;
}

function Characters_CreateAttackInstance(dir, crit, mult){
	instance_create_depth(x, y, depth + 1, Object_Character_Attack, {
		creator: id,
		name: name,
		attackDirection: dir,
		info: attack,
		isCrit: crit,
		critMult: mult
		}
	);		
}