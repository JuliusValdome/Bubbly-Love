if (spawning){
	y -= spawnSpeed;
	spawnSpeed -= (spawnSpeedFriction / SECOND);
	spawnSpeed = spawnSpeed <= 1 ? 1 : spawnSpeed;
	if (y <= targetY){
		spawning = false;
	}
}else{
	y += floatSpeed * floatDirection;
	if (y <= targetY + maxFloatDistance * floatDirection){
		floatDirection = 1;
	}else if (y >= targetY + maxFloatDistance * floatDirection){
		floatDirection = -1;
	}
}

if (place_meeting(x, y, global.Mouse) and mouse_check_button_pressed(mb_left)) or thisByKey{
	switch(type){
		case "girl":
			with(SYS){
				var pos = ds_list_find_index(availableGirls, other.name);
				var lvl = ds_map_find_value(girlsLevel, other.name);
				ds_map_replace(girlsLevel, other.name, lvl + 1);
				if (lvl == 0){
					recruitedGirls[array_length(recruitedGirls)] = other.name;
				}else if(lvl == 5){
					ds_list_delete(availableGirls, pos);
				}
			}
			break;
		case "passive":
			with(SYS){
				var pos = ds_list_find_index(availablePassives, other.name);
				var lvl = ds_map_find_value(itemsLevel, other.name);
				ds_map_replace(itemsLevel, other.name, lvl + 1);
				if (lvl == 0){
					passiveItems[array_length(recruitedGirls)] = other.name;
				}else if(lvl == 4){
					ds_list_delete(availablePassives, pos);
				}
			}
			break;
	}
	instance_destroy(Object_LevelUpChoice);
	Object_GUI.selectedBubble = true;
}

switch(bubble){
	case 0:
		if (keyboard_check_pressed(vk_numpad1) or keyboard_check_pressed(ord("1")))
			thisByKey = true;
		break;
	case 1:
		if (keyboard_check_pressed(vk_numpad2) or keyboard_check_pressed(ord("2")))
			thisByKey = true;
		break;
	case 2:
		if (keyboard_check_pressed(vk_numpad3) or keyboard_check_pressed(ord("3")))
			thisByKey = true;
		break;
}