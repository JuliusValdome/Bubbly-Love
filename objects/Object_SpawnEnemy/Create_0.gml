DestroyCont = irandom_range(4, 7);
SpawnCont = SECOND * random_range(2.5, 4);
Direction = x > TWR.x ? 1 : -1;
image_xscale = Direction;

enemyList = ds_list_create();

for(var i = 0; i <= 4; i ++){
	ds_list_add(enemyList, "Enemy1");
}

for(var i = 0; i <= 4; i ++){
	ds_list_add(enemyList, "Enemy2");
}

for(var i = 0; i <= 3; i ++){
	ds_list_add(enemyList, "Enemy3");
}

for(var i = 0; i <= 2; i ++){
	ds_list_add(enemyList, "Enemy4");
}

for(var i = 0; i <= 2; i ++){
	ds_list_add(enemyList, "Enemy5");
}

ds_list_shuffle(enemyList);

FlagBossExists = true;
FlagStopEnemy = false;