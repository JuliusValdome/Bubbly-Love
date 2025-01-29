if (room != Room_Tes)	return 0;

if (global.LevelUpEvent){
	gameOverTransitionAlphaBlack += 1 / (SECOND * 2);
	//draw_sprite_ext(Sprite_BlackScreen, 0, room_width / 2, room_height / 2, 100, 100, 0, c_white, gameOverTransitionAlphaBlack);
}

draw_set_font(Font_Default);