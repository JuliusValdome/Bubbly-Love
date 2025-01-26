function Sprite_Selection(){ 
	sprite_index = asset_get_index("Sprite_" + name);
}

function Buttom_Function(){
	if place_meeting(x, y, Object_Mouse){
		if mouse_check_button_pressed(mb_left){
			switch(name){
				case "Start":
					room_goto(Room_Tes);
					audio_stop_all();
					audio_play_sound(Music_Stage, 1, true, 0.6);
					break;
				case "Prologo":
					room_goto(Room_Prologue);
					break;
				case "Manual":
					room_goto(Room_Manual);
					break;
				case "Creditos":
					room_goto(Room_Creditos);
					break;
				case "Exit":
					game_end();
					break;
			}
		}
	}
}
		