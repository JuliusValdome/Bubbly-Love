Mouse_Characters_Move();
//Mouse_Protagonist_Move();
Mouse_CharactersToTower();

if (room == Room_GameOver){
	if (mouse_check_button(mb_left)){	
		with(SYS){
			System_GameOver_VariablesReset();
		}
		room_goto(Room_Menu);
	}
}

if (room == Room_Tes){
	image_xscale = 2;
	image_yscale = 2;
}

if (room == Room_Manual){
	if (mouse_check_button_pressed(mb_left)){
		SYS.ButtomFlag = true;
		SYS.menuCreateFlag = true;
		room_goto(Room_Menu);	
	}
}

if (room == Room_Creditos){
	if (mouse_check_button_pressed(mb_left)){
		SYS.ButtomFlag = true;
		SYS.menuCreateFlag = true;
		room_goto(Room_Menu);	
	}
}

if (room == Room_YouWin){
	if (mouse_check_button(mb_left)){	
		with(SYS){
			System_GameOver_VariablesReset();
		}
		room_goto(Room_Menu);
	}
}