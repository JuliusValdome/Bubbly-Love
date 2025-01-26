if (mouse_check_button_pressed(mb_left)){
	if (image_index < image_number - 1){
		image_index ++;	
	}else{
		SYS.ButtomFlag = true;
		SYS.menuCreateFlag = true;
		room_goto(Room_Menu);
	}
}