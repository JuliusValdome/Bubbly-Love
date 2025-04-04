if (spawning) return 0;

if (place_meeting(x, y, Object_Mouse)){
	var list = type == "girl" ? SYS.listedGirls : SYS.listedItems;
	var descriptions = type == "girl" ? SYS.listdGirlsDescriptions : SYS.listedItemsDescriptions;
	var text = "";	
	for(var i = 0; i < array_length(list); i++){
		if (list[i] == name){
			text = descriptions[i];
			if (type == "girl"){
				var lvl = ds_map_find_value(SYS.girlsLevel, name);
				text = descriptions[i][lvl];
			}else{
				text = descriptions[i];
			}
		}
	}	
	draw_set_color(c_black);
	draw_rectangle(320, 170, 920, 210, false);
	draw_set_color(c_teal);
	draw_rectangle(317, 167, 917, 207, false);
	draw_set_color(c_black);
	draw_text(625, 150, text);
	draw_set_color(c_white);
	
}