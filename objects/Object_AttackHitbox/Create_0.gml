if (!instance_exists(creator))	instance_destroy();

image_xscale = creator.sprite_width / 2.5;
image_yscale = creator.sprite_height / 2.5;
image_angle = creator.attackDirection;
image_alpha = 10;

offset = 0;