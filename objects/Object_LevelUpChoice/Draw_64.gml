if (!spawning){	
	if (type == "passive"){
		if (place_meeting(x, y, Object_Mouse)){
			for(var i = 0; i < array_length(SYS.listedItems); i++){
				if (SYS.listedItems[i] == name){
					draw_set_color(c_black);
					draw_rectangle(320, 170, 920, 210, false);
					draw_set_color(c_teal);
					draw_rectangle(317, 167, 917, 207, false);
					draw_set_color(c_black);
					draw_text(625, 150, SYS.listedItemsDescriptions[i]);
					draw_set_color(c_white);
				}
			}
		}
	}
}