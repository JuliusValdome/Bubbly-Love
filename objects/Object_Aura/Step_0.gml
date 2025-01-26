DestroyCont -= 1 * SLOW;
if instance_exists(creator){
	/*if creator.FlagMove <= 0{
		creator.FlagMove = SECOND * 5;
	}*/
	image_xscale += (1 / SECOND * 0.25) * SLOW;
	image_yscale += (1 / SECOND * 0.15) * SLOW;
	if DestroyCont <= 0{
		creator.FlagMove = SECOND * 5;
		creator.speed = 2;		
		creator.direction = point_direction(creator.x, creator.y, Object_Tower.x, Object_Tower.y) + (irandom(90) * irandom_range(-1,1));
		instance_destroy();
	}
}else{
	instance_destroy();
}
