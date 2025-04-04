sprite_index = asset_get_index("Sprite_LvlUpChoice_" + name);

spawning = true;
spawnSpeed = 30;
spawnSpeedFriction = 15;
targetY = Object_Camera.cameraPos[1] + Object_Camera.cameraSize[1] / 2;

floatSpeed = 1;
maxFloatDistance = 25;
floatDirection = choose(-1, 1);

thisByKey = false;