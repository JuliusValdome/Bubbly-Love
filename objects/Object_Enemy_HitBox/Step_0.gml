if (!instance_exists(creator)){
	instance_destroy();	
}else{
	if (creator.Health <= 0){
		instance_destroy();	
	}else{
		x = creator.x;
		y = creator.y;
	}
}