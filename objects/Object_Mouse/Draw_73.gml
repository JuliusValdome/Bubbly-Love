if (selectedCharacter != -1 and !global.LevelUpEvent){
	with(selectedCharacter){
		draw_sprite_ext(Sprite_Move_Character, 0, x, y, 1, 1, 0, c_white, 0.5);
	}
	draw_sprite(Sprite_Move_Character, 1, x, y);
	draw_sprite_ext(Sprite_Move_Line, 0, selectedCharacter.x, selectedCharacter.y, point_distance(x, y, selectedCharacter.x, selectedCharacter.y) / 20, 1, point_direction(selectedCharacter.x, selectedCharacter.y, x, y), c_white, 1);
}

draw_self();