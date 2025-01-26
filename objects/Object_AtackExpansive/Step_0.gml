if image_xscale < 8{
	image_xscale += .4;
	image_yscale += .4;
}else if image_alpha > 0{
	image_alpha -= .01;
}else{
	Script_EnemyDamage();
	instance_destroy();
}
	