if (crit){
	draw_set_color(c_black);
	draw_text(x-1, y-1, string(damage));
	draw_text(x+1, y+1, string(damage));
	draw_set_color(c_red);
	draw_text(x, y, string(damage));
}else{
	draw_set_color(c_black);
	draw_text(x-1, y-1, string(damage));
	draw_text(x+1, y+1, string(damage));
	draw_set_color(c_yellow);
	draw_text(x, y, string(damage));
}

draw_set_color(c_white);