if (!instance_exists(creator))	return 0;
switch(creator.name){
	case "A": offSet = 0;	break;
	case "B": offSet = 200; break;
}

image_xscale = creator.sprite_width / 1.5;
image_yscale = creator.sprite_height / 1.5;
image_angle = creator.attackDirection;
image_alpha = 0;