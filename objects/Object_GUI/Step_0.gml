if (global.LevelUpEvent and !instance_exists(Object_LevelUpChoice) and !selectedBubble){
	if (global.StartLevelUp){
		ds_list_shuffle(SYS.availableGirls);
		audio_play_sound(SFX_SpawnBubble, 0, false, 0.6);
		for(var i = 0; i < 3; i++){
			var nme = SYS.availableGirls[| i];
			instance_create_depth(Object_Camera.cameraPos[0] + 750 + 550 * i, Object_Camera.cameraPos[1] + Object_Camera.cameraSize[1] + 100 * i, depth, Object_LevelUpChoice, {type: "girl", name: nme});
		}
		global.StartLevelUp = false;
	}else{
		var choices = [];
		var girls = ds_list_size(SYS.availableGirls);
		var items = ds_list_size(SYS.availablePassives);
		ds_list_shuffle(SYS.availableBoosts);
		var fullList = ds_list_create();
		
		if (girls + items == 0){
			for(var i = 0; i < 3; i++){
				ds_list_add(fullList, {name: SYS.availableBoosts[| i], type: "boost"});
			}
		}else{
			for(var i = 0; i < girls; i++){
				ds_list_add(fullList, {name: SYS.availableGirls[| i], type: "girl"});	
			}
			for(var i = 0; i < items; i++){
				ds_list_add(fullList, {name: SYS.availablePassives[| i], type: "passive"});	
			}
			if(ds_list_size(fullList) < 4){
				var missing = 3 - ds_list_size(fullList);
				for (var i = 0; i < missing; i++){
					ds_list_add(fullList, {name: SYS.availableBoosts[| i], type: "boost"});
				}
			}
		}
		ds_list_shuffle(fullList);
		for (var i = 0; i < 3; i++){
			choices[i] = fullList[| i];
			audio_play_sound(SFX_SpawnBubble, 0, false, 0.6, 15);
		}
		for(var i = 0; i < array_length(choices); i++){
			var nme = fullList[| i].name;
			var tpe = fullList[| i].type;
			instance_create_depth(Object_Camera.cameraPos[0] + 750 + 550 * i, Object_Camera.cameraPos[1] + Object_Camera.cameraSize[1] + 100 * i, depth, Object_LevelUpChoice, {name: nme, type: tpe});
		}
		global.StartLevelUp = false;
	}
}

if (selectedBubble){
	resumeTimer --;
	if (resumeTimer <= 0){
		resumeTimer = resumeTimerBase;
		global.LevelUpEvent = false;
		selectedBubble = false;
	}
}