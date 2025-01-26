if (!instance_exists(creator)){
	instance_destroy();
}else{
	image_xscale = creator.sprite_width / 2;
	image_yscale = creator.sprite_height / 2;
}