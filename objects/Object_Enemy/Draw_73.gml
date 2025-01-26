//var hlthP = Health / maxHealth;
//draw_rectangle_color(x - 20, y - 25, x + 40 * hlthP, y - 15, c_red, c_red, c_red, c_red, false);

if (gotHit and Health > 0){
	var dir = (direction < 270 and direction > 90)? 1 :  -1;
	var scale = 1 + 0.1 * hitTimerP;
	var alpha = 1 - hitTimerP * 0.5;
	var damageSprite = asset_get_index(sprite_get_name(sprite_index) + "_Damage");
	draw_sprite_ext(sprite_index, image_index, x, y, scale * dir, scale, 0, c_white, 1);
	draw_sprite_ext(damageSprite, image_index, x, y, scale * dir, scale, 0, c_white, alpha);
}