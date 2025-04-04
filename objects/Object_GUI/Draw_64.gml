if (TWR.gameOverTransition){
		draw_sprite_ext(Sprite_BlackScreen, 0, room_width / 2, room_height / 2, 100, 100, 0, c_white, 0.25);
}else{
	var team = SYS.playerTeam;
	var teamSize = array_length(team);

	for (var i = 0; i < teamSize; i++){	
		var charPort = asset_get_index("Sprite_Character_" + team[i] + "_Portrait");
		var windowMargin = 50;
		var portraitMargin = 25;
		
		var spriteW = sprite_get_width(charPort);
	
		//var availableWidth = windowSize[0] - (windowMargin * 2);
		var totalPortraitWidth = teamSize * spriteW + (teamSize - 1) * portraitMargin;
	
		var startX = (windowSize[0] - totalPortraitWidth) / 2;
		var xPos = startX + i * (sprite_get_width(charPort) + portraitMargin);
		var yPos = windowSize[1] - sprite_get_height(charPort);
	
		draw_sprite(charPort, 0, xPos, yPos);
		draw_set_font(Font_SmallLevel);
		draw_set_color(c_white);
		draw_text(xPos - sprite_get_width(charPort) / 2 + 20, yPos - sprite_get_height(charPort) / 2 - 4, string(SYS.girlsLevel[? team[i]]));
		draw_set_color(c_black);
		draw_text(xPos - sprite_get_width(charPort) / 2 + 20, yPos - sprite_get_height(charPort) / 2 - 4, string(SYS.girlsLevel[? team[i]]));
		draw_set_font(Font_Default);
		draw_set_color(c_white);
	}

	var healthP = TWR.Health / TWR.maxHealth;
	var loveP = SYS.love / SYS.loveNextLevel;

	draw_sprite(GUI_Border, 0, x, y);
	draw_sprite(GUI_Timer, 0, camera.cameraSize[0] / 4, 4);
	draw_sprite(GUI_LoveBar_Bottom, 0, 60, 48);
	draw_sprite(GUI_BoyFriendHealth_Bottom, 0, camera.cameraSize[0] / 2 - 32, 48);

	draw_sprite_ext(GUI_LoveBar_Top, 0, 63, 48, loveP, 1, 0, c_white, 1);
	draw_sprite_ext(GUI_BoyFriendHealth_Top, 0, camera.cameraSize[0] / 2 - 35, 48, healthP, 1, 0, c_white, 1);

	draw_sprite(GUI_LoveBar_Icon, 0, 60, 48);
	draw_sprite(GUI_BoyFriendHealth_Icon, 0, camera.cameraSize[0] / 2 - 32, 48);

	var time = SYS.DfTimer / SECOND; // Tiempo en segundos
	var minutes = floor(time / 60);  // Calcula los minutos (cada 60 segundos)
	var seconds = floor(time) mod 60; // Calcula los segundos restantes (sobrantes de los minutos)
	var minutesAux = minutes < 10 ? "0" + string(minutes) : string(minutes);
	var secondsAux = seconds < 10 ? "0" + string(seconds) : string(seconds);
	draw_text(camera.cameraSize[0] / 4, 0, minutesAux + ":" + secondsAux);
}
